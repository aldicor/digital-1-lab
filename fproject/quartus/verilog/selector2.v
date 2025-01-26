module posicion(clk,posicion);
    input clk;
    output reg posicion;
    reg clk_2Hz;
    initial begin
        posicion = 1'b0;
    end    

    clockdiv #(div = 25000000)reloj_medio_segundo(
        .clkin(clk),
        .clkout(clk_2Hz)
    );

    alwasys @(posedge clk_2Hz)begin
        counter <= counter + 1;
        case(speed)
            3'd0:begin
                posicion = ¬posicion;
                counter <= 3'd0;
            end
            3'd1:begin
                if(counter == 3'd1)begin
                    posicion = ¬posicion;
                    counter <= 3'd0;
                end
            end        
            3'd2:begin
                if(counter == 3'd2)begin
                    posicion = ¬posicion;
                    counter <= 3'd0;
                end
            end       
            3'd3:begin
                if(counter == 3'd3)begin
                    posicion = ¬posicion;
                    counter <= 3'd0;
                end
            end       
            3'd4:begin
                if(counter == 3'd4)begin
                    posicion = ¬posicion;
                    counter <= 3'd0;
                end
            end   
            3'd5:begin
                if(counter == 3'd5)begin
                    posicion = ¬posicion;
                    counter <= 3'd0;
                end
            end   
            3'd6:begin
                if(counter == 3'd6)begin
                    posicion = ¬posicion;
                    counter <= 3'd0;
                end
            end   
            3'd7:begin
                if(counter == 3'd7)begin
                    posicion = ¬posicion;
                    counter <= 3'd0;
                end
            end    
        endcase
    end   

endmodule 

module (clk,speed,out);
    input clk;
    input [2:0] speed;
    reg clk_2000Hz, posicion;
    output reg out; 
    reg [6:0]counter; // Se puede contar hasta 127, y se necesita contar hasta 80

    initial begin
        speed =3'd0;
        out = 1'b1;
        counter = 1'd0;
        posicion = 1'd0;
    end
    clockdiv #(div = 25000) (
        .clkin(clk),
        .clkout(clk_2000Hz)
    );
    posicion ab(
        .clk(clk),
        .posicion(posicion),
    );
    always @(posedge clk_2000Hz)begin
        counter <= counter + 1;
        if(counter == speed + 1)begin
            out = 1'b0;
        end    
        else begin
            if(counter == 79) begin
                counter <= 7'd0;
                out == 1'b1;
            end
        end     
    end    
endmodule
