//`include "restador.v"
//`include "descarga.v"
//`include "sumador.v"

module nivelcarga(A,B,green,yellow,critical,descarga1,descarga2);
    input [3:0] A,B;
    output green, yellow, critical,descarga1,descarga2;
    wire [3:0] suma;
    wire co_s, co_r;
    wire in;
    assign in = 1'b0;
    wire des1,des2;

    adder4b  sumaAB(~A,~B,co_s, suma);
    restador resta(suma,co_r);
    bateria2 alertas(~A,~B,des1,des2);
    
    assign descarga1 = ~des1;
    assign descarga2 = ~des2;

    assign green    = ~(co_s);
    assign yellow   = ~(~co_s&co_r);
    assign critical = ~(~co_s&~co_r); 

endmodule