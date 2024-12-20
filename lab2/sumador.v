module adder(a,b,cin,cout,sum);
    input   a,b,cin;
    output  cout,sum;
    assign sum  = cin^(a^b);  
    assign cout = (cin&(a^b))|(a&b);
endmodule

module adder4b(A,B,Cout,sum4);
    input [3:0] A,B;
    output [3:0] sum4; 
    output Cout;
    wire [2:0] ctem;

    adder bit1(A[0], B[0],  1'b0     , ctem[0], sum4[0]);
    adder bit2(A[1], B[1], ctem[0], ctem[1], sum4[1]);
    adder bit3(A[2], B[2], ctem[1], ctem[2], sum4[2]);
    adder bit4(A[3], B[3], ctem[2], Cout, sum4[3]);
endmodule