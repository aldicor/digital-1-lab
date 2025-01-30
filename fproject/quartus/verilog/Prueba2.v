//El objetivo de esta prueba es determinar qué hace el servomotor con una señal de 1ms
//`include "Pruebas_motor/pulso.v"

module Prueba2(clk,diodo);
    input clk;
    output reg diodo;
    wire diodo_wire;

    pulso velocidad1(
        .clk(clk),
        .sel(2'd0),
        .signal(diodo_wire)
    );
    always @(*)begin
        diodo <= diodo_wire;
    end    
endmodule