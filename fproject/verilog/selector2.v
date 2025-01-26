`include "verilog/freq_div.v"

module posicion(clk,posicion,speed);
    input clk;
    output reg posicion;
    input [2:0] speed;
    wire clk_2Hz;
    reg [2:0] counter;

    initial begin
        posicion = 1'b0;
    end    

    clockdiv #(25000000)reloj_medio_segundo(
        .clkin(clk),
        .clkout(clk_2Hz)
    );

    always @(posedge clk_2Hz)begin
        counter <= counter + 1;
        case(speed)
            3'd0:begin
                posicion = ~posicion;
                counter <= 3'd0;
            end
            3'd1:begin
                if(counter == 3'd1)begin
                    posicion <= ~posicion;
                    counter <= 3'd0;
                end
            end        
            3'd2:begin
                if(counter == 3'd2)begin
                    posicion <= ~posicion;
                    counter <= 3'd0;
                end
            end       
            3'd3:begin
                if(counter == 3'd3)begin
                    posicion <= ~posicion;
                    counter <= 3'd0;
                end
            end       
            3'd4:begin
                if(counter == 3'd4)begin
                    posicion <= ~posicion;
                    counter <= 3'd0;
                end
            end   
            3'd5:begin
                if(counter == 3'd5)begin
                    posicion <= ~posicion;
                    counter <= 3'd0;
                end
            end   
            3'd6:begin
                if(counter == 3'd6)begin
                    posicion <= ~posicion;
                    counter <= 3'd0;
                end
            end   
            3'd7:begin
                if(counter == 3'd7)begin
                    posicion <= ~posicion;
                    counter <= 3'd0;
                end
            end    
        endcase
    end   

endmodule 

module control(clk,speed,out);
    input clk;
    input [2:0] speed;
    wire posicion,clk_2000Hz;
    output reg out; 
    reg [6:0]counter; // Se puede contar hasta 127, y se necesita contar hasta 80

    initial begin
        out = 1'b1;
        counter = 7'd0;
    end
    clockdiv #(25000) reloj1(
        .clkin(clk),
        .clkout(clk_2000Hz)
    );
    posicion ab(
        .clk(clk),
        .posicion(posicion),
        .speed(speed)
    );
    always @(posedge clk_2000Hz)begin
        counter <= counter + 1;
        if(counter == speed + 1)begin
            out <= 1'b0;
        end    
        else begin
            if(counter == 79) begin
                counter <= 7'd0;
                out <= 1'b1;
            end
        end     
    end    
endmodule

module principal(clk,up,down,signal);
    input clk;
    input up;
    input down;
    output signal;
    reg [2:0] speed;
    initial begin
        speed = 3'b0;
    end    

    always @(posedge up)begin
        speed <= speed + 1;
    end    
    always @(posedge down)begin
        speed <= speed -1;
    end    
    control uut(
        .clk(clk),
        .speed(speed),
        .out(signal)
    );
endmodule




