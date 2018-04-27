module exponent_add_CLA(exp,overflow,clk,exp1,exp2,inc_exp,resetn);
	input [7:0] exp1,exp2;
	input inc_exp;
	input clk;
	input resetn;
	output exp;
	output overflow;
	
	reg [7:0] exp;
	reg overflow;
	
	wire [7:0] first_add; //exp1 + exp2 
	wire [7:0] exp_not_inc; //first_add - bias
	wire [7:0] exp_inc_ed; //first_add - bias + 1
	wire [7:0] sum;
	wire c1,c2,c3;
	wire tmp;
	//combinational logic
	CLA_8bits inst0(first_add,c1,exp1,exp2,1'b0); //cin == 0
	CLA_8bits inst1(exp_not_inc,c2,first_add,8'b10000001,c1); // subtract bias = 127
	CLA_8bits inst2(exp_inc_ed,c3,first_add,8'b10000010,c1); // subtract bias = 127, add 1
	
	//mux, bit 47 of man_mul is the control
	assign {tmp,sum} = (inc_exp)?{c3,exp_inc_ed}:{c2,exp_not_inc};
	
	always @ (posedge clk or negedge resetn) begin
		if (!resetn) {overflow,exp} <= 9'b0;
		else {overflow,exp} <= {tmp,sum};
	end
endmodule
