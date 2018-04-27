module normalizer(
				output reg [22:0] mantissa,
				output reg inc_exp,
				input clk,
				input [47:0] in,
				input resetn
				);
				
	//mantissa;
	//reg inc_exp;
	
	always @(posedge clk or negedge resetn) begin
		if(!resetn) begin
					mantissa <= 23'b0;
					inc_exp <= 0;
					end
		else if(in[47]) begin
					mantissa <= in[46:24];
					inc_exp <= 1;
				end
		else if(in[46]) begin
					mantissa <= in[45:23];
					inc_exp <= 0;	
				end
	end
endmodule