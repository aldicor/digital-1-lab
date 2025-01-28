// EL objetivo de esta prueba es determinar el parámetro de división para un reloj de 1 s (1 segundo arriba y otro abajo).
`include "Pruebas_motor/freq_div.v"

module reloj(clk,clk_out);
    input clk;
    output reg clk_out;
    wire clk_output;

    clockdiv #(50000000) reloj1(
        .clkin(clk),
        .clkout(clk_output)
    );
    always @(*)begin
        clk_out <= clk_output;
    end    
endmodule





