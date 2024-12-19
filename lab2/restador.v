//`include "sumador.v"

module restador(suma,cout_co);
    input [3:0] suma;
    output cout_co;
    adder4b com2(suma,4'b1100, cout_co,);
endmodule