module traffic_contrl(clk,reset, tf0, tf1, tf2, count_ns_4b,count_sn_4b, count_ew_4b, count_we_4b, counter_s, counter_car, t_add, state, n);
    input clk,reset;
    input [3:0 ] count_ns_4b,count_sn_4b, count_ew_4b, count_we_4b;
    output [2:0] tf0, tf1, tf2; 

    //clockdiv #(.n(25_000_000)) clock_2hz_ins(.clkin(clk), .clkout(clk_2hz));
    
    reg [5:0] tfst; // señal para establecer luces de semaforo
    reg [5:0] green; // registro que permite conocer cual fue el ùltimo verde 
    reg [5:0] yellow; // registro que permite conocer cual fue el ùltimo amarillo 
    output reg [4:0] counter_s; //
    output reg [4:0] counter_car;
    output reg [4:0] t_add;
    output reg [2:0] n;
    wire [2:0] tf0_t, tf1_t, tf2_t; 

    assign tf0 = ~tf0_t;
    assign tf1 = ~tf1_t;
    assign tf2 = ~tf2_t;

    trafficlight t0(.green(tf0_t[2]), .yellow(tf0_t[1]), .red(tf0_t[0]), .state(tfst[1:0])); //we
    trafficlight t1(.green(tf1_t[2]), .yellow(tf1_t[1]), .red(tf1_t[0]), .state(tfst[3:2]));//ew
    trafficlight t2(.green(tf2_t[2]), .yellow(tf2_t[1]), .red(tf2_t[0]), .state(tfst[5:4])); //ns y sn

    localparam init = 3'b000;
    localparam cambio_verde = 3'b001;
    localparam conteo = 3'b010;
    localparam adicion = 3'b011;
    localparam espera_aditiva = 3'b100;
    localparam espera_amarillo =  3'b101;
    localparam espera_rojo = 3'b110; 

    output reg [2:0] state;

    initial begin
        counter_s <= 5'd0;
        t_add <= 4'd0;
        n <= 4;
        counter_car <=5'd0;
        yellow <= 6'b000100;
        green <= 6'b001000;
        state <= init;
        tfst <=6'b000000;
    end

    always @(posedge  clk or posedge reset) begin
        if (reset ==1) begin
            state <=init;
        end 
        else case (state)
            init: begin
                counter_s <= 5'd0;
                t_add <= 4'd0;
                n <= 4;
                counter_car <=5'd0;
                yellow <= 6'b000100;
                green <= 6'b001000;
                state <= cambio_verde;
                tfst <=6'b000000;
            end
            cambio_verde: begin
                if(counter_s ==0)begin
                    green <= {green[3:0], green[5:4]};
                    yellow <= {yellow[3:0], yellow[5:4]};
                end else if (counter_s ==1) begin
                    tfst <= green;
                end
                if(counter_s ==7) begin
                    counter_s <= 0;
                    state <= conteo;
                    n <= 4;
                end else counter_s <= counter_s +1;
            end 
            conteo: begin
                if (n ==0) begin
                    state <= espera_amarillo;
                    counter_s <= 0;
                end else counter_s <= counter_s +1;

                if (counter_s ==0 ) begin
                    if (tfst == 6'b100000) begin
                        counter_car <= count_ns_4b + count_sn_4b;
                    end else if (tfst == 6'b001000) begin
                        counter_car <= count_ew_4b;
                    end else begin
                        counter_car <= count_we_4b;;
                    end
                end 
                if(counter_s == (2*n+1)) begin
                    if (tfst == 6'b100000) begin
                        if((count_ns_4b + count_sn_4b - counter_car) < counter_car ) begin
                            counter_car <= count_ns_4b + count_sn_4b - counter_car +32; //overlap    
                        end else begin
                            counter_car <= count_ns_4b + count_sn_4b - counter_car;
                        end
                    end else if (tfst == 6'b001000) begin
                        if((count_ew_4b - counter_car < counter_car)) begin
                            counter_car <= count_ew_4b - counter_car;
                        end else counter_car <= count_ew_4b - counter_car;
                    end else begin
                        if((count_we_4b - counter_car < counter_car)) begin
                            counter_car <= count_we_4b - counter_car;
                        end else counter_car <= count_we_4b - counter_car;
                    end
                    counter_s <= 0;
                    state <= adicion;
                end                                          
            end
            adicion: begin
                if (counter_car  < 4) begin
                    t_add <= 8;
                end else if (counter_car  < 8) begin
                    t_add <= 12;
                end else if (counter_car  < 12) begin
                    t_add <= 16;
                end else if (counter_car  < 16) begin
                    t_add <= 20;
                end else t_add <= 24;
                state <= espera_aditiva;
            end
            espera_aditiva: begin
                if (counter_s == t_add -1) begin
                    n <= n-1;
                    counter_s <= 0;
                    state <= conteo;
                end else counter_s <= counter_s +1;
            end
            espera_amarillo: begin
                if (counter_s == 6) begin
                    counter_s <= 0;
                    state <= espera_rojo;
                end else begin
                    counter_s <= counter_s+1;
                    tfst <= yellow; 
                end
            end
            espera_rojo: begin
                if (counter_s == 20) begin
                    counter_s <= 0;
                    state <= cambio_verde;
                end else begin
                    counter_s <= counter_s+1;
                    tfst <= 6'b000000; 
                end
            end
        endcase
    end
endmodule