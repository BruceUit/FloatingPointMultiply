module exponent_add_CLA(sum,clk,exp1,exp2);
	input [7:0] exp1,exp2;
	input clk;
	output sum;
	
	reg [7:0] sum;
	wire [7:0] first_add; //exp1 + exp2 
	wire [7:0] second_add; //first_add - bias
	wire c1,c2;
	//combinational logic
	CLA_8bits inst0(first_add,c1,1'b0,exp1,exp2); //cin == 0
	CLA_8bits inst1(second_add,c2,c1,first_add,8'b10000001); // subtract bias = 127
	
	always @ (posedge clk) begin
		sum<=second_add;
	end
endmodule
