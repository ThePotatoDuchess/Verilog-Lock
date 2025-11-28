//MODULE 1
module checker(password, rst, guess, done, correct);

	input [4:0] password;
	input [4:0] guess;
	input rst;
	input done;
	output reg correct; 
	
	
	always @(rst,done)
		begin
			if (rst==1)
			begin
				correct = 0;
			end
			else if ((password == guess)&(done))
				begin
					correct = 1;
				end
			else if(done)
				begin
					correct = 0;
				end

		end 

		
endmodule 

