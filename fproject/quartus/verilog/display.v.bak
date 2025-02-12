module display(clock, ns_count, sn_count, ew_count, we_count,en, rs, rw, D);
    input [15:0] ns_count, sn_count, ew_count, we_count;
    input clock; //clock 16ms
    output en;
    output reg rs, rw; 
    output reg [7:0] D;

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
    reg [1:0] state;
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
                message[0] = "N";//verilog maneja codigo ascii
                message[1] = "S";
                message[2] = ":";
                message[3] = ns_count[15:12]+8'd48; // +8'd48 convertir bcd a ascii
                message[4] = ns_count[11:8]+8'd48;
                message[5] = ns_count[7:4]+8'd48;
                message[6] = ns_count[3:0]+8'd48;
                message[7] = " ";
                //
                message[8] = "S";
                message[9] = "N";
                message[10] = ":";
                message[11] = sn_count[15:12]+8'd48;
                message[12] = sn_count[11:8]+8'd48;
                message[13] = sn_count[7:4]+8'd48;
                message[14] = sn_count[3:0]+8'd48;
                message[15] = " ";
                //
                message[16] = "E";
                message[17] = "W";
                message[18] = ":";
                message[19] = ew_count[15:12]+8'd48;
                message[20] = ew_count[11:8]+8'd48;
                message[21] = ew_count[7:4]+8'd48;
                message[22] = ew_count[3:0]+8'd48;
                message[23] = " ";
                //
                message[24] = "W";
                message[25] = "E";
                message[26] = ":";
                message[27] = we_count[15:12]+8'd48;
                message[28] = we_count[11:8]+8'd48;
                message[29] = we_count[7:4]+8'd48;
                message[30] = we_count[3:0]+8'd48;
                message[31] = " ";
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