`timescale 1ns/1ps
module datapath_tb();
	reg clk,init,load,clear,shift,out_en;
	reg [23:0] x,y;
	wire [47:0] p;
	wire zero;
	wire lsb;
	shift_add inst1(clk,init,load,clear,shift,out_en,x,y,p,zero,lsb);
	
	always #10 clk = ~clk;
	
	initial begin
		$monitor("p= %d,zero= %b, lsb= %b",p,zero,lsb);
		clk =0;
		#15 
		init <= 1'b1;
				load <= 1'b0;
				clear <= 1'b0;
				shift <= 1'b0;
		#1000 out_en <= 1'b1;
		
		#20 $finish;
	end
	
endmodule 