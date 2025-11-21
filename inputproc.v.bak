module inputnum(in,num);
input [8:0] in;
output [3:0] num;

always @(switches)
	begin

	num[0]= in[8]|in[6]&~in[7]|in[4]&~in[7]&~in[5]|in[2]&~in[7]&~in[5]&~in[3]|in[0]&~in[7]&~in[5]&~in[3]&~in[1];
	
	num[1] = ~(in[7]|~in[8])&(in[6]|in[5]|((in[2]|in[1])&~in[4]&~in[3]));

	num[2] = ~(in[8]|in[7])&(in[6]|in[5]|in[4]|in[3]);

	num[3] = in[7]|in[8];

	end
endmodule


module hexdisplay(num,seg);
input [3:0] num;
output [6:0] seg;
reg [6:0] seg;

always @(num)
	begin
		case(num)
			4'b0000 : seg = 7'b0000001;
			4'b0001 : seg = 7'b1001111;
			4'b0010 : seg = 7'b0010010;
			4'b0011 : seg = 7'b0000110;
			4'b0100 : seg = 7'b1001100;
			4'b0101 : seg = 7'b0100100;
			4'b0110 : seg = 7'b0100000;
			4'b0111 : seg = 7'b0001111;
			4'b1000 : seg = 7'b0000000;
			4'b1001 : seg = 7'b0000100;
			
			4'b1010 : seg = 7'b0001000;
			4'b1011 : seg = 7'b1100000;
			4'b1100 : seg = 7'b0110001;
			4'b1101 : seg = 7'b1000010;
			4'b1110 : seg = 7'b0110000;
			4'b1111 : seg = 7'b0111000;

			
			default : seg = 7'b1111111;

		endcase
	end


endmodule