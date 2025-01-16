`include "sumador.v"
`timescale 1ps/1ps

module sumador8b_tb();
    reg [7:0] a_tb,b_tb;
    wire [8:0] sum_tb;
    wire cout_tb;

    sumador8b uut(
        .a(a_tb),
        .b(b_tb),
        .sum(sum_tb),
        .cout(cout_tb)
    );
    
    initial begin
        a_tb = 8'd15;
        b_tb = 8'd12;
        #1;
        a_tb = 8'd5;
        b_tb = 8'd5;
        #1;
        a_tb = 8'd6;
        b_tb = 8'd13;
        #1;
        a_tb = 8'd255;
        b_tb = 8'd255;
        #1;
    end
    
    initial begin: TEST_CASE
        $dumpfile("sumador_tb.vcd");
        $dumpvars(-1,uut);
        #4 $finish;     
    end

endmodule



