module bin2BCD(sum, sel, bcd);
    input  [8:0] sum;
    input  [1:0] sel;
    output reg [3:0] bcd;

    integer i;

    always @(sel) begin
        case (sel)
            2'b00: bcd = sum %1000; 
            2'b01: bcd = sum%100-sum %1000*10;
            2'b10: bcd = sum%10-sum %100*10;
            2'b11: bcd = sum-sum %10*10;  
        endcase
    end



endmodule
