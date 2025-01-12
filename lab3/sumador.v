module sumador1b(a,b,cin,sum,cout);
    input a,b,cin;
    output sum, cout;
    assign sum = cin^(a^b);  
    assign cout = (cin&(a^b))|(a&b);
endmodule

module sumador4b_cin(a,b,sum,cin,cout);
    input [3:0] a,b;
    input cin;
    output [3:0] sum;
    output cout;
    wire [2:0] ctem;

    sumador1b bit1(a[0],b[0],cin,sum[0],ctem[0]);
    sumador1b bit2(a[1],b[1],ctem[0],sum[1],ctem[1]);
    sumador1b bit3(a[2],b[2],ctem[1],sum[2],ctem[2]);
    suamdor1b bit4(a[3],b[3],ctem[2],sum[3],cout);
endmodule
module sumador4b(a,b,sum,cout);
    input [3:0] a,b;
    output [3:0] sum;
    output cout;
    
    sumador4b_cin bits(a[3:0],b[3:0],sum[3:0],1'b0,cout);
endmodule

module sumador8b(a,b,sum,cout);
    input [7:0] a,b;
    output [7:0] sum;
    output cout;
    wire ctem;

    sumador4b bits1_4(a[3:0],b[3:0],1'b0,sum[4:0],ctem);
    sumador4b bits5_8(a[7:4],b[7:4],ctem,sum[7:4],cout);
endmodule


