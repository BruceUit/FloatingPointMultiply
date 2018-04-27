module CLA_4bits(s,co,x,y,ci);
	input [3:0] x;
	input [3:0] y;
	input ci;
	output co;
	output [3:0] s;
	
	wire [3:0] p,g;
	//wire [3:0] temp;
	wire c1,c2,c3;
	//stage0
	and and_0(g[0],x[0],y[0]);
	or or_0(p[0],x[0],y[0]);
	xor xor_0(a,x[0],y[0]);
	xor xor_1(s[0],a,ci);
	//stage1
	and and_4(v,p[0],ci);
	or or_4(c1,g[0],v);//tinh c1
	xor xor_2(b,x[1],y[1]);
	xor xor_3(s[1],b,c1);//tinh s1
	and and_1(g[1],x[1],y[1]);
	or or_1(p[1],x[1],y[1]);	
	//stage2
	and and_5(u,p[1],c1);
	or or_5(c2,g[1],u);//tinh c2
	xor xor_4(c,x[2],y[2]);
	xor xor_5(s[2],c,c2);//tinh s2
	and and_2(g[2],x[2],y[2]);
	or or_2(p[2],x[2],y[2]);
	//stage3
	and and_6(z,p[2],c2);
	or or_6(c3,g[2],z);//tinh c3
	xor xor_6(d,x[3],y[3]);
	xor xor_7(s[3],d,c3);
	and and_3(g[3],x[3],y[3]);
	or or_3(p[3],x[3],y[3]);
	
	//tinh cout
	and and_7(t,p[3],c3);
	or or_7(co,g[3],t);

	
	
endmodule