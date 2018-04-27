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
		$monitor("time= %d, clk= %b, start= %b, reset= %b, x= %b, y= %b, p= %b, out_en= %b",$time,clk,start,reset,x,y,p,out_en);
		clk <= 0;
		start <= 0;
		reset <= 1;
		#15 x <= 24'b1000_0001_1111_1111_0010_0000;					//‭1000_0001_1111_1111_0010_0000
		y<= 24'b1000_0000_0000_1110_0000_0000;								//y<= 24'b1000_0000_0000_1110_0000_0000‬;
		#10 start <= 1;
		#100 reset <= 0;
		#10 reset <= 1;
		#2000 $finish;
	end
endmodule