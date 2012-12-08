module GLCD_driver(clk, lcd_e, lcd_rs, lcd_rw, reset, cs1, cs2, lcd_data);

	input clk;
	
	output reg lcd_e, lcd_rs, lcd_rw;
	output reg cs1, cs2, reset;
	output reg [7:0]lcd_data;
	
	//parameter k=18;
	reg [21:0]divider;
	reg [8:0] count;
	reg already_on=0;
	
	integer i=0;
	
	wire sclk;
	
	always @ (posedge clk)
	begin
	
		divider <= divider + 1;
	
	end
	
	assign sclk = divider[8];
	
	always@(posedge sclk)
	begin
		count <= count + 1;
		cs1 <= 1;
		cs2 <= 1;
		reset <= 1;
		
		if(count <= 9)
			begin lcd_rs <= 0; lcd_rw <= 0; lcd_e <= 0; lcd_data <= 8'b00000000; end
		else if(count == 10)
			begin lcd_rs <= 0; lcd_rw <= 0; lcd_data <= 8'b00111111; lcd_e <= 1; end
		else if(count == 11)
			lcd_e <= 0;
		else if(count == 12)
			begin lcd_rs <= 0; lcd_rw <= 0; lcd_data <= 8'b10111100; lcd_e <= 1; end
		else if(count == 13)
			lcd_e <= 0;
		else if(count == 14)
			begin lcd_rs <= 0; lcd_rw <= 0; lcd_data <= 8'b01000000; lcd_e <= 1; end
		else if(count == 15)
			lcd_e <= 0;
		else
			begin
			
				if(!already_on)
					begin
					if(i < 64)
					begin
						if(i%2==0)
							begin lcd_rs <= 1; lcd_rw <= 0; lcd_data <= 8'b10101010; lcd_e <= 1; i=i+1; already_on <= 1; end
						else
							begin lcd_rs <= 1; lcd_rw <= 0; lcd_data <= 8'b01010101; lcd_e <= 1; i=i+1; already_on <= 1; end
					end	
					end
				else
					begin
					already_on <= 0;
					lcd_e <= 0;
					end
					
					
			
			end
	
				
	end



endmodule