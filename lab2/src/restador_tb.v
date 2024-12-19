`include "restador.v"
`timescale 1ps/1ps

module restadortb();
    reg [3:0] suma_tb;
    wire Cout_co_tb;

    restador uut(
        .suma(suma_tb),
        .cout_co(Cout_co_tb)
    );
    
    initial begin
        suma_tb = 4'b0000;
        #1;
        suma_tb = 4'b0001;
        #1;
        suma_tb = 4'b0010;
        #1;
        suma_tb = 4'b0011;
        #1;
        suma_tb = 4'b0100;
        #1;
        suma_tb = 4'b0101;
        #1;
        suma_tb = 4'b0110;
        #1;
        suma_tb = 4'b0111;
        #1;
        suma_tb = 4'b1000;
        #1;
        suma_tb = 4'b1001;
        #1;
        suma_tb = 4'b1010;
        #1;
        suma_tb = 4'b1011;
        #1;
        suma_tb = 4'b1100;
        #1;
        suma_tb = 4'b1101;
        #1;
        suma_tb = 4'b1110;
        #1;
        suma_tb = 4'b1111;
        #1;
    end

    initial begin: TEST_CASE
        $dumpfile("restador_tb.vcd");
        $dumpvars(-1, uut);
        #20 $finish; 
        
    end
endmodule