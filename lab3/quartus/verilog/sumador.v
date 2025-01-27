module sumador(sel, baterias, sum);
    input [15:0] baterias;
    input sel;
    output reg [8:0] sum;

    wire [8:0] sum_case0;
    wire [8:0] sum_case1;

    // Caso sel == 0
    sumador8b sum8ins(
        .a(baterias[15:8]),
        .b(baterias[7:0]),
        .sum(sum_case0[7:0]),
        .cout(sum_case0[8])
    );

    // Caso sel == 1
    wire [4:0] sum1, sum2;
    sumador4b sum4ins1(
        .a(baterias[15:12]),
        .b(baterias[11:8]),
        .sum(sum1[3:0]),
        .cout(sum1[4])
    );
    sumador4b sum4ins2(
        .a(baterias[7:4]),
        .b(baterias[3:0]),
        .sum(sum2[3:0]),
        .cout(sum2[4])
    );
    sumador8b sum8ins2(
        .a(sum1[3:0]),
        .b(sum2[3:0]),
        .sum(sum_case1[7:0]),
        .cout(sum_case1[8])
    );

    // Selección según el valor de sel
    always @(*) begin
        if (sel == 1'b0)
            sum = sum_case0;
        else
            sum = sum_case1;
    end
endmodule

module sumador1b(a, b, cin, sum, cout);
    input a, b, cin;
    output sum, cout;
    assign sum = cin ^ (a ^ b);  
    assign cout = (cin & (a ^ b)) | (a & b);
endmodule

module sumador4b_cin(a, b, sum, cin, cout);
    input [3:0] a, b;
    input cin;
    output [3:0] sum;
    output cout;
    wire [2:0] ctem;
    sumador1b bit1(a[0], b[0], cin, sum[0], ctem[0]);
    sumador1b bit2(a[1], b[1], ctem[0], sum[1], ctem[1]);
    sumador1b bit3(a[2], b[2], ctem[1], sum[2], ctem[2]);
    sumador1b bit4(a[3], b[3], ctem[2], sum[3], cout);
endmodule

module sumador4b(a, b, sum, cout);
    input [3:0] a, b;
    output [3:0] sum;
    output cout;
    sumador4b_cin bits(
        .a(a[3:0]),
        .b(b[3:0]),
        .cin(1'b0),
        .sum(sum[3:0]),
        .cout(cout)
    );
endmodule

module sumador8b(a, b, sum, cout);
    input [7:0] a, b;
    output [7:0] sum;
    output cout;
    wire ctem;
    sumador4b bits1_4(
        .a(a[3:0]),
        .b(b[3:0]),
        .sum(sum[3:0]),
        .cout(ctem)
    );
    sumador4b bits5_8(
        .a(a[7:4]),
        .b(b[7:4]),
        .sum(sum[7:4]),
        .cout(cout)
    );
endmodule
