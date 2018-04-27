module exp_add_tb();

	reg [7:0] exp1,exp2;
	reg inc_exp;
	reg clk;
	reg resetn;
	wire exp;
	wire overflow;
	
	always #10 clk= ~clk;
	
	exponent_add_CLA ins(exp,overflow,clk,exp1,exp2,inc_exp,resetn);
	
	initial begin
		clk=0;
		inc_exp=0;
		exp1= 8'b10000011;
		exp2= 8'b10000010;
		$monitor("clk= %b, e1= %b, e2= %b, inc= %b, exp= %b, overflow= %b",clk,e1,e2,inc_exp,exp,overflow);
		#25 inc_exp = 1;
		#50 $finish;
	end
	
endmodule