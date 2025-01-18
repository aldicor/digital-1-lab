`include "verilog/freq_div.v"
`include "verilog/car_count.v"
`include "verilog/bin2BCD.v"
`include "verilog/display.v"

module visualization(
    detect_ns, detect_sn, detect_ew, detect_we, clock,
    enable, rs, rw, D);
    input detect_ns, detect_sn, detect_ew, detect_we, clock;
    output enable, rs, rw;
    output [7:0] D;
    
    wire clock1us;

    clockdiv #(.n(500000)) clk10us_ins (.clkin(clock), .clkout(clock1us));

    wire [13:0] count_ns, count_sn, count_ew, count_we;

    car_count ns_ins(.detector(detect_ns), .count(count_ns));
    car_count sn_ins(.detector(detect_sn), .count(count_sn));
    car_count ew_ins(.detector(detect_ew), .count(count_ew));
    car_count we_ins(.detector(detect_we), .count(count_we));

    wire [15:0] bcd_ns, bcd_sn, bcd_ew, bcd_we;

    bin2BCD ns_bcd_ins(.num(count_ns), .bcd(bcd_ns));
    bin2BCD sn_bcd_ins(.num(count_sn), .bcd(bcd_sn));
    bin2BCD ew_bcd_ins(.num(count_ew), .bcd(bcd_ew));
    bin2BCD we_bcd_ins(.num(count_we), .bcd(bcd_we));

    display dis16x2(.clock(clock1us),
        .ns_count(bcd_ns), .sn_count(bcd_sn), .ew_count(bcd_ew), .we_count(bcd_we),
        .rs(rs), .rw(rw), .en(enable), .D(D));
    
endmodule