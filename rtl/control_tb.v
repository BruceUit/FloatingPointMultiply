`timescale 1ns/1ps
module control_tb();
	reg clk, start, reset;
	reg lsb,zero;
	wire init,load,clear,shift,out_en;
	control_unit ins(clk,start,reset,lsb,zero,init,load,clear,shift,out_en);
	
	always #10 clk =~clk;
	
	initial begin
		$monitor("clk= %b,start= %b,reset= %b,lsb = %b,zero= %b,init= %b,load= %b,clear =%b,shift= %b,out_en =%b",clk,start,reset,lsb,zero,init,load,clear,shift,out_en);
		clk=0;
		start=0;
		reset=1;
		lsb=0;
		zero=0;
		#15 start <= 1;
		#20 zero <= 1; 
		#100 reset <= 0;
		#10 reset <= 1;
		#10 start <= 1;
		#10 lsb <= 1;
		#10 zero <= 1;
		#20 $finish;
	end
endmodule