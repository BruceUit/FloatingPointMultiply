module FP_multiplier(clk,start,resetn,FP1,FP2,result,ovf);
//IO ports
	input 			clk;
	input 			start;
	input			resetn;
	//input			msb;
	//input			lsb;
	input [31:0] 	FP1;
	input [31:0] 	FP2;
	output	[31:0]	result;
	output 			ovf;
	//inner signals
	reg out_en,init,load,clear,shift,bit47;
	wire done_counter;
	wire done_mul;
	wire msb,lsb;
	reg [1:0] state,next_state;
	
	parameter IDLE = 2'b00;
	parameter MUL_1 = 2'b01;
	parameter MUL_2 = 2'b11;
	parameter DONE = 2'b10;
	
	assign done_mul = done_counter;
	
	always@(state or start or lsb or msb or done_counter) begin
		next_state = 0;
		case(state)
			IDLE: begin
				if(start) begin
					next_state <= MUL_1;
					init <= 1'b1;
					load <= 1'b0;
					clear <= 1'b0;
					shift <= 1'b0;
					bit47 <= 1'b0;
					out_en <= 1'b0;
					//done_mul <= 1'b0;
				end
				else begin
					next_state <= IDLE;
					init <= 1'b0;
					load <= 1'b0;
					clear <= 1'b1;
					shift <= 1'b0;
					bit47 <= 1'b0;
					out_en <= 1'b0;
					//done_mul <= 1'b0;
				end
			end
			MUL_1: begin
				if(lsb) begin
					next_state <= MUL_2;
					init <= 1'b0;
					load <= 1'b1;
					clear <= 1'b1;
					shift <= 1'b0;
					bit47 <= 1'b0;
					out_en <= 1'b0;
					//done_mul <= 1'b0;
				end
				else begin
					next_state <= MUL_2;
					init <= 1'b0;
					load <= 1'b0;
					clear <= 1'b0;
					shift <= 1'b0;
					bit47 <= 1'b0;
					out_en <= 1'b0;
					//done_mul <= 1'b0;
				end
			end
			MUL_2: begin
					init <= 1'b0;
					load <= 1'b0;
					clear <= 1'b1;
					shift <= 1'b1;
					bit47 <= 1'b0;
					out_en <= 1'b0;
					if(done_counter) begin 
						next_state <= DONE;
						//done_mul <= 1'b1;
					end
					else begin 
						next_state <= MUL_1;
						//done_mul <= 1'b0;
					end
			end
			DONE: begin
				if(msb) begin
					init <= 1'b0;
					load <= 1'b0;
					clear <= 1'b1;
					shift <= 1'b0;
					bit47 <= 1'b1;
					out_en <= 1'b1;
				end
				else begin
					init <= 1'b0;
					load <= 1'b0;
					clear <= 1'b1;
					shift <= 1'b0;
					bit47 <= 1'b0;
					out_en <= 1'b1;
				end
			end
		endcase
	end
	
	//sequence
	always @(posedge clk or negedge resetn) begin
		if(!resetn) state <= IDLE;
		else state <= next_state;
	end
	//instantiate datapath
	datapath datapath_inst(clk,out_en,init,load,clear,shift,done_mul,bit47,FP1,FP2,result,ovf,done_counter,lsb,msb);
	
endmodule
