`include "descarga.v"
`timescale 1ps/1ps

module warntb();
    reg [3:0] carga1_tb, carga2_tb;
    wire warn1_tb, warn2_tb;

    bateria2 uut(
        .carga1(carga1_tb),
        .carga2(carga2_tb),
        .warn1(warn1_tb),
        .warn2(warn2_tb)
    );
    
    initial begin
        carga1_tb = 4'b0000;
        carga2_tb = 4'b0000;
        #1;
        carga1_tb = 4'b0001;
        carga2_tb = 4'b0001;
        #1;
        carga1_tb = 4'b0010;
        carga2_tb = 4'b0010;
        #1;
        carga1_tb = 4'b0011;
        carga2_tb = 4'b0011;
        #1;
        carga1_tb = 4'b0100;
        carga2_tb = 4'b0100;
        #1;
        carga1_tb = 4'b0101;
        carga2_tb = 4'b0101;
        #1;
        carga1_tb = 4'b0110;
        carga2_tb = 4'b0110;
        #1;
        carga1_tb = 4'b0111;
        carga2_tb = 4'b0111;
        #1;
        carga1_tb = 4'b1000;
        carga2_tb = 4'b1000;
        #1;
        carga1_tb = 4'b1001;
        carga2_tb = 4'b1001;
        #1;
        carga1_tb = 4'b1010;
        carga2_tb = 4'b1010;
        #1;
        carga1_tb = 4'b1011;
        carga2_tb = 4'b1011;
        #1;
        carga1_tb = 4'b1100;
        carga2_tb = 4'b1100;
        #1;
        carga1_tb = 4'b1101;
        carga2_tb = 4'b1101;
        #1;
        carga1_tb = 4'b1110;
        carga2_tb = 4'b1110;
        #1;
        carga1_tb = 4'b1111;
        carga2_tb = 4'b1111;
        #1;
    end

    initial begin: TEST_CASE
        $dumpfile("descarga_tb.vcd");
        $dumpvars(-1, uut);
        #20 $finish; 
        
    end
endmodule