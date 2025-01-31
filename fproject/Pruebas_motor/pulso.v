// Este módulo tiene tres opciones de salida según sel = 0 => 1ms sel = 1 => 2ms y sel = 2 => 1.5ms, defaul => 1ms
//`include "Pruebas_motor/freq_div.v"

module pulso(clk, vel, signal);
    input clk;
    input vel;
    output reg signal;
    wire clk_20KHz;
    reg [12:0]counter; // Se puede contar hasta 255, y se necesita contar hasta 200

    reg [2:0] state;
    reg [2:0] pwm_n;
    reg [7:0] angles [2:0];
    reg [2:0] speed; // 

    localparam init = 3'd0;
    localparam pwm = 3'd1;
    localparam wait_t = 3'd2;
    localparam next_angl = 3'd3;


    initial begin
        signal <= 1'b1;
        counter <= 7'd0;
        state <= 3'b000;
        pwm_n <= 3'd0;
        speed <= 0;
    end   

    clockdiv #(5000) reloj1( // Se divide por 10 000, porque f/x = 50*200, para que haya un posedge cada 0.1msss
        .clkin(clk),
        .clkout(clk_20KHz)
    );
    
    always @(posedge clk_20KHz)begin
        case (state)
            init:begin
                signal <= 1'b1;
                counter <= 13'd0;
                state <= 3'b00;
                pwm_n <= 3'd0;
                state <= pwm;
            end
            pwm:begin
                if (counter < (10 + pwm_n))begin //Para que llegue a 1ms, tienen que pasar 10 0.1ms
                    signal <= 1'b1;
                end else if(counter == 200) begin // Para que llegue a 20 ms tienen que pasa 10*19 posedge.
                    counter <= 7'd0;
                    signal <= 1'b0;
                    state <= wait_t;
                end else signal <=0;
                counter <= counter + 1;        
            end
            wait_t:begin
                if (counter == (3000*(speed+1)))begin 
                    state <= next_angl;
                    counter <=0;
                end else begin
                    counter <= counter +1; 
                end  
            end
            next_angl: begin
                signal <= 1'b1;
                pwm_n <= pwm_n + 1;
                if (pwm_n>10) begin
                    pwm_n <= 0;
                end 
                state <= pwm;
            end              
        endcase  
    end

    always @(posedge vel) begin
        speed <= speed + 1;
    end
endmodule