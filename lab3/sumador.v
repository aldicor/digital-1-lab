module sumador(sel, baterias, sum);
    input [15:0] baterias;
    output reg [8:0] sum;
    input sel;

    always(sel)begin
        if (sel == 1'b0) begin
           sum <= baterias[15:8] + baterias[7:0];
        end  
        else begin
            sum <= bateiras[15:12] + bateiras[11:8] + baterias[7:4] + baterias[3:0];
        end       
    end    
endmodule    


