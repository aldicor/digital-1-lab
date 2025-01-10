module selector(sel, nseg);
    input [1:0] sel;
    output reg [3:0] nseg;
    
    always @(sel) begin
		case (sel)
			2'b00: nseg = 4'b0111;
			2'b01: nseg = 4'b1011;
			2'b10: nseg = 4'b1101;
			2'b11: nseg = 4'b1110; 
			default: nseg = 4'b0111;
		endcase
	end	

endmodule