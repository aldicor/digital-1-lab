module traffic_contrl(clk, tf0, tf1, tf2, count_ns_4b,count_sn_4b, count_ew_4b, count_we_4b);
    input clk;
    input [3:0 ] count_ns_4b,count_sn_4b, count_ew_4b, count_we_4b;
    output [2:0] tf0, tf1, tf2;

    wire clk_2hz; 

    clockdiv #(.n(25000000)) clock_2hz_ins(.clkin(clk), .clkout(clk_2hz));
    
    reg [5:0] tfst; // señal para establecer luces de semaforo
    reg [5:0] green; // registro que permite conocer cual fue el ùltimo verde 
    reg [5:0] yellow; // registro que permite conocer cual fue el ùltimo amarillo 
    reg [4:0] counter_s; //
    reg [4:0] counter_car;
    reg [2:0] t_add;
    reg [2:0] n;
    wire [2:0] tf0_t, tf1_t, tf2_t; 

    assign tf0 = ~tf0_t;
    assign tf1 = ~tf1_t;
    assign tf2 = ~tf2_t;

    trafficlight t0(.green(tf0_t[2]), .yellow(tf0_t[1]), .red(tf0_t[0]), .state(tfst[1:0]));
    trafficlight t1(.green(tf1_t[2]), .yellow(tf1_t[1]), .red(tf1_t[0]), .state(tfst[3:2]));
    trafficlight t2(.green(tf2_t[2]), .yellow(tf2_t[1]), .red(tf2_t[0]), .state(tfst[5:4]));

    localparam init = 3'b000;
    localparam cambio_verde = 3'b001;
    localparam conteo = 3'b010;
    localparam adicion = 3'b011;
    localparam espera_aditiva = 3'b100;
    localparam espera_amarillo =  3'b101;
    localparam espera_rojo = 3'b110; 

    reg [2:0] state;

    initial begin
        
    end

    always @(posedge clk_2hz) begin
        case (state)
            init: begin
                green  <= 6'b100000;
                yellow <= 6'b010000;
                n <= 5;
            end
            cambio_verde: begin
                if(count_s ==0)begin
                    green <= {green[3:0], green[5:4]};
                    yellow <= {yellow[3:0], yellow[5:4]};
                    tfst <= green;
                end 
                else if(count_s ==10) begin
                    count_s <= 0;
                    state <= conteo;
                    n <= 5;
                end
                else count_s <= count_s +1;
            end 
            conteo: begin
                if (n ==0) begin
                    state <= espera_amarillo;
                    count_s <= 0;
                end
                if (count_s ==0 ) begin
                    if (tfst == 6'b000010) begin
                        counter_car <= count_ns_4b + count_sn_4b;
                    end else if (tfst == 6'b001000) begin
                        counter_car <= count_ew_4b;
                    end else begin
                        counter_car <= count_we_4b;;
                    end
                end if(count_s == (2*n)) begin
                    if (tfst == 6'b000010) begin
                        if((count_ns_4b + count_sn_4b - counter_car) < counter_car ) begin
                            counter_car <= count_ns_4b + count_sn_4b - counter_car +16; //overlap    
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
                    count_s <= 0;
                    state <= adicion;
                end else count_s <= count_s +1;                                         
            end
            adicion: begin
                if (counter_car  < 4) begin
                    t_add <= 2;
                end else if (counter_car  < 8) begin
                    t_add <= 4;
                end else if (counter_car  < 12) begin
                    t_add <= 8;
                end else if (counter_car  < 16) begin
                    t_add <= 10;
                end
                state <= espera_aditiva;
            end
            espera_aditiva: begin
                if (count_s == t_add ) begin
                    n <= n-1;
                    count_s <= 0;
                    state <= conteo;
                end else count_s <= count_s +1;
            end
            espera_amarillo: begin
                if (count_s == 6) begin
                    count_s <= 0;
                    state <= espera_rojo;
                end else begin
                    count_s <= count_s+1;
                    tfst <= yellow; 
                end
            end
            espera_rojo: begin
                if (count_s == 14) begin
                    count_s <= 0;
                    state <= cambio_verde;
                end else begin
                    count_s <= count_s+1;
                    tfst <= 6'b000000; 
                end
            end
        endcase
    end
endmodule