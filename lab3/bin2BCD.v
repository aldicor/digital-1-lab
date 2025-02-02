module bin2BCD(sum, bcd, clk, nseg);
    input clk;
    input  [8:0] sum;
    output reg [3:0] bcd;
    output reg [3:0] nseg;

    reg [1:0] sel;

    initial begin
        sel <= 2'b0;
        bcd <= 4'd0;
        nseg <= 4'b0000;
    end

    always @(posedge clk) begin
        sel = sel + 2'b1; 
        case (sel)
            2'b00: begin
                bcd = sum/1000;
                nseg = 4'b0111;
            end
            2'b01: begin
                bcd <= (sum/100)-((sum/1000)*10);
                nseg = 4'b1011;
            end
            2'b10: begin
                bcd <= (sum/10)-((sum/100)*10);
                nseg = 4'b1101;
            end
            2'b11: begin
                bcd <= sum-((sum/10)*10);
                nseg = 4'b1110;
            end
        endcase
    end

endmodule