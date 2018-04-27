module test_top();
	reg clk;
	reg resetn;
	reg start;
	reg [31:0] fp1;
	reg [31:0] fp2;
	wire [31:0] product;
	wire overflow;
	
	FP_multiplier FP_multiplier_ins(clk,resetn,start,fp1,fp2,product,overflow);
	
	always #10 clk= ~clk;
	
	initial begin
		$monitor("Time= %d, clk= %b,resetn= %b, start= %b,fp1= %h, fp2= %h, product= %b,overflow= %b",$time,clk,resetn,start,fp1,fp2,product,overflow);
		clk=0;
		resetn=0;
		start=0;
		#13 resetn = 1;
		start = 1;
		#2 fp1 = 32'b1100_0001_1001_0000_0000_0000_0000_0000;
		fp2 = 32'b0100_0001_0001_1000_0000_0000_0000_0000;
		#2000 $finish;
	end

endmodule
