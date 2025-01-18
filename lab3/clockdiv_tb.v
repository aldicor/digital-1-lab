`include "clockdiv.v"
`timescale 1ns/1ns

module tb_clockdiv;
    reg clin;
    wire clout, clout2, clout3;

    clockdiv #(
        .div(16'd4)
    ) uut (             
        .clin(clin),
        .clout(clout)
    );

    clockdiv #(
        .div(16'd2)
    ) uut2 (             
        .clin(clin),
        .clout(clout2)
    );

    clockdiv #(
        .div(16'd3)
    ) uut3 (             
        .clin(clin),
        .clout(clout3)
    );

    initial begin
        clin = 0;
        forever #50 clin = ~clin;
    end

    initial begin: TEST_CASE
        $dumpfile("clockdiv_tb.vcd");
        $dumpvars(-1, uut,uut2,uut3);
        #2000 $finish;  
    end
endmodule