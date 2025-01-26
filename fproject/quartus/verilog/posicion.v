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
