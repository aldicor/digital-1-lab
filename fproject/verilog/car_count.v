module car_count(detector, count);
    input  detector;
    output reg [13:0] count; // representacion 4 digitos

    initial begin
        count = 0;
    end    


    always @(posedge detector) begin
        count <= count +1;
        if (count == 10000) begin
            count <= 0;
        end
    end
endmodule
