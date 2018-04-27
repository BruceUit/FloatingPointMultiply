module datapath(clk,out_en,init,load,clear,shift,done_mul,bit47,FP1,FP2,result,ovf,done_counter,lsb,msb);
	//IO Ports
	input 			clk;
	input 			out_en;
	input 			init;
	input 			load;
	input			clear;
	input			shift;
	input 			done_mul;
	input			bit47;
	input [31:0] 	FP1;
	input [31:0] 	FP2;
	output [31:0]	result;
	output 			ovf;
	output			done_counter;
	output			lsb;
	output			msb;
	
	//Inner signal
	//wire 			inc_exp;
	wire [47:0]		man_mul;
	wire zero;
	assign done_counter = zero;
	
	//Components inst
	sign sign_inst(clk,out_en,init,FP1[31],FP2[31],result[31]);
	exponent_add_CLA exponent_add_CLA_inst(clk,out_en,init,bit47,FP1[30:23],FP2[30:23],result[30:23],ovf);  //chua co inc_exp
	shift_add shift_add_inst(clk,init,load,clear,shift,done_mul,{1'b1,FP1[22:0]},{1'b1,FP2[22:0]},man_mul,zero,lsb);
	normalizer normalizer_inst(clk,init,zero,bit47,out_en,man_mul,result[22:0],msb);

endmodule