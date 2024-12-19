`include "nivelcarga.v"

`timescale 1ps/1ps

module nivelcarga_tb();
    reg [3:0] A_tb, B_tb;
    wire green_tb, yellow_tb, critical_tb;

    nivelcarga uut(
        .A(A_tb),
        .B(B_tb),
        .green(green_tb),
        .yellow(yellow_tb),
        .critical(critical_tb)
    );
    
    initial begin
        A_tb = 4'b0000;
        B_tb = 4'b0000;
        #1;
        A_tb = 4'b0001;
        B_tb = 4'b0001;
        #1;
        A_tb = 4'b0010;
        B_tb = 4'b0010;
        #1;
        A_tb = 4'b0011;
        B_tb = 4'b0011;
        #1;
        A_tb = 4'b0100;
        B_tb = 4'b0100;
        #1;
        A_tb = 4'b0101;
        B_tb = 4'b0101;
        #1;
        A_tb = 4'b0110;
        B_tb = 4'b0110;
        #1;
        A_tb = 4'b0111;
        B_tb = 4'b0111;
        #1;
        A_tb = 4'b1000;
        B_tb = 4'b1000;
        #1;
        A_tb = 4'b1001;
        B_tb = 4'b1001;
        #1;
        A_tb = 4'b1010;
        B_tb = 4'b1010;
        #1;
        A_tb = 4'b1011;
        B_tb = 4'b1011;
        #1;
        A_tb = 4'b1100;
        B_tb = 4'b1100;
        #1;
        A_tb = 4'b1101;
        B_tb = 4'b1101;
        #1;
        A_tb = 4'b1110;
        B_tb = 4'b1110;
        #1;
        A_tb = 4'b1111;
        B_tb = 4'b1111;
        #1;
    end

    initial begin: TEST_CASE
        $dumpfile("nivelcarga_tb.vcd");
        $dumpvars(-1, uut);
        #20 $finish; 
        
    end
endmodule