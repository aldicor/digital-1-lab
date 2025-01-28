//  Esta prueba consiste el simular una velocidad: se enciende el servomotor en una dirección y luego se detiene por otro tiempo, y así
`include "Pruebas_motor/pulso.v"

module speed(clk,diodo);
    input clk;
    output reg diodo;
    wire diodo_wire;

    pulso velocidad3(
        .clk(clk),
        .sel(2'd2),
        .signal(diodo_wire)
    );
    always @(*)begin
        diodo <= diodo_wire;
    end   
endmodule