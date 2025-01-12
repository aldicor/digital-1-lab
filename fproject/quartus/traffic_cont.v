module traffic_contr(clk50M, tf0, tf1, tf2);
    input  clk50M;
    output [2:0] tf0, tf1, tf2; //green-yellow-red

    reg [5:0] tfst;
    wire [2:0] tf0_t, tf1_t, tf2_t;

    assign tf0 = ~tf0_t;
    assign tf1 = ~tf1_t;
    assign tf2 = ~tf2_t;

    trafficlight t0(.green(tf0_t[2]), .yellow(tf0_t[1]), .red(tf0_t[0]), .state(tfst[1:0]));
    trafficlight t1(.green(tf1_t[2]), .yellow(tf1_t[1]), .red(tf1_t[0]), .state(tfst[3:2]));
    trafficlight t2(.green(tf2_t[2]), .yellow(tf2_t[1]), .red(tf2_t[0]), .state(tfst[5:4]));

    wire clock1s;
    clockdiv #(.n(25000000)) clk1sinstance(.clkin(clk50M), .clkout(clock1s));

    reg [5:0] count_s = 0;
    reg [3:0] state = 0;

    reg [5:0] t_on = 5;

    always @(posedge clock1s) begin
        count_s <= count_s +1;
        if (count_s == t_on) begin
            state <= state + 1;
            count_s <= 0;
            if (state == 11) begin
                state <=0;
            end
        end 
    end

    always @(state) begin
        case (state)
            4'h0:begin
              tfst = 6'b000000;
              t_on = 5;
            end
            //tf0 
            4'h1: begin
              tfst = 6'b110000;
              t_on = 2;
            end
            4'h2: begin
              tfst = 6'b100000;
              t_on = 10;
            end 
            4'h3: begin
                tfst = 6'b010000;
                t_on = 2;
            end
            //
            4'h4: begin
              tfst = 6'b000000;
              t_on = 5;
            end
            //tf1
            4'h5: begin
              tfst = 6'b001100;
              t_on = 2;
            end
            4'h6: begin
              tfst = 6'b001000;
              t_on = 10;
            end
            4'h7: begin
              tfst = 6'b000100;
              t_on = 2;
            end
            //
            4'h8: begin
              tfst = 6'b000000;
              t_on = 5;
            end
            //tf2
            4'h9: begin
              tfst = 6'b000011;
              t_on = 2;
            end
            4'ha: begin
              tfst = 6'b000010;
              t_on = 10;
            end
            4'hb: begin
              tfst = 6'b000001;
              t_on = 2;
            end
            default: begin
              tfst = 6'b000000;
              t_on = 5;
            end
        endcase
    end
    



endmodule