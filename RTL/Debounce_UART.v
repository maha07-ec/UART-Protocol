module debounce(
    input clk,
    input rst,
    input btn,

    output reg btn_pulse
);

reg [19:0] counter;
reg btn_sync;
reg btn_state;

always @(posedge clk)
begin
    if(!rst)
    begin
        counter <= 0;
        btn_sync <= 0;
        btn_state <= 0;
        btn_pulse <= 0;
    end

    else
    begin
        btn_sync <= btn;

        btn_pulse <= 0;

        if(btn_sync != btn_state)
        begin
            counter <= counter + 1;

            if(counter == 999999)
            begin
                btn_state <= btn_sync;

                if(btn_sync == 1)
                    btn_pulse <= 1;

                counter <= 0;
            end
        end

        else
            counter <= 0;
    end
end

endmodule