`include "clockdiv.v"
`timescale 1ns/1ns

module tb_clockdiv;
    reg clin;
    wire clout, clout2, clout3;

    clockdiv #(2) uut (             
        .clkin(clin),
        .clkout(clout)
    );

    clockdiv #(3) uut2 (             
        .clkin(clin),
        .clkout(clout2)
    );

    clockdiv #(4) uut3 (             
        .clkin(clin),
        .clkout(clout3)
    );

    initial begin
        clin= 0;
        forever #50 clin = ~clin;
    end

    initial begin: TEST_CASE
        $dumpfile("clockdiv_tb.vcd");
        $dumpvars(-1, uut,uut2,uut3);
        #2000 $finish;  
    end
endmodule