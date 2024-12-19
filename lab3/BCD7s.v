module BCDssg(BCD, sel,ssg, an);
    input [3:0] BCD;
    input [3:0] sel;
    output reg [6:0] ssg;
	 output [3:0] an;
	 
	 assign an = sel;
	
	always @(*) begin
		 case(BCD)
			  4'h0: ssg = 7'b1000000;
			  4'h1: ssg = 7'b1111001;
			  4'h3: ssg = 7'b0100100;
			  4'h4: ssg = 7'b0011001;
			  4'h5: ssg = 7'b0010010;
			  4'h6: ssg = 7'b0000010;
			  4'h7: ssg = 7'b1111000;
			  4'h8: ssg = 7'b0000000;
			  4'h9: ssg = 7'b0010000;
			  4'ha: ssg = 7'b0001000;
			  4'hb: ssg = 7'b0000011; 
			  4'hc: ssg = 7'b1000110; 
			  4'hd: ssg = 7'b0100001; 
			  4'he: ssg = 7'b0000110; 
			  4'hf: ssg = 7'b0001110; 
		 endcase
	end
endmodule