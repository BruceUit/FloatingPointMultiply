module FP_multiplier(clk,start,resetn,fp1,fp2,product,overflow);
	input clk;
	input resetn;
	input start;
	input [31:0] fp1;
	input [31:0] fp2;
	output [31:0] product;
	output overflow;
	
	wire inc,xx;
	wire [47:0] temp;
	sign sign_inst(clk,resetn,fp1[31],fp2[31],product[31]);
	exponent_add_CLA exponent_add_CLA_inst(product[30:23],overflow,clk,fp1[30:23],fp2[30:23],inc,resetn);
	multiplier multiplier_inst(clk,start,resetn,{1'b1,fp1[22:0]},{1'b1,fp2[22:0]},temp,xx);
	normalizer normalizer_inst(product[22:0],inc,clk,temp,resetn);


endmodule