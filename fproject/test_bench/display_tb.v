`include "./verilog/display.v"
`timescale 1ns/1ns


module display_tb();
    reg clin;
    reg [255:0] message_in;
    reg reset;

    display uut(
        .clock(clin), 
        .reset(reset), 
        .message_in(message_in)
    );

    initial begin
        clin = 0;
        forever #1 clin = ~clin;
    end

    initial begin
            reset =0;
            message_in[7:0]   = "N";
            message_in[15:8]  = "S";
            message_in[23:16] = ":";
            message_in[31:24] = 4'd9 + 8'd48; // Conversion BCD a ASCII
            message_in[39:32] = 4'd8 + 8'd48;
            message_in[47:40] = 4'd3 + 8'd48;
            message_in[55:48] = 4'd1 + 8'd48;
            message_in[63:56] = " ";

            message_in[71:64]  = "S";
            message_in[79:72]  = "N";
            message_in[87:80]  = ":";
            message_in[95:88]  = 4'd4 + 8'd48;
            message_in[103:96] = 4'd2 + 8'd48;
            message_in[111:104] = 4'd9 + 8'd48;
            message_in[119:112] = 4'd7 + 8'd48;
            message_in[127:120] = " ";

            message_in[135:128] = "E";
            message_in[143:136] = "W";
            message_in[151:144] = ":";
            message_in[159:152] = 4'd1 + 8'd48;
            message_in[167:160] = 4'd2 + 8'd48;
            message_in[175:168] = 4'd4 + 8'd48;
            message_in[183:176] = 4'd5 + 8'd48;
            message_in[191:184] = " ";

            message_in[199:192] = "W";
            message_in[207:200] = "E";
            message_in[215:208] = ":";
            message_in[223:216] = 4'd2 + 8'd48;
            message_in[231:224] = 4'd3 + 8'd48;
            message_in[239:232] = 4'd2 + 8'd48;
            message_in[247:240] = 4'd1 + 8'd48;
            message_in[255:248] = " ";
    end
    initial begin: TEST_CASE
        $dumpfile("display_tb.vcd");
        $dumpvars(-1,uut);
        #1000 $finish;
    end

endmodule