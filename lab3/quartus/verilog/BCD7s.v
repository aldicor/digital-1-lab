module BCDssg(BCD, ssg);
    input [3:0] BCD;
    output reg [6:0] ssg;

	always @(*) begin
		case(BCD)
		 	4'h0: ssg = 7'b0000001;
			4'h1: ssg = 7'b1001111;
			4'h2: ssg = 7'b0010010;
			4'h3: ssg = 7'b0000110;
			4'h4: ssg = 7'b1001100;
			4'h5: ssg = 7'b0100100;
			4'h6: ssg = 7'b0100000;
			4'h7: ssg = 7'b0001111;
			4'h8: ssg = 7'b0000000;
			4'h9: ssg = 7'b0000110;
			4'ha: ssg = 7'b0001000;
			4'hb: ssg = 7'b1100000; 
			4'hc: ssg = 7'b0110001; 
			4'hd: ssg = 7'b1000010; 
			4'he: ssg = 7'b0110000;
			4'hf: ssg = 7'b0111000;
		endcase
	end
endmodule