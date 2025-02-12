module bin2BCD(num, bcd);
    input  [13:0] num;
    output reg [15:0] bcd;
    initial begin
        bcd <= 16'd0;
    end
    always @(num) begin 
        bcd[15:12] <= num/1000;
        bcd[11:8]  <= (num/100)-((num/1000)*10);
        bcd[7:4]   <= (num/10)-((num/100)*10);
        bcd[3:0]   <= num-((num/10)*10);
    end
endmodule