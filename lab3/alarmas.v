module alarmas(sel,sum,out);
    input [8:0] sum, sel;
    output critico, regular, aceptable;
    always(sel)begin
        if(sel == 1'b0)begin
            if(sum < 103)begin
                out[0] <= 1'b1;
                out[1] <= 1'b0;
                out[2] <= 1'b0;
            end
            else if (sum < 256)begin 
                out[0] <= 1'b0;
                out[1] <= 1'b1;
                out[2] <= 1'b0;
            end
            else begin
                out[0] <= 1'b0;
                out[1] <= 1'b0;
                out[2] <= 1'b1;
            end     
        end
    end    
endmodule 