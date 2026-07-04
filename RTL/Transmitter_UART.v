
module tx(
    input clk,
    input rst,

    input tx_tick,
    input tx_start,

    input [7:0] data_in,

    output reg tx_wire,
    output reg busy
);

reg [1:0] state;
reg [7:0] data_reg;
reg [2:0] bit_count;

parameter IDLE  = 2'b00;
parameter START = 2'b01;
parameter DATA  = 2'b10;
parameter STOP  = 2'b11;

always @(posedge clk)
begin
    if(!rst)
    begin
        state <= IDLE;
        tx_wire <= 1'b1;
        busy <= 0;

        data_reg <= 0;
        bit_count <= 0;
    end

    else
    begin
        case(state)

        IDLE:
        begin
            tx_wire <= 1'b1;
            busy <= 0;

            if(tx_start)
            begin
                busy <= 1;
                data_reg <= data_in;
                bit_count <= 0;
                state <= START;
            end
        end

        START:
        begin
            tx_wire <= 1'b0;

            if(tx_tick)
                state <= DATA;
        end

        DATA:
        begin
            tx_wire <= data_reg[bit_count];

            if(tx_tick)
            begin
                if(bit_count == 7)
                    state <= STOP;
                else
                    bit_count <= bit_count + 1;
            end
        end

        STOP:
        begin
            tx_wire <= 1'b1;

            if(tx_tick)
                state <= IDLE;
        end

        default:
        begin
            state <= IDLE;
        end

        endcase
    end
end

endmodule