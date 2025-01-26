module motor_main(clk,up,signal);
    input clk;
    input up;
    output signal;
    reg [2:0] speed;
    initial begin
        speed = 3'b0;
    end    

    always @(posedge up)begin
        speed <= speed + 1'd1;
    end 
    
    control uut(
        .clk(clk),
        .speed(speed),
        .out(signal)
    );
endmodule




