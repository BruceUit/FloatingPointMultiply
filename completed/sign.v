module sign(clk,out_en,init,s1,s2,result);
	input clk;
	input out_en;
	input init;
	input s1;
	input s2;
	output reg result;
	
	wire tmp;
	
	xor xor_0(tmp,s1,s2);
	
	always @(posedge clk) begin
		if(init) result <= 1'b0;
		else if(out_en) result <= tmp;
		//else result <= 1'bx;
	end


endmodule
