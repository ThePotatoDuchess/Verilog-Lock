module NumberInput ( input clk, input posr, input posl, input enter_button, output reg [2:0] current_position, output save,output reg [1:0] blink);

wire slow;

initial
begin
current_position = 0;
blink = 0;
end

medClock s1 (clk,slow);



always @ (posedge clk) // values uodate on the positive edge of the clock
	begin
		
		if (posr) begin // checks if the right button was pressed
			if (current_position == 5) begin // if the current position of the input is 5, then itll go to 0 once we press the right
				current_position = 0;
				end 
				else begin
				current_position = current_position + 1; // whatever the current position is , add 1 to increment the position
				end
		end
				
		if (posl) begin //checks if left button was pressed
			if (current_position == 0) begin // if the current position that we are using to input is 0 , then itll go to 5 once w epress the left button
				current_position = 5;
				end 
				else begin
				current_position = current_position - 1;// whatever the current position is, subtract 1 to decrement
				end
			end
		
		
	end
	
always @(posedge slow)
	begin
	if (blink == 3)
		begin
			blink = 0;
		end
		else
		begin
		blink = blink+1;
		end
	end
	
assign save = enter_button;
endmodule
		
module medClock(clk, clk_1Hz);
	
	input clk;												
	output clk_1Hz;										

	reg clk_1Hz = 1'b0;									
	reg [27:0] counter = 0;			

	always@(posedge clk)begin
	
			counter <= counter + 1;	
			
			if ( counter == 6250000)begin
				counter <= 0;	
				clk_1Hz <= ~clk_1Hz;
			end
		end

	endmodule	
