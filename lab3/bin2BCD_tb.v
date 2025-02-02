`include "bin2BCD.v"
`timescale 1ps/1ps

module bin2BCD_tb();
    reg  [8:0] sum_tb;
    reg   clin;
    wire [3:0] bcd;

    bin2BCD uut(
        .sum(sum_tb),
        .clk(clin)
    );

    initial begin
        clin = 0;
        forever #1 clin = ~clin;
    end 

    initial begin
        sum_tb = 9'd471;
        #2;
        sum_tb = 9'd471;
        #2;
        sum_tb = 9'd471;
        #2;
        sum_tb = 9'd471;
        #2;
        sum_tb = 9'd510;
        #2;
        sum_tb = 9'd510;
        #2;
        sum_tb = 9'd510;
        #2;
        sum_tb = 9'd510;
        #2;
    end
    initial begin: TEST_CASE
        $dumpfile("bin2BCD_tb.vcd");
        $dumpvars(-1,uut);
        #20 $finish;
    end

endmodule