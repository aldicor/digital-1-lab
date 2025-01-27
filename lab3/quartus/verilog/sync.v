module sync(sel_t,baterias, clock, ssg, nseg,light);
    input [15:0] baterias;
    input sel_t;
    input clock;
    wire [8:0] sum;
    output [6:0] ssg;
    output [3:0] nseg;
    output [2:0] light;


    wire clock1ms;
    
    wire [3:0] b2BCD;

    reg sel;

    initial begin
        sel = 0;
    end

    always @(posedge sel_t ) begin
        sel <= sel +1;
    end
    
    sumador sum1ns(.sel(sel),.baterias(baterias),.sum(sum));

    clockdiv cl1ms(.clin(clock), .clout(clock1ms));

    bin2BCD  decbin(.sum(sum), .bcd(b2BCD), .clk(clock1ms), .nseg(nseg));
    BCDssg   sseg(.BCD(b2BCD), .ssg(ssg));        
    alarmas alarmas1ns(.sel(sel),.sum(sum),.out(light));

endmodule