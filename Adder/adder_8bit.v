///////////////////////////////////////////////
//	Author: 		Huynh Vinh Phu
//	Student ID: 	15520622
//	Module:			adder_32bit
////////////////////////////////////////////
module adder #(
		parameter DATA_WIDTH = 8
		)
		(s,co,ci,a,b);
	input [DATA_WIDTH-1:0] a,b;
	input ci;
	output [DATA_WIDTH-1:0] s;
	output co;
	
	//wire [DATA_WIDTH-1:0] cin;
	wire [DATA_WIDTH-1:0] cout;
	//assign ci = cin[0];
	//assign co = cout[DATA_WIDTH-1];	
	
	genvar i;
	generate
		for(i = 0; i < DATA_WIDTH; i = i+1)
			begin :gen_loop
				//addbit ins(s[i],cout[i],cin[i],a[i],b[i]);
				//if(i>0) assign cin[i] = cout[i-1];
				if(i == 0) addbit ins(s[i],cout[i],ci,a[i],b[i]);
				else if (i != DATA_WIDTH -1) addbit ins(s[i],cout[i],cout[i-1],a[i],b[i]);
				else addbit ins(s[i],co,cout[i-1],a[i],b[i]);
			end
	endgenerate

endmodule
