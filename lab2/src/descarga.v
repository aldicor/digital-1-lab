module bateria(carga,warn);
    input [3:0] carga;
    output warn;
    assign warn = (~carga[0]&~carga[1])&(~carga[2]&~carga[3]);
endmodule


module bateria2(carga1,carga2,warn1,warn2);
    input [3:0] carga1,carga2;
    output warn1, warn2;
    bateria bateria1(.carga(carga1), .warn(warn1));
    bateria bateria2(.carga(carga2), .warn(warn2));
endmodule