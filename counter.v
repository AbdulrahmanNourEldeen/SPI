module counter (
    output  wire    overflow,

    input   wire    count_enable,
    input   wire    clk,
    input   wire    rst
);

    reg [3:0]   count;
    reg [3:0]   count_comb;

    always @(posedge clk or negedge rst) 
        begin
            if(!rst)
                begin
                    count <= 4'd0;
                end
            else if (count_enable)
                    if(count == 4'd8)
                        begin
                            count <= 4'd0;
                        end
                    else 
                        begin
                            count <= count_comb;
                        end
        end

    always @(*) 
        begin
            count_comb = count + 1'd1;
        end

    assign overflow = (count == 4'd8);

endmodule