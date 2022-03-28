module clk_div #(parameter COUNT_SIZE = 7)(

	input	wire	[2:0]	sel,
	input	wire			clk,
	input	wire			rst,
	
	output	wire			sclk
);

	reg	[COUNT_SIZE-1:0]	count_comb;
	reg	[COUNT_SIZE-1:0]	count;

	always @(posedge clk or negedge rst)
		begin
			if(!rst)
				begin
					count <= 'b0;
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

    assign  sclk = count[sel];

endmodule