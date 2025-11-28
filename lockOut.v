
module lockOut (clk, reset, done,hexOne,hexTen);
		
	input clk;
	input reset;
	
	wire clk_1Hz;
	output [6:0] hexOne;	
	output [6:0] hexTen;
	output reg done;
	reg [5:0] countDown;
	
	slowClock clock_generator(clk, clk_1Hz);
	
			
	always@(posedge clk_1Hz,posedge reset) begin     
		if (reset) begin
			countDown <= 60;	// start from 60
			done <= 0;
		end
		
		else if ( countDown == 1 ) begin
			countDown <= 0;
			done <=1;
		end
		
		else if(countDown > 0) begin
			countDown <= countDown -1 ; //countdown
		end
		
	end
	


	
	hexdisplay displayTensLockOut(countDown/10,hexTen);
	hexdisplay displayOnesLockOut(countDown%10,hexOne);
endmodule
	
	
module slowClock(clk, clk_1Hz);
	
	input clk;												
	output clk_1Hz;										

	reg clk_1Hz = 1'b0;									
	reg [27:0] counter = 0;			

	always@(posedge clk)begin
	
			counter <= counter + 1;	
			
			if ( counter == 25_000_000)begin
				counter <= 0;	
				clk_1Hz <= ~clk_1Hz;
			end
		end

	endmodule


