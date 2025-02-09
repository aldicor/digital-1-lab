module top(clk_50MHz, tf0, tf1, tf2,
            detect_ns, detect_sn, detect_ew, detect_we,
            en, rs, rw, D);
    input clk_50MHz, detect_ns, detect_sn, detect_ew, detect_we; 
    output [2:0] tf0, tf1, tf2;
    output en,rs,rw;
    output [7:0] D;
    
    wire [13:0] count_ns, count_sn, count_ew, count_we;

    wire clk_2Hz;
    clockdiv #(.n(25_000_000)) clock_2hz_ins(.clkin(clk_50MHz), .clkout(clk_2Hz));

    car_count ns_ins(.clk(clk_2Hz),.detector(detect_ns), .count(count_ns));
    car_count sn_ins(.clk(clk_2Hz),.detector(detect_sn), .count(count_sn));
    car_count ew_ins(.clk(clk_2Hz),.detector(detect_ew), .count(count_ew));
    car_count we_ins(.clk(clk_2Hz),.detector(detect_we), .count(count_we));

    wire [3:0] t_add;
    wire [4:0] counter_s; //
    wire [4:0] counter_car; 
    wire [2:0] n; 
    wire [2:0] state;
    traffic_contrl traffic_contrl_ins(.clk(clk_2Hz), .tf0(tf0), .tf1(tf1), .tf2(tf2), 
                                    .count_ns_4b(count_ns[3:0]),.count_sn_4b(count_sn[3:0]), 
                                    .count_ew_4b(count_ew[3:0]), .count_we_4b(count_we[3:0]),
                                    .counter_s(counter_s), .counter_car(counter_car), .t_add(t_add), .state(state), .n(n));

    wire [15:0] bcd_ns, bcd_sn, bcd_ew, bcd_we;

    bin2BCD ns_bcd_ins(.num(count_ns), .bcd(bcd_ns));
    bin2BCD sn_bcd_ins(.num(count_sn), .bcd(bcd_sn));
    bin2BCD ew_bcd_ins(.num(count_ew), .bcd(bcd_ew));
    bin2BCD we_bcd_ins(.num(count_we), .bcd(bcd_we));

    wire [7:0] bcd_counter_s, bcd_counter_car, bcd_t_add;

    bin2BCD counter_s_bcd_ins(.num({9'd0 , counter_s/2}), .bcd(bcd_counter_s));
    bin2BCD counter_car_bcd_ins(.num({9'd0, counter_car}), .bcd(bcd_counter_car));
    bin2BCD t_add_bcd_ins(.num({10'd0,t_add/2}), .bcd(bcd_t_add));

    wire [255:0] message; 

    status_message message_ins(.message(message),.state(state), .tfst({tf2[2:1], tf1[2:1], tf0[2:1]}),
                             .ns_count(bcd_ns), .sn_count(bcd_sn), .ew_count(bcd_ew), .we_count(bcd_we), 
                             .counter_s(bcd_counter_s), .t_add(bcd_t_add), .counter_car(bcd_counter_car), .n(n));
    
    wire clk_62hz;

    clockdiv #(.n(800_000)) clock_62hz_ins(.clkin(clk_50MHz), .clkout(clk_62hz));

    display dis16x2(.clock(clk_62hz), .message_in(message),
                            .en(en), .rs(rs), .rw(rw), .D(D));
    
endmodule