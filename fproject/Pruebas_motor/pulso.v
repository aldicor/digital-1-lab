// Este módulo tiene tres opciones de salida según sel = 0 => 1ms sel = 1 => 2ms y sel = 2 => 1.5ms, defaul => 1ms
//`include "Pruebas_motor/freq_div.v"

module pulso(clk,sel,signal);
    input clk;
    input [1:0] sel;
    output reg signal;
    wire clk_2000Hz;
    reg [7:0]counter; // Se puede contar hasta 255, y se necesita contar hasta 200
    reg [1:0] sel_clk;

    initial begin
        signal = 1'b1;
        counter = 7'd0;
        sel_clk = 2'b0;
    end   
    clockdiv #(10000) reloj1( // Se divide por 10 000, porque f/x = 50*200, para que haya un posedge cada 0.1msss
        .clkin(clk),
        .clkout(clk_2000Hz)
    );
    always @(posedge clk)begin
        sel_clk = sel;
    end    
    always @(posedge clk_2000Hz)begin
        counter <= counter + 1;
        case (sel)
            2'd0:begin
                if (counter == 10)begin //Para que llegue a 1ms, tienen que pasar 10 0.1ms
                    signal <= 1'b0;
                end 
                else begin
                if(counter == 190) begin // Para que llegue a 20 ms tienen que pasa 10*19 posedge.
                    counter <= 7'd0;
                    signal <= 1'b1; 
                end
                end           
            end
            2'd1:begin
                if (counter == 15)begin
                    signal <= 1'b0;
                end 
                else begin
                if(counter == 195) begin
                    counter <= 7'd0;
                    signal <= 1'b1;
                end
                end  
            end
            2'd2:begin
                if (counter == 20)begin
                    signal <= 1'b0;
                end 
                else begin
                if(counter == 180) begin
                    counter <= 7'd0;
                    signal <= 1'b1;
                end
                end  
            end
            2'd3:begin
                signal <= 1'b0;
            end
            default:begin
                if (counter == 20)begin
                    signal <= 1'b0;
                end 
                else begin
                if(counter == 180) begin
                    counter <= 7'd0;
                    signal <= 1'b1;
                end
                end 
            end                
        endcase  
    end
endmodule