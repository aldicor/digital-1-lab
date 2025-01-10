`include "binBCD.v"
`include "BCD7s.v"
`include "selector.v"
`include "clockdiv.v"


module sync(sum, clock, ssg, nseg);
    input [8:0] sum;
    input clock;
    output [6:0] ssg;
    output [3:0] nseg;

    wire clock1ms;
    reg [1:0] count;
    wire b2BCD;

    clockdiv cl1ms(.clin(clock), .clout(clock1ms));

    initial begin
        count <= 2'b0;
    end

    bin2BCD  decbin(.sum(sum), .sel(count), .bcd(b2BCD));
    BCDssg   sseg(.BCD(b2BCD), .ssg(ssg));
    selector sel(.sel(count), .nseg(nseg));         
    always @(posedge clock1ms) begin
        count = count + 2'b1; 
    end

endmodule