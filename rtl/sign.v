module sign(clk,resetn,s1,s2,result);
	input clk,resetn;
	input s1,s2;
	output reg result;
	
	wire tmp;
	
	xor xor_0(tmp,s1,s2);
	
	always @(posedge clk or negedge resetn) begin
		if(!resetn) result <= 0;
		else result <= tmp;
	end


endmodule
