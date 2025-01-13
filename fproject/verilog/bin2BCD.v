module bin2BCD(num, bcd);
    input  [13:0] num;
    output reg [15:0] bcd;

    integer i;

    always @(num) begin
        bcd <= 0;
        for (i = 0;i<14;i=i+1) begin
            if (bcd[3:0] > 4) begin
                bcd[3:0] <= bcd[3:0] + 3;
            end
            if (bcd[7:4] > 4) begin
                bcd[7:4] <= bcd[7:4] + 3;
            end
            if (bcd[11:8] > 4) begin
                bcd[11:8] <= bcd[11:8] + 3;
            end
            if (bcd[15:12] > 4) begin
                bcd[15:12] <= bcd[15:12] + 3;
            end
            bcd <= {bcd[14:0], num[13-i]};
        end
    end



endmodule