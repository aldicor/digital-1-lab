`include "sumador.v"
`timescale 1ps/1ps

module sumador_tb();
    reg [7:0] a_tb,b_tb;
    reg [1:0]  sel_tb;
    wire [8:0] sum_tb;

    sumador uut(
        .sel(sel_tb),
        .baterias({a_tb, b_tb}),
        .sum(sum_tb)
    );
    
    initial begin
        a_tb = 8'b11111111;
        b_tb = 8'b11111111;
        sel_tb = 1'b0;
        #1;
        sel_tb = 1'b1;
        #1;
        a_tb = 8'b11111111;
        b_tb = 8'd0;
        sel_tb = 1'b0;
        #1;
        sel_tb = 1'b1;
        #1
        a_tb = 8'd6;
        b_tb = 8'd13;
        sel_tb = 1'b0;
        #1;
        a_tb = 8'd80;
        b_tb = 8'd65;
        sel_tb = 1'b1;
        #1;
    end
    
    initial begin: TEST_CASE
        $dumpfile("sumador_tb.vcd");
        $dumpvars(-1,uut);
        #6 $finish;     
    end

endmodule



