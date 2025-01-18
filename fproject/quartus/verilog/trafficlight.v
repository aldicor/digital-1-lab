module trafficlight(green, yellow, red, state);
    input [1:0] state;
    output reg green, yellow, red;

    always @(state) begin
        case (state)
            2'b00: begin
                green = 0;
                yellow= 0;
                red   = 1;
            end
            2'b01: begin
                green = 0;
                yellow= 1;
                red   = 0;
            end
            2'b10: begin
                green = 1;
                yellow= 0;
                red   = 0;
            end
            2'b11: begin
                green  = 1;
                yellow = 1;
                red    = 0;
            end  
            default: begin
                green = 0;
                yellow= 0;
                red   = 1;
            end 
        endcase
    end

endmodule