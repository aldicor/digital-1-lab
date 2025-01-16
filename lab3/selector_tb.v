`include "selector.v"
`timescale 1ps/1ps

module selector_tb();
    reg [1:0] sel_tb;
    wire [3:0] nseg_tb;
    
    selector uut(
        .sel(sel_tb),
        .nseg(nseg_tb)
    );
    initial begin
        sel_tb = 2'd0;
        #1;
        sel_tb = 2'd1;
        #1;
        sel_tb = 2'd2;
        #1;
        sel_tb = 2'd3;
        #1;
    end    
    initial begin: TEST_CASE
        $dumpfile("selector_tb.vcd");
        $dumpvars(-1,uut);
        #4 $finish;
    end
endmodule