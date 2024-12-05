`include "restador.v"

module nivelcarga(A,B,green,yellow,critical);
    input [3:0] A,B;
    output green, yellow, critical;
    wire [3:0] suma;
    wire co_s, co_r;
    wire in;
    assign in = 1'b1;

    adder4b    sumaAB(A,B,co_s, suma);
    restador resta(suma,co_r);

    assign green    = in&co_s;
    assign yellow   = in&~co_s&co_r;
    assign critical = in&~co_s&~co_r; 

endmodule