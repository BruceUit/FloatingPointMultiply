module test_top();
	reg clk;
	reg resetn;
	reg start;
	reg [31:0] FP1;
	reg [31:0] FP2;
	wire [31:0] result;
	wire ovf;
	reg [10:0] clk_count;
	
	FP_multiplier FP_inst(clk,start,resetn,FP1,FP2,result,ovf);
	
	always #10 clk= ~clk;
	
	always @(posedge clk) begin
		if(!start) clk_count <=0;
		else begin
				
				clk_count <= clk_count +1;
				$display("------Number of periods: %d", clk_count);
				end
	end
	
	initial begin
		$monitor("Time= %d,resetn= %b, start= %b,fp1= %h, fp2= %h, product= %b,overflow= %b",$time,resetn,start,FP1,FP2,result,ovf);
		clk=0;
		resetn=0;
		start=0;
		#13 resetn = 1;
		start = 1;
		#2 FP1 = 32'b1100_0001_1001_0000_0000_0000_0000_0000;
		FP2 = 32'b0100_0001_0001_1000_0000_0000_0000_0000;
		#2000 $finish;
	end

endmodule