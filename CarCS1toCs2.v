module DisplayUnit(clk, lcd_e, lcd_rs, lcd_rw, reset, cs1, cs2, lcd_data);

	input clk;
	
	output reg lcd_e, lcd_rs, lcd_rw;
	output reg cs1, cs2, reset;
	output reg [7:0]lcd_data;
	
	//parameter k=18;
	reg [21:0]divider;
	reg [8:0] count;
	reg already_on=0;
	
	integer i=0;
	integer cs=1;
	integer yvalue=0;
	
	wire sclk;
	
	always @ (posedge clk)
	begin
	
		divider <= divider + 1;
	
	end
	
	assign sclk = divider[14];
	
	always@(posedge sclk)
	begin
		count <= count + 1;
		cs1 <= 1;
		cs2 <= 0;
		reset <= 1;
		
		if(count <= 9)
			begin lcd_rs <= 0; lcd_rw <= 0; lcd_e <= 0; lcd_data <= 8'b00000000; end
		else if(count == 10)//Intialising Display
			begin lcd_rs <= 0; lcd_rw <= 0; lcd_data <= 8'b00111111; lcd_e <= 1; end
		else if(count == 11)
			lcd_e <= 0;
		else if(count == 12)
			begin lcd_rs <= 0; lcd_rw <= 0; lcd_data <= 8'b10111000; lcd_e <= 1; end //Setting initial X address
		else if(count == 13)
			lcd_e <= 0;
		else if(count == 14)
			begin lcd_rs <= 0; lcd_rw <= 0; lcd_data <= 8'b01000000; lcd_e <= 1; end //Setting initial Y address
		else if(count == 15)
			lcd_e <= 0;
		else
			begin
			
				if(!already_on)
					begin
			
					
					if(yvalue == 56 && cs == 1)
					begin lcd_rs <= 0; lcd_rw <= 0; lcd_data <= 8'b01000000; lcd_e <= 1; i=0; cs = 2; already_on <= 1; cs1 <= 0; cs2 <= 1; yvalue=0;  end
					
					if(cs == 1 && yvalue!=56)
/*			Car Drawing function when in CS1 side		*/					
					begin
						if(i==0) begin lcd_rs <= 1; lcd_rw <= 0; lcd_data <= 8'b00000000; lcd_e <= 1; i=i+1; already_on <= 1; end
						if(i>0 && i<9) begin lcd_rs <= 1; lcd_rw <= 0; lcd_data <= 8'b11111111; lcd_e <= 1; i=i+1; already_on <= 1; end
						if(i!=65) begin lcd_e <= 1; i=i+1; already_on <= 1; end
						if(i==65) begin lcd_e <= 1; i=0; already_on <= 1; yvalue=yvalue+1; end						
					end
					
					
					
					if(cs == 2 && yvalue!=56)
					begin 
						if(i==0) begin lcd_rs <= 1; lcd_rw <= 0; lcd_data <= 8'b11111111; lcd_e <= 1; i=i+1; already_on <= 1; end
						if(i==1) begin lcd_rs <= 0; lcd_rw <= 0; lcd_data <= 8'b01111000; lcd_e <= 1; i=i+1; already_on <= 1; cs1 <= 1; cs2 <= 0; end//Switch to CS1 to remove few bits dere and come back
						if(i==2) begin lcd_rs <= 1; lcd_rw <= 0; lcd_data <= 8'b00000000; lcd_e <= 1; i=i+1; already_on <= 1; end
						if(i==3) begin lcd_rs <= 0; lcd_rw <= 0; lcd_data <= 8'b01000001; lcd_e <= 1; i=i+1; already_on <= 1; cs1 <= 0; cs2 <= 1; end
						if(i==4) begin lcd_rs <= 1; lcd_rw <= 0; lcd_data <= 8'b11111111; lcd_e <= 1; i=i+1; already_on <= 1; end
						if(i==5) begin lcd_rs <= 0; lcd_rw <= 0; lcd_data <= 8'b01111001; lcd_e <= 1; i=i+1; already_on <= 1; cs1 <= 1; cs2 <= 0; end
						if(i==6) begin lcd_rs <= 1; lcd_rw <= 0; lcd_data <= 8'b00000000; lcd_e <= 1; i=i+1; already_on <= 1; end//I know we can optimize no of lines here :P but I'm looking for visbility of code!
						if(i==7) begin lcd_rs <= 0; lcd_rw <= 0; lcd_data <= 8'b01000010; lcd_e <= 1; i=i+1; already_on <= 1; cs1 <= 0; cs2 <= 1; end
						if(i==8) begin lcd_rs <= 1; lcd_rw <= 0; lcd_data <= 8'b11111111; lcd_e <= 1; i=i+1; already_on <= 1; end
						if(i==9) begin lcd_rs <= 0; lcd_rw <= 0; lcd_data <= 8'b01111010; lcd_e <= 1; i=i+1; already_on <= 1; cs1 <= 1; cs2 <= 0; end
						if(i==10) begin lcd_rs <= 1; lcd_rw <= 0; lcd_data <= 8'b00000000; lcd_e <= 1; i=i+1; already_on <= 1; end
						if(i==11) begin lcd_rs <= 0; lcd_rw <= 0; lcd_data <= 8'b01000011; lcd_e <= 1; i=i+1; already_on <= 1; cs1 <= 0; cs2 <= 1; end
						if(i==12) begin lcd_rs <= 1; lcd_rw <= 0; lcd_data <= 8'b11111111; lcd_e <= 1; i=i+1; already_on <= 1; end
						if(i==13) begin lcd_rs <= 0; lcd_rw <= 0; lcd_data <= 8'b01111011; lcd_e <= 1; i=i+1; already_on <= 1; cs1 <= 1; cs2 <= 0; end
						if(i==14) begin lcd_rs <= 1; lcd_rw <= 0; lcd_data <= 8'b00000000; lcd_e <= 1; i=i+1; already_on <= 1; end
						if(i==15) begin lcd_rs <= 0; lcd_rw <= 0; lcd_data <= 8'b01000100; lcd_e <= 1; i=i+1; already_on <= 1; cs1 <= 0; cs2 <= 1; end
						if(i==16) begin lcd_rs <= 1; lcd_rw <= 0; lcd_data <= 8'b11111111; lcd_e <= 1; i=i+1; already_on <= 1; end
						if(i==17) begin lcd_rs <= 0; lcd_rw <= 0; lcd_data <= 8'b01111100; lcd_e <= 1; i=i+1; already_on <= 1; cs1 <= 1; cs2 <= 0; end
						if(i==18) begin lcd_rs <= 1; lcd_rw <= 0; lcd_data <= 8'b00000000; lcd_e <= 1; i=i+1; already_on <= 1; end
						if(i==11) begin lcd_rs <= 0; lcd_rw <= 0; lcd_data <= 8'b01000101; lcd_e <= 1; i=i+1; already_on <= 1; cs1 <= 0; cs2 <= 1; end
						if(i==12) begin lcd_rs <= 1; lcd_rw <= 0; lcd_data <= 8'b11111111; lcd_e <= 1; i=i+1; already_on <= 1; end
						if(i==13) begin lcd_rs <= 0; lcd_rw <= 0; lcd_data <= 8'b01111101; lcd_e <= 1; i=i+1; already_on <= 1; cs1 <= 1; cs2 <= 0; end
						if(i==14) begin lcd_rs <= 1; lcd_rw <= 0; lcd_data <= 8'b00000000; lcd_e <= 1; i=i+1; already_on <= 1; end
						if(i==11) begin lcd_rs <= 0; lcd_rw <= 0; lcd_data <= 8'b01000110; lcd_e <= 1; i=i+1; already_on <= 1; cs1 <= 0; cs2 <= 1; end
						if(i==12) begin lcd_rs <= 1; lcd_rw <= 0; lcd_data <= 8'b11111111; lcd_e <= 1; i=i+1; already_on <= 1; end
						if(i==13) begin lcd_rs <= 0; lcd_rw <= 0; lcd_data <= 8'b01111110; lcd_e <= 1; i=i+1; already_on <= 1; cs1 <= 1; cs2 <= 0; end
						if(i==14) begin lcd_rs <= 1; lcd_rw <= 0; lcd_data <= 8'b00000000; lcd_e <= 1; i=i+1; already_on <= 1; end
						if(i==11) begin lcd_rs <= 0; lcd_rw <= 0; lcd_data <= 8'b01000111; lcd_e <= 1; i=i+1; already_on <= 1; cs1 <= 0; cs2 <= 1; end
						if(i==12) begin lcd_rs <= 1; lcd_rw <= 0; lcd_data <= 8'b11111111; lcd_e <= 1; i=i+1; already_on <= 1; end
						if(i==13) begin lcd_rs <= 0; lcd_rw <= 0; lcd_data <= 8'b01111111; lcd_e <= 1; i=i+1; already_on <= 1; cs1 <= 1; cs2 <= 0; end
						if(i==14) begin lcd_rs <= 1; lcd_rw <= 0; lcd_data <= 8'b00000000; lcd_e <= 1; i=i+1; already_on <= 1; end
						if(i==15) begin lcd_rs <= 0; lcd_rw <= 0; lcd_data <= 8'b01111111; lcd_e <= 1; i=i+1; already_on <= 1; cs1 <= 0; cs2 <= 1; end
						
						/* 		Now we loop to keep the vehicle moving in CS2 as we now successfully crossed the boundry!!		*/
						
						if(i==16) begin lcd_rs <= 1; lcd_rw <= 0; lcd_data <= 8'b00000000; lcd_e <= 1; i=i+1; already_on <= 1; yvalue=0; end
						if(i>16 && i<25) begin lcd_rs <= 1; lcd_rw <= 0; lcd_data <= 8'b11111111; lcd_e <= 1; i=i+1; already_on <= 1; end
						if(i!=81) begin lcd_e <= 1; i=i+1; already_on <= 1; end
						if(i==81) begin lcd_e <= 1; i=16; already_on <= 1; yvalue=yvalue+1; end
				
					end
					
					else
					begin break; end
				
					
				end
				

/*			Drawing execution 			*/
				else
				begin
					already_on <= 0;
					lcd_e <= 0;
				end
					
					
			
			end
	
				
	end

endmodule