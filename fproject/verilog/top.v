`include "verilog/display.v"
`include "verilog/status_message.v"
`include "verilog/car_count.v"
`include "verilog/bin2BCD.v"
`include "verilog/clockdiv.v"
`include "verilog/traffic_contrl.v"
`include "verilog/trafficlight.v"
`include "verilog/servo_contrl.v"

module top(clk_50MHz, tf0, tf1, tf2,
            detect_ns, detect_sn, detect_ew, detect_we,
            en, rs, rw, D, pwm, vel);
    input clk_50MHz, detect_ns, detect_sn, detect_ew, detect_we; 
    output [3:0] pwm;
    input [1:0] vel;
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

    wire [4:0] t_add;
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

    bin2BCD counter_s_bcd_ins(.num({9'd0 , counter_s>>1}), .bcd(bcd_counter_s));
    bin2BCD counter_car_bcd_ins(.num({9'd0, counter_car}), .bcd(bcd_counter_car));
    bin2BCD t_add_bcd_ins(.num({9'd0,t_add>>1}), .bcd(bcd_t_add));

    wire [255:0] message; 

    status_message message_ins(.message(message),.state(state), .tfst(~{tf2[2:1], tf1[2:1], tf0[2:1]}),
                             .ns_count(bcd_ns), .sn_count(bcd_sn), .ew_count(bcd_ew), .we_count(bcd_we), 
                             .counter_s(bcd_counter_s), .t_add(bcd_t_add), .counter_car(bcd_counter_car), .n(n));
    
    wire clk_62hz;

    clockdiv #(.n(800_000)) clock_62hz_ins(.clkin(clk_50MHz), .clkout(clk_62hz));

    display dis16x2(.clock(clk_62hz), .message_in(message),
                            .en(en), .rs(rs), .rw(rw), .D(D));
    

    wire clk_10Hz, clk_10KHz; 
    clockdiv #(.n(5_000)) clock_10KHz_ins(.clkin(clk_50MHz), .clkout(clk_10KHz));
    clockdiv #(.n(1_000)) clock_10Hz_ins(.clkin(clk_10KHz), .clkout(clk_10Hz));
    servos_contr servos_ins(.pwm(pwm), .vel(vel),
                             .tfst(~{tf2[2:1], tf1[2:1], tf0[2:1]}),
                             .clk_10Hz(clk_10Hz), .clk_10KHz(clk_10KHz));

endmodule