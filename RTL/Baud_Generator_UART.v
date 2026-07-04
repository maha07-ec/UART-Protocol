
module baud_generator(
    input clk,
    input rst,

    output reg tx_tick,
    output reg rx_tick
);

reg [13:0] tx_counter;
reg [9:0]  rx_counter;

always @(posedge clk)
begin
    if(!rst)
    begin
        tx_counter <= 0;
        rx_counter <= 0;

        tx_tick <= 0;
        rx_tick <= 0;
    end

    else
    begin
        if(tx_counter == 10415)
        begin
            tx_counter <= 0;
            tx_tick <= 1;
        end
        else
        begin
          tx_tick<=0;
            tx_counter <= tx_counter + 1;
           
         end
        
        if(rx_counter == 650)
        begin
            rx_counter <= 0;
            rx_tick <= 1;
        end
        else
        begin  
        rx_tick<=0;
            rx_counter <= rx_counter + 1;
            end
           
    end
end

endmodule