`timescale 1ns/1ps
module test_cu();
	reg clk, start, reset;
	reg [23:0] x,y;
	wire [47:0] p;
	reg [10:0] clk_count;
	control_unit ins(clk,start,reset,x,y,p);
	
	always #10 clk =~clk;
	
	always @(posedge clk) begin
		if(!start) clk_count <=0;
		else begin
				
				clk_count <= clk_count +1;
				$display("------Clock= %d", clk_count);
				end
	end
	
	initial begin
		$monitor("Time= %d,start= %b,reset= %b,x= %d, y= %d, p= %d",$time,start,reset,x,y,p);
		clk=0;
		start=0;
		reset=1;
		#15 start <= 1;
		#10 x <= 24'd110;
		y <= 24'd29;
		#2000 $finish;
	end
endmodule