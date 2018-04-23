module control_unit_new(
		input clk,
		input start,
		input reset,
		input lsb,
		input zero,
		output reg init,
		output reg load,
		output reg clear,
		output reg shift,
		output out_en
);
	parameter [2:0] IDLE = 3'b000;
	parameter [2:0] S0 = 3'b001; //load
	parameter [2:0] S1 = 3'b011; 
	parameter [2:0] S2 = 3'b010; //add + A
	parameter [2:0] S3 = 3'b110;  // carry = 0
	parameter [2:0] S4 = 3'b111;// shift
	
	reg [3:0] state, next_state;
	//combinational logic
	always@(start or lsb or zero) begin
		next_state = 0;
		case(state)
			IDLE: if(start) next_state <= IDLE;
					else next_state <= S0;
			S0: next_state <= S1;
			S1: if(lsb) next_state <= S2;
				else next_state <= S3;
			S2: next_state <= S4;
			S3: if(zero) next_state <= IDLE;
				else next_state <= S1;
		endcase
	end

endmodule