module multiplier(
	input clk,
	input start,
	input reset,
	input [23:0] x,
	input [23:0] y,
	output [47:0] p,
	output out_en
	);
	wire lsb,zero,init,load,clear,shift;
	control_unit inst0(clk,start,reset,lsb,zero,init,load,clear,shift,out_en);
	//control_unit inst0(clk,start,reset,lsb,zero,init,load,clear,shift);
	shift_add inst1(clk,init,load,clear,shift,out_en,x,y,p,zero,lsb);
	//shift_add inst1(clk,init,load,clear,shift,x,y,p,zero,lsb);
endmodule