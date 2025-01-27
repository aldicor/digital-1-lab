`include "binBCD.v"
`timescale 1ps/1ps

module binBCD_tb();
    reg  [8:0] sum_tb;
    reg  [1:0] sel_tb;
    wire [3:0] bcd;

    bin2BCD uut(
        .sum(sum_tb),
        .sel(sel_tb)
    );
    initial begin
        sum_tb = 9'd471;
        sel_tb = 2'd0;
        #1;
        sum_tb = 9'd471;
        sel_tb = 2'd1;
        #1;
        sum_tb = 9'd471;
        sel_tb = 2'd2;
        #1;
        sum_tb = 9'd471;
        sel_tb = 2'd3;
        #1;
    end
    initial begin: TEST_CASE
        $dumpfile("binBCD_tb.vcd");
        $dumpvars(-1,uut);
        #5 $finish;
    end

endmodule