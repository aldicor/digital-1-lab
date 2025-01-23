`include "binBCD.v"
`include "BCD7s.v"
`include "selector.v"
`include "clockdiv.v"


module (sel,baterias, clock, ssg, nseg,light);
    input [15:0] baterias;
    input sel
    input clock;
    wire [8:0] sum;
    output [6:0] ssg;
    output [3:0] nseg;

    wire clock1ms;
    
    wire [3:0] b2BCD;
    
    sumador sum1ns(.sel(sel),.baterias(baterias),.sum(sum));

    clockdiv cl1ms(.clin(clock), .clout(clock1ms));

    bin2BCD  decbin(.sum(sum), .bcd(b2BCD), .clk(clock1ms), .nseg(nseg));
    BCDssg   sseg(.BCD(b2BCD), .ssg(ssg));        
    alarmas alarmas1ns(.sel(sel),.sum(sum),.out(light));

endmodule