// Este módulo tiene tres opciones de salida según sel = 0 => 1ms sel = 1 => 2ms y sel = 2 => 1.5ms, defaul => 1ms
//`include "Pruebas_motor/freq_div.v"

module pulso(clk, vel, signal);
    input clk;
    input vel;
    output reg signal;
    wire clk_20KHz;
    wire clk_1Hz;
    reg [7:0] counter_us; // Se puede contar hasta 255, y se necesita contar hasta 200
    reg [4:0] counter_ms;

    reg [1:0] state_pwm;
    reg [1:0] state_vel;
    reg [5:0] pwm_n;
    reg [7:0] angles [2:0];
    reg [2:0] speed; // 

    localparam init = 1'd0;
    localparam pwm = 1'd1;
    localparam wait_t = 1'd0;
    localparam next_angl = 1'd1;


    initial begin
        signal <= 1'b1;
        counter_us <= 7'd0;
        state_pwm <= 1'b0;
        state_vel <= 1'b0;
        pwm_n <= 3'd0;
        speed <= 0;
    end   

    clockdiv #(5000) reloj1( // Se divide por 10 000, porque f/x = 50*200, para que haya un posedge cada 0.1msss
        .clkin(clk),
        .clkout(clk_20KHz)
    );

    clockdiv #(50_000_00) reloj2( // Se divide por 10 000, porque f/x = 50*200, para que haya un posedge cada 0.1msss
        .clkin(clk),
        .clkout(clk_1Hz)
    );
    
    always @(posedge clk_20KHz)begin
        case (state_pwm)
            init:begin
                signal <= 1'b1;
                counter_us <= 13'd0;
                state_pwm <= pwm;
            end
            pwm:begin
                if (counter_us < (4 + pwm_n))begin //Para que llegue a 1ms, tienen que pasar 10 0.1ms
                    signal <= 1'b1;
                end else if(counter_us == 200) begin // Para que llegue a 20 ms tienen que pasa 10*19 posedge.
                    counter_us <= 7'd0;
                end else signal <=0;
                counter_us <= counter_us + 1;        
            end              
        endcase  
    end

    always @(posedge vel) begin
        speed <= speed + 1;
    end

    always @(posedge clk_1Hz) begin
        case (state_vel)
            wait_t:begin
                if (counter_ms == (2*(speed+1)))begin 
                    state_vel <= next_angl;
                    counter_ms <=0;
                end else begin
                    counter_ms <= counter_ms +1; 
                end  
            end 
            next_angl:begin
                pwm_n <= pwm_n + 8;
                if (pwm_n>20) begin
                    pwm_n <= 0;
                    state_vel <= wait_t;
                end 
                state_vel <= wait_t;
            end 
        endcase
    end

endmodule

// Este módulo tiene tres opciones de salida según sel = 0 => 1ms sel = 1 => 2ms y sel = 2 => 1.5ms, defaul => 1ms
//`include "Pruebas_motor/freq_div.v"
/*
//module pulso(clk, signal);
    input clk;
    output reg signal;
    wire clk_2000Hz;
    reg [9:0]counter; // Se puede contar hasta 255, y se necesita contar hasta 200

    initial begin
        signal = 1'b1;
        counter = 7'd0;
    end   
    clockdiv #(5000) reloj1( // Se divide por 5 000, para que haya un posedge cada 0.1msss
        .clkin(clk),
        .clkout(clk_2000Hz)
    );

    always @(posedge clk_2000Hz)begin
        counter <= counter + 1;

                if (counter == 10)begin //Para que llegue a 1ms, tienen que pasar 10 0.1ms
                    signal <= 1'b0;
                end 
                if(counter == 199) begin // Para que llegue a 20 ms tienen que pasa 10*19 posedge.
                    counter <= 7'd0;
                    signal <= 1'b1; 
                end      
    end
endmodule*/