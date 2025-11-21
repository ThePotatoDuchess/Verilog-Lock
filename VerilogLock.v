module VerilogLock(switches,buttons,seg0,seg1,seg2,seg3,seg4,seg5);
input [8:0] switches;
input [3:0] buttons;
output [0:6] seg0,seg1,seg2,seg3,seg4,seg5;
reg [0:6] seg0,seg1,seg2,seg3,seg4,seg5; 
wire [3:0] num;
reg [1:0] mode;


		numin in1 (switches,num);


if counter == 0;
	assign mode =  2'b10;


endmodule




