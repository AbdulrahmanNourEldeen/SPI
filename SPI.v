module SPI (        
    output  wire            SCLK,
    output  wire            MOSI,

    input   wire            CLK,
    input   wire            RST,
    input   wire            CPOL,
    input   wire            CPHA,
    input   wire            MISO,
    input   wire            Data_Valid,
    input   wire    [7:0]   Data,
    input   wire    [2:0]   div_by
);

wire    clk_div_c;
wire    enable_clk_c;
wire    clk_c;

wire    overflow_c;
wire    count_enable_c;

wire    load_c;
wire    shift_c;

clk_div U0_clk_div (
    .sel(div_by),
    .clk(CLK),
    .rst(RST),
    .sclk(clk_div_c)
);


mux U0_mux (
    .sel(enable_clk_c),
    .inputA(clk_div_c),
    .inputB(CPOL),
    .result(SCLK)
);

clk_logic U0_clk_logic (
    .CPHA(CPHA),
    .CPOL(CPOL),
    .clk_div(clk_div_c),
    .clk(clk_c)
);

counter U0_counter (
    .overflow(overflow_c),
    .count_enable(count_enable_c),
    .clk(clk_c),
    .rst(RST)
);

control_unit U0_control_unit (
    .clk(clk_c),
    .rst(RST),
    .data_valid(Data_Valid),
    .overflow(overflow_c),
    .enable_clk(enable_clk_c),
    .count(count_enable_c),
    .load(load_c),
    .shift(shift_c)
);

shift_reg U0_shift_reg (
    .clk(clk_c),
    .rst(RST),
    .load(load_c),
    .shift(shift_c),
    .serial_in(MISO),
    .serial_out(MOSI),
    .parallel_in(Data)
);
endmodule