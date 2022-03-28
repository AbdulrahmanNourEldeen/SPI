module shift_reg (
    output  reg            serial_out,

    input   wire    [7:0]   parallel_in,
    input   wire            serial_in,
    input   wire            shift,
    input   wire            load,
    input   wire            clk,
    input   wire            rst
);
    reg     [7:0]   data;

    always @(posedge clk or negedge rst) 
        begin
            if(!rst)
                begin
                    data <= 8'b0;
                end
            else 
                if (load)
                    begin
                        data <= parallel_in;
                    end
                else if (shift)
                    begin
                        serial_out  <= data[0];
                        data        <= data >> 1;
                        data[7]     <= serial_in;
                    end
        end
    

endmodule