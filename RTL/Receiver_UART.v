
module rx(
    input clk,
    input rst,

    input rx_tick,
    input rx_wire,

    output reg [7:0] data_out,
    output reg rx_done
);

reg [1:0] state;

reg [3:0] sample_count;
reg [2:0] bit_count;

reg [7:0] data_reg;

parameter IDLE  = 2'b00;
parameter START = 2'b01;
parameter DATA  = 2'b10;
parameter STOP  = 2'b11;

always @(posedge clk)
begin
    if(!rst)
    begin
        state <= IDLE;

        sample_count <= 0;
        bit_count <= 0;

        data_reg <= 0;
        data_out <= 0;

        rx_done <= 0;
    end

    else
    begin
        rx_done <= 0;

        if(rx_tick)
        begin
            case(state)

            IDLE:
            begin
                sample_count <= 0;
                bit_count <= 0;

                if(rx_wire == 0)
                    state <= START;
            end

            START:
            begin
                sample_count <= sample_count + 1;

                
                if(sample_count == 8)
                begin
                    if(rx_wire == 0)
                    begin
                        sample_count <= 0;
                        state <= DATA;
                    end
                    else
                        state <= IDLE;
                end
            end

            DATA:
            begin
                sample_count <= sample_count + 1;

                if(sample_count == 15)
                begin
                    sample_count <= 0;

                    data_reg[bit_count] <= rx_wire;

                    if(bit_count == 7)
                    begin
                        bit_count <= 0;
                        state <= STOP;
                    end
                    else
                        bit_count <= bit_count + 1;
                end
            end

            STOP:
            begin
                sample_count <= sample_count + 1;

                if(sample_count == 15)
                begin
                
                    if(rx_wire == 1)
                    begin
                    data_out <= data_reg;
                    rx_done <= 1;
                    end

                    sample_count <= 0;
                    state <= IDLE;
                end
            end

            default:
                state <= IDLE;

            endcase
        end
    end
end

endmodule