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