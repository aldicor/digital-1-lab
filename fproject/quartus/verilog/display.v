module display(clock, message_in,en, rs, rw, D);
    input clock; //clock 16ms -62hz
    output en;
    output reg rs, rw; 
    output reg [7:0] D;
    input [255:0] message_in;

    assign en = clock;
    //
    localparam init_co    = 3'b000;
    localparam update_reg = 3'b001; //
    localparam send_D1    = 3'b010;
    localparam secondline = 3'b011;
    localparam send_D2    = 3'b100;
    localparam firstline  = 3'b101;

    reg [7:0] message [31:0]; //32 direcciones de 8bits
    reg [2:0] init_counter; //contador de inicializacion
    reg [2:0] state;
    reg [5:0] char_index;
    initial begin
        init_counter <= 0;
        state <= 0;
        rs <= 0;
        rw <= 0;
        char_index <=0;
    end
    always @(posedge clock) begin
        case (state)
            init_co:begin
                init_counter <= init_counter +1;
                rw <= 0; // solo se escriben datos
                rs <= 0;
                case (init_counter)
                    2: D <= 8'd0; // wait time
                    3: D <= 8'b00111100; // 8bits - N 2 - F 5x8
                    4: D <= 8'b00001110; //dis on - curso off - blink -off
                    5: D <= 8'b00000001; // clear display
                    6: D <= 8'b00000110; // increment    -no shift 
                    7: begin
                        init_counter <= 0;
                        state <= update_reg;
                    end
                    default: D <= 8'd0;
                endcase
            end
            update_reg:begin
                message[0]  = message_in[7:0];
                message[1]  = message_in[15:8];
                message[2]  = message_in[23:16];
                message[3]  = message_in[31:24];
                message[4]  = message_in[39:32];
                message[5]  = message_in[47:40];
                message[6]  = message_in[55:48];
                message[7]  = message_in[63:56];
                message[8]  = message_in[71:64];
                message[9]  = message_in[79:72];
                message[10] = message_in[87:80];
                message[11] = message_in[95:88];
                message[12] = message_in[103:96];
                message[13] = message_in[111:104];
                message[14] = message_in[119:112];
                message[15] = message_in[127:120];
                message[16] = message_in[135:128];
                message[17] = message_in[143:136];
                message[18] = message_in[151:144];
                message[19] = message_in[159:152];
                message[20] = message_in[167:160];
                message[21] = message_in[175:168];
                message[22] = message_in[183:176];
                message[23] = message_in[191:184];
                message[24] = message_in[199:192];
                message[25] = message_in[207:200];
                message[26] = message_in[215:208];
                message[27] = message_in[223:216];
                message[28] = message_in[231:224];
                message[29] = message_in[239:232];
                message[30] = message_in[247:240];
                message[31] = message_in[255:248];
                char_index <=0;
                state <= send_D1;
            end
            send_D1:begin
                rs <= 1;
                char_index <= char_index + 1;
                D <= message[char_index];                    
                if (char_index ==15) begin
                    state <= secondline;
                end
            end
            secondline:begin
                rs <= 0;
                D <= 8'b11000000;
                state <= send_D2;
            end
            
            send_D2:begin
                rs <= 1;
                D <= message[char_index];
                char_index <= char_index + 1;                    
                if (char_index ==32) begin
                    state <= firstline;
                end
            end
            firstline:begin
                rs <=0;
                D <= 8'b10000000; //address 00 DDRAM
                state <= update_reg;
            end
            default: state = init_co;
        endcase
    end
endmodule