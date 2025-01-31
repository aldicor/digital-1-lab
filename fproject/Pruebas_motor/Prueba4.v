//  Esta prueba consiste el simular una velocidad: se enciende el servomotor en una dirección y luego se detiene por otro tiempo, y así
//`include "Pruebas_motor/pulso.v"

module Prueba4(clk,pwm,led);
    input clk;
    output pwm,led;
    wire clk_out;

    reg[3:0] counter; // Puede contar hasta el número 15
    reg [2:0] sel;

    initial begin
        counter = 4'b0;
        sel = 3'd0;
    end    

    clockdiv #(50000000) reloj1(
        .clkin(clk),
        .clkout(clk_out)
    );

    always @(posedge clk_out)begin
        counter <= counter + 1;
        if(counter==2)begin
            sel <= sel +3'd1;
				counter <= 0;
        end
			if (sel == 4) begin
            sel <=0;
        end        
    end    
    pulso velocidad3(
        .clk(clk),
        .sel(sel),
        .signal(pwm)
    );
    assign led = clk_out;
     
endmodule