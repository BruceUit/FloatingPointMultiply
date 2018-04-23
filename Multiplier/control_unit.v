module control_unit(
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
	parameter IDLE = 2'b00;
	parameter ADD_A = 2'b01;
	parameter SHIFT_P = 2'b11;
	
	reg [1:0] state,next_state;
	
	assign out_en =(zero)?1'b1:1'b0;
	
	//combin logic
	always @(start or lsb or zero or state) begin
	next_state = 0;
		case(state)
		IDLE: begin
				if(start == 1'b1) begin
				next_state <= ADD_A;
				init <= 1'b1;
				load <= 1'b0;
				clear <= 1'b0;
				shift <= 1'b0;
				//out_en <= 1'b0;
				end
			else begin 
				next_state <= IDLE;
				init <= 1'b0;
				load <= 1'b0;
				clear <= 1'b1;
				shift <= 1'b0;
				//out_en <= 1'b0;
				end
			end
		ADD_A:begin
				if(lsb) begin
				init <= 1'b0;
				load <= 1'b1;
				clear <= 1'b1;
				shift <= 1'b0;
				next_state <= SHIFT_P;
				//out_en <= 1'b0;
				end else begin
				init <= 1'b0;
				load <= 1'b0;
				clear <= 1'b0;
				shift <= 1'b0;
				next_state <= SHIFT_P;
				//out_en <= 1'b0;
				end
			end
		SHIFT_P: begin
					init <= 1'b0;
					load <= 1'b0;
					clear <= 1'b1;
					shift <= 1'b1;
					if(zero) begin 
							next_state <= IDLE;
							//out_en <= 1'b1;
							end
					else begin 
							next_state <= ADD_A;
							//out_en <= 1'b0;
					end
				end
		endcase
	end
	
	//sequence
	always @(posedge clk or negedge reset) begin
		if(!reset) state <= IDLE;
		else state <= next_state;
	end

endmodule	