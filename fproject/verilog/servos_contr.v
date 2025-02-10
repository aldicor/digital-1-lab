`include "verilog/servo.v"
`include "verilog/servo_contrl.v"
module servos_contr(pwm, vel, tfst, clk_10Hz, clk_10KHz);
    output [3:0] pwm;
    input [5:0] tfst;
    input [1:0] vel;
    input clk_10Hz, clk_10KHz;

    wire enable_ns_sn, enable_ew, enable_we;
    wire pwm_ns, pwm_sn, pwm_ew, pwm_we;

    assign enable_ns_sn = (tfst == 6'b100000);
    assign enable_ew    = (tfst == 6'b001000);
    assign enable_we    = (tfst == 6'b000010);

    servo pwm_ns_ins(.clk_10Hz(clk_10Hz), .clk_10KHz(clk_10KHz), .vel(vel[1]), .pwm_control(pwm_ns), .enable(enable_ns_sn));
    servo pwm_sn_ins(.clk_10Hz(clk_10Hz), .clk_10KHz(clk_10KHz), .vel(vel[0]), .pwm_control(pwm_sn), .enable(enable_ns_sn));
    servo pwm_ew_ins(.clk_10Hz(clk_10Hz), .clk_10KHz(clk_10KHz), .vel(vel[0]), .pwm_control(pwm_ew), .enable(enable_ew));
    servo pwm_we_ins(.clk_10Hz(clk_10Hz), .clk_10KHz(clk_10KHz), .vel(vel[0]), .pwm_control(pwm_we), .enable(enable_we));

    assign pwm = {pwm_ns, pwm_sn, pwm_ew, pwm_we};

endmodule