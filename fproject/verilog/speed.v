module speeds (selector,clk,speed);
    input clk;
    input [3:0] selector;
    output reg speed;
    reg [3:0] counter;
    reg [3:0] selector_in;
    
    initial begin 
        counter = 0;        
        speed = 0;
        selector_in = 4'd0;
    end    

    always @(negedge clk)begin
        counter <= counter+1; 
        if(counter == 15-selector_in)begin
            speed <= 1;
        end 
        if(counter == 4'd0)begin
            speed <= 0;
            selector_in <= selector + 15;
        end    
    end
endmodule


module speed(clk,up,down,speed);
    input clk,up,down;
    output speed;
    reg [3:0] sel_speed;

    initial begin
        sel_speed = 4'd0;
    end    

    always @(posedge up)begin
        sel_speed <= sel_speed + 1;
    end    
    always @(posedge down)begin
        sel_speed <= sel_speed - 1;
    end 
    speeds main(
        .selector(sel_speed),
        .clk(clk),
        .speed(speed)
    );
endmodule

