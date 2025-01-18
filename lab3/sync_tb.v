`include "sync.v"
`timescale 1ns/1ns

module binBCD_tb();
    reg  [8:0] sum_tb;
    reg clin;

    sync uut(
        .sum(sum_tb),
        .clock(clin)
    );
    initial begin
        clin = 0;
        forever #20 clin = ~clin;
    end

    initial begin
        sum_tb = 9'b0;
        #10000000;
        sum_tb = 9'd471;
        #10000000;
        sum_tb = 9'd500;
        #10000000;
        sum_tb = 9'd471;
        #10000000;
    end
    initial begin: TEST_CASE
        $dumpfile("sync.vcd");
        $dumpvars(-1,uut);
        #100000000 $finish;
    end

endmodule