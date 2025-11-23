module VerilogLock(switches,buttons,clk,seg0,seg1,seg2,seg3,seg4,seg5);
input [8:0] switches;
input [3:0] buttons;
input clk;
output [0:6] seg0,seg1,seg2,seg3,seg4,seg5;
reg [0:6] seg0,seg1,seg2,seg3,seg4,seg5; 
wire [3:0] num,[6:0] setseg,[6:0] lckseg,w1;
reg [1:0] mode, [1:0] attempts, [3:0] pw,rst;

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
  rst = 1;
end


enterPassword lock (clk,num,buttons,rst,lckseg,posL,doneL,numL);

checkPassword check (clk,doneL,w1,correct);

lockout l1 (clk,rst,lkoseg,posO,doneO)

always @(clk)
begin
	if (rst == 1) // resets when changing modules
		begin
			seg0 = 7'b1111111;
  			seg1 = 7'b1111111;
  			seg2 = 7'b1111111;
			seg3 = 7'b1111111;
			seg4 = 7'b1111111;
			seg5 = 7'b1111111;
			rst = 0;
		end

	if(mode == 2'b00) //setting password
	begin
		//copy whatever seg to the display
		case (posL)
		3'b000 : seg0 = setseg;
		3'b001 : seg1 = setseg;
		3'b010 : seg2 = setseg;
		3'b011 : seg3 = setseg;
		3'b100 : seg4 = setseg;
		3'b101 : seg5 = setseg;

		endcase

		//check if done, if so set pw and move to next step

		if (doneL == 1)
		begin
		pw = numL;
		mode = 2'b01;
		rst = 1;
		attempts = 2'b00;
		end


	end
	else if(mode == 2'b01) //enter pw
	begin

		//copy whatever seg to the display
		case (posL)
		3'b000 : seg0 = lckseg;
		3'b001 : seg1 = lckseg;
		3'b010 : seg2 = lckseg;
		3'b011 : seg3 = lckseg;
		3'b100 : seg4 = lckseg;
		3'b101 : seg5 = lckseg;

		endcase

		//check for done

		if (doneL == 1)
		begin
			if (correct == 1)
			begin
				mode = 2'b11;
				rst = 1;

			end 
			else
				if(attempts<3) //checks amount of fails
				begin
					attempts = attempts + 1;
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
		//copy whatever seg to the display
		case (posO)
		3'b000 : seg0 = lkoseg;
		3'b001 : seg1 = lkoseg;
		3'b010 : seg2 = lkoseg;
		3'b011 : seg3 = lkoseg;
		3'b100 : seg4 = lkoseg;
		3'b101 : seg5 = lkoseg;

		endcase

		if(doneO == 1) //heads back to locked
		begin
			mode = 2'b01;
			rst = 1;
			attempts = 2'b00;
		end

	end
	else if(mode == 2'b11)
	begin
		if (button0 = 1)// change pw
		begin
			mode = 2'b00;
			rst = 1;
		end
		else if (button1 = 1)//same pw
		begin
			mode = 2'b01;
			rst = 1
			attempts = 2'b00;
		end
	end

end



endmodule

// 00 = enter pw
// 01 = locked
// 10 = lockout
// 11 = unlocked


module enterPassword(clk,num,buttons,rst,seg,pos,done,numout); //example of possible layout, does nothing
input clk,[3:0] num, [3:0] buttons, rst;
output seg,pos,done,numout;

endmodule

module checkPassword(clk,done,w1,good); //example of possible layout, does nothing
input clk,[3:0] num, [3:0] buttons, rst;
output seg;

endmodule

module lockout(clk,rst,seg,pos,done); //example of possible layout, does nothing
input clk,rst;
output seg,pos,done;

endmodule