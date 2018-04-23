`timescale 1ns/1ps
module multiplier_tb();
	reg clk, start, reset;
	reg [23:0] x,y;
	wire [47:0] p;
	wire out_en;
	
	multiplier inst(clk,start,reset,x,y,p,out_en);
	//multiplier inst(clk,start,reset,x,y,p);
	always #10 clk = ~clk;
	
	initial begin
		$monitor("time= %d, clk= %b, start= %b, reset= %b, x= %d, y= %d, p= %d, out_en= %b",$time,clk,start,reset,x,y,p,out_en);
		clk <= 0;
		start <= 0;
		reset <= 1;
		#15 x <= 24'd91;
		y<= 24'd10;
		#10 start <= 1;
		#100 reset <= 0;
		#10 reset <= 1;
		#2000 $finish;
	end
endmodule