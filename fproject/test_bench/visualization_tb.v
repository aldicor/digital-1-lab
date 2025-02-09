`include "./verilog/visualization.v"
`timescale 1ns/1ns

module visualization_tb();
    reg clin;

    visualization uut(
        .clock(clin)
    );
    initial begin
        clin = 0;
        forever #1 clin = ~clin;
    end

    initial begin: TEST_CASE
        $dumpfile("visualization.vcd");
        $dumpvars(-1,uut);
        #1000 $finish;
    end

endmodule