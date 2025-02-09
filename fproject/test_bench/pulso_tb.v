`include "Pruebas_motor/freq_div.v"
`include "Pruebas_motor/pulso.v"
`timescale 1us/1us

module pulso_tb();
    reg clin;

    pulso uut(
        .clk(clin)
    );
    initial begin
        clin = 0;
        forever #25 clin = ~clin;
    end

    initial begin: TEST_CASE
        $dumpfile("prueba4.vcd");
        $dumpvars(-1,uut);
        #10000000 $finish;
    end

endmodule