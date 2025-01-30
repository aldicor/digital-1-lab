//  Esta prueba consiste el simular una velocidad: se enciende el servomotor en una dirección y luego se detiene por otro tiempo, y así
//`include "Pruebas_motor/pulso.v"

module Prueba4(clk,diodo);
    input clk;
    output reg diodo;
    wire clk_out, diodo_wire;
    reg[3:0] counter; // Puede contar hasta el número 15
    reg [1:0] sel;

    initial begin
        counter = 4'b0;
        sel = 2'd0;
    end    

    Prueba1 clk_1s(
        .clk(clk),
        .clk(clk_out)
    );

    always @(clk_out)begin
        counter <= counter + 1;
        if(counter<12)begin
            sel <= 2'd0;
        end
        else begin
            sel <= 2'd3; // El sel 3 es una señal 0 constante
        end        
    end    
    pulso velocidad3(
        .clk(clk),
        .sel(2'd2),
        .signal(diodo_wire)
    );
    always @(*)begin
        diodo <= diodo_wire;
    end   
endmodule