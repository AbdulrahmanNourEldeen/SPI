module mux (
    output  wire    result,

    input   wire    inputA,
    input   wire    inputB,
    input   wire    sel
);

assign  result  = (sel) ? inputA : inputB;
    
endmodule