module clk_logic (
    output  wire    clk,

    input   wire    CPOL,
    input   wire    CPHA,
    input   wire    clk_div
);
    
    assign clk = (CPOL ^ CPHA)? ~clk_div : clk_div;

endmodule