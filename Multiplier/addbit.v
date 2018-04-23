///////////////////////////////////////////////
//	Author: 		Huynh Vinh Phu
//	Student ID: 	15520622
//	Module:			addbit
////////////////////////////////////////////
module addbit(s,co,ci,a,b);
	output s,co;
	input ci,a,b;
	xor xor_1(x,a,b); 
	xor xor_2(s,x,ci);
	and and_1(y,a,b);
	and and_2(z,ci,x);
	or or_1(co,y,z);
endmodule
