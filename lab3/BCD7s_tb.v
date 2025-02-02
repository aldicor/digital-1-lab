`include "BCD7s.v"
`timescale 1ps/1ps
module BCD7s_tb();
    reg [3:0] BCD_tb;
    wire [6:0] ssg_tb;

    BCDssg uut(
        .BCD(BCD_tb),
        .ssg(ssg_tb)
    );
    initial begin
        BCD_tb = 4'h1;
        #1;
        BCD_tb = 4'h2;
        #1
        BCD_tb = 4'h3;
        #1
        BCD_tb = 4'h4;
        #1;
        BCD_tb = 4'h5;
        #1;
        BCD_tb = 4'h6;
        #1;
        BCD_tb = 4'h7;
        #1;
        BCD_tb = 4'h8;
        #1;
        BCD_tb = 4'h9;
        #1;
        BCD_tb = 4'ha;
        #1;
        BCD_tb = 4'hb;
        #1;
        BCD_tb = 4'hc;
        #1;
        BCD_tb = 4'hd;
        #1;
        BCD_tb = 4'he;
        #1;
        BCD_tb = 4'hf;
        #1;
    end    
    initial begin: TEST_CASE
        $dumpfile("BCD7s_tb.vcd");
        $dumpvars(-1,uut);
        #16 $finish;
    end
endmodule


