
module UART_top(
    input clk,
    input rst,

    input rx_wire,
    output tx_wire,

    input [7:0] data_in,
    input tx_start,

    input uart_case_switch,
    
input [3:0] add_value,

    output [7:0] data_out,
    output rx_done,
    output busy
);

wire tx_tick;
wire rx_tick;

wire [7:0] rx_data;

reg [7:0] tx_data;

reg [7:0] fifo [0:7];

reg [2:0] write_ptr;
reg [2:0] read_ptr;

reg [3:0] fifo_count;

reg [7:0] processed_data;

reg tx_start_reg;


wire tx_start_pulse;




always @(*)
begin

   
    

    processed_data = rx_data;

    
   
   

    if(uart_case_switch)
    begin
        if(rx_data >= 8'd65 &&
           rx_data <= 8'd90)

            processed_data = rx_data + 8'd32;
    end

    
    
    

    if(rx_data >= 8'd48 &&
       rx_data <= 8'd57)
    begin

        processed_data =
        (((rx_data - 8'd48) + add_value) % 10)
        + 8'd48;

    end

end




always @(posedge clk )
begin
    if(!rst)
    begin
        write_ptr <= 0;
        read_ptr <= 0;

        fifo_count <= 0;

        tx_data <= 0;

        tx_start_reg <= 0;
    end

    else
    begin

        
        
        

        tx_start_reg <= 0;

       
       
      

        if(rx_done && fifo_count < 8)
        begin
           
             
            fifo[write_ptr] <= processed_data;

            write_ptr <= write_ptr + 1;

            fifo_count <= fifo_count + 1;
        end

        
       
       

        if(tx_start_pulse && !busy)
        begin
            if(uart_case_switch &&
               data_in >= 8'd65 &&
               data_in <= 8'd90)

                tx_data <= data_in + 8'd32;

            else
                tx_data <= data_in;

            tx_start_reg <= 1;
        end

      
       
      

        else if(!busy && fifo_count > 0)
        begin
            tx_data <= fifo[read_ptr];

            read_ptr <= read_ptr + 1;

            fifo_count <= fifo_count - 1;

            tx_start_reg <= 1;
        end
    end
end




debounce db(
    .clk(clk),
    .rst(rst),
    .btn(tx_start),
    .btn_pulse(tx_start_pulse)
);


baud_generator bg(
    .clk(clk),
    .rst(rst),

    .tx_tick(tx_tick),
    .rx_tick(rx_tick)
);


tx transmitter(
    .clk(clk),
    .rst(rst),

    .tx_tick(tx_tick),

    .tx_start(tx_start_reg),

    .data_in(tx_data),

    .tx_wire(tx_wire),

    .busy(busy)
);

rx receiver(
    .clk(clk),
    .rst(rst),

    .rx_tick(rx_tick),

    .rx_wire(rx_wire),

    .data_out(rx_data),

    .rx_done(rx_done)
);

assign data_out = processed_data;

endmodule