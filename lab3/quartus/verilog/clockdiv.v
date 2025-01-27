module clockdiv #(parameter div = 16'd806452)(clin, clout);
    input clin;
    output reg clout;

    reg [15:0] count = 16'd0;

    initial begin
        clout <= 0;
    end
    always @(posedge clin) begin
        count <= count + 16'd1;
        if (count == div-1) begin
            count <= 16'd0;
            clout <= ~clout;
        end
    end

endmodule