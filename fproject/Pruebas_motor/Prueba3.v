//El objetivo de esta prueba es determinar qué hace el servomotor con una señal de 2ms
`include "Pruebas_motor/pulso.v"

module Prueba3(clk,diodo);
    input clk;
    output reg diodo;
    wire diodo_wire;

    pulso velocidad2(
        .clk(clk),
        .sel(2'd1),
        .signal(diodo_wire)
    );
    always @(*)begin
        diodo <= diodo_wire;
    end    
endmodule