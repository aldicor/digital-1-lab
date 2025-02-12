`timescale 1us/1us
`include "quartus/verilog/servo.v"
module servo_tb;
    reg clk_10Hz, clk_10KHz;
    reg vel, enable;
    wire pwm_control;
    
    // Instantiate the DUT (Device Under Test)
    servo uut (
        .clk_10Hz(clk_10Hz),
        .clk_10KHz(clk_10KHz),
        .vel(vel),
        .pwm_control(pwm_control),
        .enable(enable)
    );
    
    // Clock generation
    initial begin
        clk_10Hz = 0;
        forever #50000 clk_10Hz = ~clk_10Hz; // 10Hz clock (period = 100ms)
    end
    
    initial begin
        clk_10KHz = 0;
        forever #50 clk_10KHz = ~clk_10KHz; // 10KHz clock (period = 100us)
    end
    
    // Test sequence
    initial begin
        $dumpfile("servo_tb.vcd");
        $dumpvars(-1, uut);

        // Initialize inputs
        vel = 0;
        enable = 0;
        #200; // Wait for some time
        
        // Enable servo and test different velocities
        enable = 1;
        #500;
        vel = 1;
        #1000;
        vel = 0;
        #1000;

        
        // Finish simulation
        #4000000$finish;
    end
endmodule
