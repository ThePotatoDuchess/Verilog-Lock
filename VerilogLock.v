module VerilogLock(switches,buttons,clk,seg0,seg1,seg2,seg3,seg4,seg5,led);
input [8:0] switches;
input [3:0] buttons;
input clk;
output reg [0:6] seg0;
output reg [0:6] seg1;
output reg [0:6] seg2;
output reg [0:6] seg3;
output reg [0:6] seg4;
output reg [0:6] seg5;
output [0:9] led;
reg [0:4] pw0;
reg [0:4] pw1;
reg [0:4] pw2;
reg [0:4] pw3;
reg [0:4] pw4;
reg [0:4] pw5;

reg [0:4] gu0;
reg [0:4] gu1;
reg [0:4] gu2;
reg [0:4] gu3;
reg [0:4] gu4;
reg [0:4] gu5;

wire correct, correct0, correct1, correct2, correct3, correct4, correct5,saveL;
wire [0:6] pseg0;
wire [0:6] pseg1;
wire [0:6] pseg2;
wire [0:6] pseg3;
wire [0:6] pseg4;
wire [0:6] pseg5;

wire [0:6] lseg0;
wire [0:6] lseg1;
wire [0:6] lseg2;
wire [0:6] lseg3;
wire [0:6] lseg4;
wire [0:6] lseg5;

wire posr;
wire posleft;
wire pos3;
wire [3:0] num;
wire [2:0] posL;
wire [3:0] numL;
wire [6:0] segL;
wire [6:0] hexten;
wire [6:0] hexone;
wire [1:0] blink;
reg [3:0] n2;
reg [1:0] mode;
reg [1:0] attempts;
reg rst;

//initiates to set pw and all 0's
initial
begin
  mode = 2'b00;
  seg0 = 7'b1111111;
  seg1 = 7'b1111111;
  seg2 = 7'b1111111;
  seg3 = 7'b1111111;
  seg4 = 7'b1111111;
  seg5 = 7'b1111111;
  attempts = 0;
  rst = 1;
end


numin in1 (switches,num);


NumberInput lock (clk,posr,posleft,~buttons[2],posL,saveL,blink);

checker c0 (pw0,rst,gu0,~buttons[3],correct0);
checker c1 (pw1,rst,gu1,~buttons[3],correct1);
checker c2 (pw2,rst,gu2,~buttons[3],correct2);
checker c3 (pw3,rst,gu3,~buttons[3],correct3);
checker c4 (pw4,rst,gu4,~buttons[3],correct4);
checker c5 (pw5,rst,gu5,~buttons[3],correct5);

assign correct = correct0&correct1&correct2&correct3&correct4&correct5;

lockOut l1 (clk,rst,doneO,hexten,hexone);

hexdisplay disp1 (n2,segL);

hexdisplay pow0 (pw0,pseg0);
hexdisplay pow1 (pw1,pseg1);
hexdisplay pow2 (pw2,pseg2);
hexdisplay pow3 (pw3,pseg3);
hexdisplay pow4 (pw4,pseg4);
hexdisplay pow5 (pw5,pseg5);

hexdisplay gue0 (gu0,lseg0);
hexdisplay gue1 (gu1,lseg1);
hexdisplay gue2 (gu2,lseg2);
hexdisplay gue3 (gu3,lseg3);
hexdisplay gue4 (gu4,lseg4);
hexdisplay gue5 (gu5,lseg5);

edgedect br (clk,~buttons[1],posr);
edgedect bl (clk,~buttons[0],posleft);
edgedect b3 (clk,~buttons[3],pos3);


always @(posedge clk)
begin
	if (blink==0)
	begin
	n2 = 4'b1111;
	end
	else
	begin
	n2 = num;
	end

	if(mode == 2'b00) //setting password
	begin
		if (rst == 1) // resets when changing modules
		begin
			seg0 = 7'b0000001;
  			seg1 = 7'b0000001;
  			seg2 = 7'b0000001;
			seg3 = 7'b0000001;
			seg4 = 7'b0000001;
			seg5 = 7'b0000001;
			pw0 = 0;
			pw1 = 0;
			pw2 = 0;
			pw3 = 0;
			pw4 = 0;
			pw5 = 0;
			rst = 0;
		end
		//copy whatever seg to the display
		if (saveL)
		begin
			case (posL)
			3'b000 : pw0 = num; 
			3'b001 : pw1 = num; 
			3'b010 : pw2 = num; 
			3'b011 : pw3 = num; 
			3'b100 : pw4 = num; 
			3'b101 : pw5 = num; 

			endcase
		end
			if (posleft|posr) //set all to correct when switching pos
			begin
				seg0 = pseg0;
				seg1 = pseg1;
				seg2 = pseg2;
				seg3 = pseg3;
				seg4 = pseg4;
				seg5 = pseg5;
			end
			else
			begin
			case (posL)
			3'b000 : seg0 = segL;
			3'b001 : seg1 = segL;
			3'b010 : seg2 = segL;
			3'b011 : seg3 = segL;
			3'b100 : seg4 = segL;
			3'b101 : seg5 = segL;

			endcase
			end
		//check if done, if so set pw and move to next step
		if (pos3)
		begin
		mode = 2'b01;
		rst = 1;
		attempts = 2'b00;
		end


	end
	else if(mode == 2'b01) //enter pw
	begin
		if (rst == 1) // resets when changing modules
		begin
			seg0 = 7'b0000001;
  			seg1 = 7'b0000001;
  			seg2 = 7'b0000001;
			seg3 = 7'b0000001;
			seg4 = 7'b0000001;
			seg5 = 7'b0000001;
			gu0 = 0;
			gu1 = 0;
			gu2 = 0;
			gu3 = 0;
			gu4 = 0;
			gu5 = 0;
			rst = 0;
		end
		//copy whatever seg to the display
	if (saveL)
		begin
			case (posL)
			3'b000 : gu0 = num; 
			3'b001 : gu1 = num; 
			3'b010 : gu2 = num; 
			3'b011 : gu3 = num; 
			3'b100 : gu4 = num; 
			3'b101 : gu5 = num; 

			endcase
		end
			if (posleft|posr) //set all to correct when switching pos
			begin
				seg0 = lseg0;
				seg1 = lseg1;
				seg2 = lseg2;
				seg3 = lseg3;
				seg4 = lseg4;
				seg5 = lseg5;
			end
			else
			begin
			case (posL)
			3'b000 : seg0 = segL;
			3'b001 : seg1 = segL;
			3'b010 : seg2 = segL;
			3'b011 : seg3 = segL;
			3'b100 : seg4 = segL;
			3'b101 : seg5 = segL;

			endcase
			end
		//check if done
		//check for done

		if (pos3)
		begin
			if (correct == 1)
			begin
				mode = 2'b11;
				rst = 1;

			end 
			else
				if(attempts<2) //checks amount of fails
				begin
					attempts = attempts + 1;
					gu0 = 0;
					gu1 = 0;
					gu2 = 0;
					gu3 = 0;
					gu4 = 0;
				end
				else // if 3 fails changes to lockout
				begin
					mode = 2'b10;
					rst = 1;
				end
			begin

			end
		end

	end
	else if(mode == 2'b10) // lockout
	begin
		if (rst == 1) // resets when changing modules
		begin
			seg0 = 7'b1100010; //o 
  			seg1 = 7'b1100010; //o
  			seg2 = 7'b1100000; //b
			seg3 = 7'b1111111;
			seg4 = 7'b1111111;
			seg5 = 7'b1111111;
			rst = 0;
		end
		//copy whatever seg to the display
		seg4 = hexten;
		seg5 = hexone;

		if(doneO == 1) //heads back to locked
		begin
			mode = 2'b01;
			rst = 1;
			attempts = 2'b00;
		end

	end
	else if(mode == 2'b11)
	begin
		if (rst == 1) // resets when changing modules
		begin
			seg5 = 7'b1000100;
  			seg4 = 7'b1111001;
  			seg3 = 7'b0011000;
			seg2 = 7'b0011000;
			seg1 = 7'b0110000;
			seg0 = 7'b0110000;
			rst = 0;
		end
		if (posleft)// change pw
		begin
			mode = 2'b00;
			rst = 1;
		end
		else if (pos3)//same pw
		begin
			mode = 2'b01;
			rst = 1;
			attempts = 2'b00;
		end
	end
	
end

assign led[0] = ~mode[0]&~mode[1];
assign led[2] = ~mode[0]&mode[1]; 
assign led[1] = mode[0]&~mode[1]; 
assign led[3] = mode[0]&mode[1]; 

assign led[7] = ~mode[1]&mode[0];
assign led[8] = ~mode[1]&mode[0]& ~attempts[1];
assign led[9] = ~mode[1]&mode[0]& ~attempts[0]&~attempts[1];
endmodule


module edgedect(clk,in,pos);
input in,clk;
output pos;
reg last;

initial
begin
last = in;
end

always @(posedge clk)
begin
	last <= in;
end

assign pos = in & ~last;

endmodule
// 00 = enter pw
// 01 = locked
// 10 = lockout
// 11 = unlocked

