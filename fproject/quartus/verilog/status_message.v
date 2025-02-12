module status_message(message,state, tfst, ns_count, sn_count, ew_count, we_count , counter_s, t_add, counter_car, n);
    input [2:0] state;
    input [15:0] ns_count, sn_count, ew_count, we_count; // en BCD
    input [7:0] t_add, counter_car, counter_s; //en BCD
    input [2:0] n;
    input [5:0] tfst;
    output reg [255:0] message;

    localparam  espera_aditiva = 3'b100;

    always @(*) begin
        if (state == espera_aditiva) begin
            if (tfst == 6'b100000) begin //ns +sn
                message[7:0]   = "N";
                message[15:8]  = "S";
                message[23:16] = " ";
                message[31:24] = " ";
                message[39:32] = "Y";
                message[47:40] = " ";
                message[55:48] = "S";
                message[63:56] = "N";
                message[71:64] = " ";
            end else if (tfst == 6'b001000) begin
                message[7:0]   = "E";
                message[15:8]  = "A";
                message[23:16] = "S";
                message[31:24] = "T";
                message[39:32] = "-";
                message[47:40] = "W";
                message[55:48] = "E";
                message[63:56] = "S";
                message[71:64] = "T";
            end else begin
                message[7:0]   = "W";
                message[15:8]  = "E";
                message[23:16] = "S";
                message[31:24] = "T";
                message[39:32] = "-";
                message[47:40] = "E";
                message[55:48] = "A";
                message[63:56] = "S";
                message[71:64] = "T"; 
            end
            message[79:72]  = n + 8'd48;
            message[87:80]  = " ";
            message[95:88]  = "T";
            message[103:96] = " ";
            message[111:104] = t_add[7:4] + 8'd48;
            message[119:112] = t_add[3:0] + 8'd48;
            message[127:120] = " ";

            message[135:128] = "C";
            message[143:136] = "O";
            message[151:144] = "U";
            message[159:152] = "N";
            message[167:160] = "T";
            message[175:168] = ":";
            message[183:176] = counter_s[7:4] + 8'd48;
            message[191:184] = counter_s[3:0] + 8'd48;

            message[199:192] = "C";
            message[207:200] = "A";
            message[215:208] = "R";
            message[223:216] = " ";
            message[231:224] = " ";
            message[239:232] = counter_car[7:4] + 8'd48;
            message[247:240] = counter_car[3:0] + 8'd48;
            message[255:248] = " ";
        end else begin
            message[7:0]   = "N";
            message[15:8]  = "S";
            message[23:16] = ":";
            message[31:24] = ns_count[15:12] + 8'd48; // Conversion BCD a ASCII
            message[39:32] = ns_count[11:8] + 8'd48;
            message[47:40] = ns_count[7:4] + 8'd48;
            message[55:48] = ns_count[3:0] + 8'd48;
            message[63:56] = " ";

            message[71:64]  = "S";
            message[79:72]  = "N";
            message[87:80]  = ":";
            message[95:88]  = sn_count[15:12] + 8'd48;
            message[103:96] = sn_count[11:8] + 8'd48;
            message[111:104] = sn_count[7:4] + 8'd48;
            message[119:112] = sn_count[3:0] + 8'd48;
            message[127:120] = " ";

            message[135:128] = "E";
            message[143:136] = "W";
            message[151:144] = ":";
            message[159:152] = ew_count[15:12] + 8'd48;
            message[167:160] = ew_count[11:8] + 8'd48;
            message[175:168] = ew_count[7:4] + 8'd48;
            message[183:176] = ew_count[3:0] + 8'd48;
            message[191:184] = " ";

            message[199:192] = "W";
            message[207:200] = "E";
            message[215:208] = ":";
            message[223:216] = we_count[15:12] + 8'd48;
            message[231:224] = we_count[11:8] + 8'd48;
            message[239:232] = we_count[7:4] + 8'd48;
            message[247:240] = we_count[3:0] + 8'd48;
            message[255:248] = " ";
        end
    end

endmodule



