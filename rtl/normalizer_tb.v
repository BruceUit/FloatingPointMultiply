`timescale 1ns/1ps
module normalizer_tb();
	reg clk;
	reg [47:0] in;
	wire [22:0] mantissa;
	wire inc_exp;
	
	normalizer ins(mantissa,inc_exp,clk,in);
	
	always #10 clk= ~clk;
	
	initial begin
		clk = 0;
		$monitor("Time= %d, Clk = %b, Input= %h, inc_exp= %b, mantissa= %b",$time,clk,in,inc_exp,mantissa);
		#15 in = 48'b0100_0001_0000_0110_1010_1011_1111_0011_1100_0000_0000_0000;
		
		#30 in = 48'b1000_0001_0000_0110_1010_1011_1111_0011_1100_0000_0000_0000;
		#100 $finish;
	end
	

endmodule
