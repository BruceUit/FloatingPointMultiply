module shift_add (
	input clk,
	input init,
	input load,
	input clear,
	input shift,
	input out_en,
	input [23:0] x,
	input [23:0] y,
	output [47:0] p,
	output zero,
	output lsb
	);
	reg [23:0] A;
	reg [23:0] Hi,Lo;
	reg carry;//1 bit for carry out of adder
	reg [4:0] count;
	wire [23:0] sum;
	wire co;
	
	//output signal
	assign lsb = Lo[0]; 
	assign zero = (count==5'd0)?1'b1:1'b0;
	assign p = (out_en)?{Hi,Lo}:48'd0;
	//assign p = {Hi,Lo};
	//assign in = Hi;
	//assign A = x;
	//adder 
	adder ins0(sum,co,1'b0,A,Hi);
	
	//product hi 
	always@(posedge clk) begin
		if(init) begin 
					Hi<=24'd0;
					//Lo<=y;
				end
		else if(load) Hi <= sum;
		//else if(shift) {Hi,Lo} <= {carry,Hi,Lo[23:1]};
	end
	//Lo
	always@(posedge clk) begin
		if(init) Lo <= y;
	end
	//shifter
	always@(posedge clk) begin
		if(shift) {Hi,Lo} <= {carry,Hi,Lo[23:1]};
	end
	
	//A reg
	always@(posedge clk) begin
		if(init) A <= x;
	end
	
	//carry register
	always@(posedge clk) begin
		if(!clear) carry <= 0;
		else if(load) carry <= co;
	end
	
	//counter
	always@(posedge clk) begin
		if(init) count <= 4'd23;
		else if(shift) count <= count-1'b1; 
	end
endmodule