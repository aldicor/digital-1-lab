// Este módulo tiene tres opciones de salida según sel = 0 => 1ms sel = 1 => 2ms y sel = 2 => 1.5ms, defaul => 1ms
`include "Pruebas_motor/freq_div.v"

module pulso(clk,sel,signal);
    input clk;
    input [1:0] sel;
    output reg signal;
    wire clk_2000Hz;
    reg [6:0]counter; // Se puede contar hasta 127, y se necesita contar hasta 80
    reg [1:0] sel_clk;

    initial begin
        signal = 1'b1;
        counter = 7'd0;
        sel_clk = 2'b0;
    end   
    clockdiv #(12500) reloj1(
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
                if (counter == 2)begin
                    signal <= 1'b0;
                end 
                else begin
                if(counter == 79) begin
                    counter <= 7'd0;
                    signal <= 1'b1;
                end
                end           
            end
            2'd1:begin
                if (counter == 4)begin
                    signal <= 1'b0;
                end 
                else begin
                if(counter == 79) begin
                    counter <= 7'd0;
                    signal <= 1'b1;
                end
                end  
            end
            2'd2:begin
                if (counter == 3)begin
                    signal <= 1'b0;
                end 
                else begin
                if(counter == 79) begin
                    counter <= 7'd0;
                    signal <= 1'b1;
                end
                end  
            end
            default:begin
                if (counter == 2)begin
                    signal <= 1'b0;
                end 
                else begin
                if(counter == 79) begin
                    counter <= 7'd0;
                    signal <= 1'b1;
                end
                end 
            end                
        endcase  
    end
endmodule