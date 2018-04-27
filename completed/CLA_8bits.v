module CLA_8bits(s,co,x,y,ci);
	input [7:0] x;
	input [7:0] y;
	input ci;
	output [7:0] s;
	output co;
	
	wire c;
	
	CLA_4bits ins0(s[3:0],c,x[3:0],y[3:0],ci);
	CLA_4bits ins1(s[7:4],co,x[7:4],y[7:4],c);

endmodule