module normalizer(
				input clk,
				input init,
				input done_mul,
				input bit47,
				input out_en,
				input [47:0] in,
				output reg [22:0] mantissa,
				output msb
				//output done_nor
				);
				
	//wire msb;
	assign msb = (done_mul)?in[47]:1'b0;
	//mantissa;
	//reg tmp;
	
	//assign done_nor <= tmp;
	
	always @(posedge clk) begin
		if(init) begin
					mantissa <= 23'b0;
					//tmp <= 1'b0;
					end
		else if(bit47&&out_en) begin
					mantissa <= in[46:24];
					//tmp <= 1'b1;
				end
		else if(!bit47&&out_en) begin
					mantissa <= in[45:23];	
					//tmp <= 1'b1;
				end
	end
endmodule