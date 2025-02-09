`include "verilog/traffic_contrl.v"

`timescale 1ns / 1ns

module traffic_contrl_tb();
    reg  [3:0] count_ns_4b,count_sn_4b, count_ew_4b, count_we_4b;
    reg  clk;
    wire [3:0] bcd;
    wire [2:0] tf0, tf1, tf2;

    traffic_contrl uut(
        .clk(clk), 
        .tf0(tf0), 
        .tf1(tf1),
        .tf2(tf2),
        .count_ns_4b(count_ns_4b),
        .count_sn_4b(count_sn_4b),
        .count_ew_4b(count_ew_4b),
        .count_we_4b(count_we_4b)
    );

    initial begin
        clk = 0;
        forever #1 clk = ~clk;
    end 

    initial begin
        #15;
        count_ns_4b = 4'd4;
        count_sn_4b = 4'd4;
        count_ew_4b = 4'd4;
        count_we_4b = 4'd4;
        #20;
        count_ns_4b = 4'd10;
        count_sn_4b = 4'd10;
        count_ew_4b = 4'd10;
        count_we_4b = 4'd10;
    end
    initial begin: TEST_CASE
        $dumpfile("traffic_contrl_tb.vcd");
        $dumpvars(-1,uut);
        #1000 $finish;
    end

endmodule