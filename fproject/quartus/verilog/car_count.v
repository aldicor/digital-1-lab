module car_count(clk, detector, count, reset);
    input  detector, clk, reset; //2hz
    output reg [13:0] count; // representacion 4 digitos

    initial begin
        count = 0;
    end    

    reg [13:0] count_aux;
    reg [13:0] count_aux_prev;

    always @(posedge detector) begin
        count_aux <= count_aux+1;
    end

    always @(posedge clk or posedge reset) begin 
        if (reset==1) begin
            count <= 0;
        end
        else if (count_aux != count_aux_prev) begin
            if (count == 10000) begin
                count <= 0;
            end else begin
                count <= count +1;
                count_aux_prev <= count_aux;
            end 
        end
    end
endmodule
