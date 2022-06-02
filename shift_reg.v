module shift_reg (
    output  wire            serial_out,

    input   wire    [7:0]   parallel_in,
    input   wire            serial_in,
    input   wire            shift,
    input   wire            load,
    input   wire            clk,
    input   wire            rst
);
    reg     [7:0]   data;
    wire    [7:0]   data_next;

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
                        data <= data_next;
                    end
        end
    

    assign  data_next   = {serial_in,data[7:1]};
    assign  serial_out  = data[0];

endmodule