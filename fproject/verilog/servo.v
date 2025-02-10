// Este módulo tiene tres opciones de salida según sel = 0 => 1ms sel = 1 => 2ms y sel = 2 => 1.5ms, defaul => 1ms
//`include "Pruebas_motor/freq_div.v"

module servo(clk_10Hz, clk_10KHz, vel, pwm_control, enable);
    input clk_10Hz, clk_10KHz;
    input vel, enable;
    output pwm_control;
    reg signal;

    assign pwm_control = ~(signal^enable);

    reg [7:0] counter_us; // Se puede contar hasta 255, y se necesita contar hasta 200
    reg [3:0] counter_ms;

    reg [1:0] state_pwm;
    reg [1:0] state_vel;

    reg [1:0] angle_count;
    reg [4:0] angles [3:0];
    reg [2:0] speed; // 

    localparam init = 1'd0;
    localparam pwm = 1'd1;
    localparam wait_t = 1'd0;
    localparam next_angl = 1'd1;


    reg [8:0] count_aux;
    reg [8:0] count_aux_prev;

    initial begin
        signal <= 1'b1;
        counter_us <= 7'd0;
        state_pwm <= 1'b0;
        state_vel <= 1'b0;
        angle_count <= 3'd0;
        count_aux_prev<= 0;
        count_aux <=0;
        speed <= 0;
        angles [0] = 5'd7;
        angles [1] = 5'd12;
        angles [2] = 5'd17;
        angles [3] = 5'd12;
    end  
/*
    clockdiv #(5000) reloj1( // Se divide por 10 000, porque f/x = 50*200, para que haya un posedge cada 0.1msss
        .clkin(clk),
        .clkout(clk_20KHz)
    );

    clockdiv #(50_000_00) reloj2( // Se divide por 10 000, porque f/x = 50*200, para que haya un posedge cada 0.1msss
        .clkin(clk),
        .clkout(clk_1Hz)
    );
  */  
    always @(posedge clk_10KHz)begin
        case (state_pwm)
            init:begin
                signal <= 1'b1;
                counter_us <= 7'd0;
                state_pwm <= pwm;
            end
            pwm:begin
                if (counter_us < 200) begin
                    counter_us <= counter_us + 1;  
                    if (counter_us < angles[angle_count]) begin
                        signal <= 1'b1; 
                    end else begin
                        signal <= 0; 
                    end
                end else begin
                    counter_us <= 0; 
                end 
            end              
        endcase  
    end



    always @(posedge vel) begin
        count_aux <= count_aux+1;
    end

    always @(posedge clk_10Hz) begin 
        if (count_aux != count_aux_prev) begin
            speed <= speed +1;
            count_aux_prev <= count_aux;
        end
    end


    always @(posedge clk_10Hz) begin
        case (state_vel)
            wait_t:begin
                if (counter_ms == (2*(speed+1))) begin 
                    state_vel <= next_angl;
                    counter_ms <=0;
                end else begin
                    counter_ms <= counter_ms +1; 
                end  
            end 
            next_angl:begin
                angle_count <= angle_count + 1;
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