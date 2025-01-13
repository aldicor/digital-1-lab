module display(clock, ns_count, sn_count, ew_count, we_count ,rs, rw, en, D );
    input [15:0] ns_count, sn_count, ew_count, we_count;
    input clock; //clock 10us
    output reg rs, rw, en; 
    output reg [7:0] D;

    //
    localparam init_co = 2'b00;
    localparam update_reg = 2'b01; //
    localparam send_D = 2'b10;


    reg [7:0] message [31:0]; //32 direcciones de 8bits

    initial begin
        
    end

    reg [10:0] counter; //contador para cambiar de estado
    reg [1:0] state;
    reg [5:0] char_index;

    initial begin
        counter <= 0;
        state <= 0;
        rs <= 0;
        rw <= 0;
        en <= 0;
    end


    always @(posedge clock) begin
        counter <= counter +1;
        case (state)
            init_co:begin
                rw <=0; // solo se escriben datos
                rs <=0;
                en <=0;
                if (counter == 4) begin
                    D <= 8'b00111000; // 8bits - N 2 - F 5x8
                end else if (counter == 8) begin
                    D <= 8'b00001100; // display on - cursor off - cursor p off
                end else if (counter == 12) begin
                    D <= 8'b00000001; // clear display
                end else if (counter == 1532) begin
                    D <= 8'b00000110; // right -no shift 
                end else if (counter == 1570) begin
                    counter <=0;
                    state   <= update_reg;
                end
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
                counter<=0;
            end
            send_D:begin
                en <= 1;
                rs <= 1;
                D <= message[char_index];
                if (counter == 5) begin //50us de espera
                    char_index <= char_index + 1;
                    counter<=0;
                    if (char_index ==32) begin
                        state <= init_co;
                end
                end 

            end 
            default: state = init_co;
        endcase
    end






endmodule