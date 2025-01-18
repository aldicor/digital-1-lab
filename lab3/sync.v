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
    
    wire [3:0] b2BCD;

    clockdiv cl1ms(.clin(clock), .clout(clock1ms));

    bin2BCD  decbin(.sum(sum), .bcd(b2BCD), .clk(clock1ms), .nseg(nseg));
    BCDssg   sseg(.BCD(b2BCD), .ssg(ssg));        
    

endmodule