

module UART_top_tb;

reg clk;
reg rst;

reg rx_wire;

wire tx_wire;

reg [7:0] data_in;
reg tx_start;

reg uart_case_switch;
reg [3:0] add_value;

wire [7:0] data_out;
wire rx_done;
wire busy;





UART_top uut(
    .clk(clk),
    .rst(rst),

    .rx_wire(rx_wire),
    .tx_wire(tx_wire),

    .data_in(data_in),
    .tx_start(tx_start),

    .uart_case_switch(uart_case_switch),
    .add_value(add_value),

    .data_out(data_out),
    .rx_done(rx_done),
    .busy(busy)
);




always #5 clk = ~clk;      





task send_uart;

input [7:0] data;

integer i;

begin

    // START BIT
    rx_wire = 0;
    #(104160);

    // DATA BITS
    for(i = 0; i < 8; i = i + 1)
    begin
        rx_wire = data[i];
        #(104160);
    end

    // STOP BIT
    rx_wire = 1;
    #(104160);

end

endtask





initial
begin

    clk = 0;

    rst = 0;

    rx_wire = 1;

    data_in = 0;

    tx_start = 0;

    uart_case_switch = 1;

    add_value = 3;

    #100;

    rst = 1;

    #1000000;

    
    send_uart(8'd65);

    #3000000;

 
    send_uart(8'd66);

    #3000000;

   
    send_uart(8'd67);

    #3000000;

   
    send_uart(8'd55);

    #3000000;

    $finish;

end





always @(posedge rx_done)
begin

    $display("====================================");

    $display("INPUT CHARACTER     = %c", uut.rx_data);

    $display("INPUT ASCII VALUE   = %0d", uut.rx_data);

    $display("OUTPUT CHARACTER    = %c", data_out);

    $display("OUTPUT ASCII VALUE  = %0d", data_out);

    $display("====================================");

end

endmodule