module bin2BCD(sum, sel, bcd);
    input  [8:0] sum;
    input  [1:0] sel;
    output reg [3:0] bcd;

    reg [15:0] bcd_t;
    integer i;

    always @(sum) begin
        bcd_t <= 0;
        for (i = 0;i<9;i=i+1) begin
            if (bcd_t[3:0] > 4) begin
                bcd_t[3:0] <= bcd_t[3:0] + 3;
            end
            if (bcd_t[7:4] > 4) begin
                bcd_t[7:4] <= bcd_t[7:4] + 3;
            end
            if (bcd_t[11:8] > 4) begin
                bcd_t[11:8] <= bcd_t[11:8] + 3;
            end
            if (bcd_t[15:12] > 4) begin
                bcd_t[15:12] <= bcd_t[15:12] + 3;
            end
            bcd_t <= {bcd_t[14:0], sum[8-i]};
        end

        case (sel)
            2'b00: bcd = bcd_t[15:12]; 
            2'b01: bcd = bcd_t[11:8];
            2'b10: bcd = bcd_t[7:4];
            2'b11: bcd = bcd_t[3:0];  
            default: bcd = bcd_t[3:0];
        endcase
    end



endmodule