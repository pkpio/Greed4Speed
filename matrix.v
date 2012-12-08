
module DisplayUnit(clk, lcd_e, lcd_rs, lcd_rw, reset, cs1, cs2, lcd_data, right, left);
	
	
	input clk,right, left;
	
	output reg lcd_e, lcd_rs, lcd_rw;
	output reg cs1, cs2, reset;
	output reg [7:0]lcd_data;
	
	//parameter k=18;
	reg [28:0]divider;
	reg [8:0] count;
	reg already_on=0;
	reg[7:0] mem[0:7][0:127];
	reg[7:0] temp1, temp2, temp3, temp4, temp5;
	reg temp6;
	reg[127:0] lane6 = 128'b00000000000000000000000000000000000000001111100000000000000000000000000111111000000000000000000000000000000000000000000000000000;
	
	reg left_prev ;
	integer move1=0, pos6 =0,move2 =0 , move3 = 0, move4= 0, move5 =0, move6 = 0;
	integer timer = 0 ;
	integer init1 = 0, init2 =0 ,init3 =0, init4 = 0, init5 =0, init6 = 0;
	integer col = 0;
	integer i = 0;
	integer page = 0;
	integer sheep_col = 26;
	
	wire sclk;
	
	//timer digit1(divider[14],page,temp_timer[0:3]); 
	
	//Additional Features that are almost permanent
	always@(*) begin
	//Clock Symbol -- Score lettering should come here..
	
	
	mem[0][109][4:0] = 5'b11111; 
	mem[0][110][4:0] = 5'b10001; 
	mem[0][111][4:0] = 5'b10111; 
	mem[0][112][4:0] = 5'b10101; 
	mem[0][113][4:0] = 5'b11111;
	//Colon
	mem[0][115][4:0] = 5'b01010;
	end
	
	//Score increasing block
	always@(negedge divider[28]) begin
	timer = (timer == 99)? 0 : (timer +1) ;
	//Timer digit 1
	case(timer/10)
	0:
		begin
		mem[0][120][4:0] = 5'b01110;
		mem[0][119][4:0] = 5'b10001;
		mem[0][118][4:0] = 5'b10001;
		mem[0][117][4:0] = 5'b01110;
		end
	1:
		begin
		mem[0][120][4:0] = 5'b10000;
		mem[0][119][4:0] = 5'b11111;
		mem[0][118][4:0] = 5'b10010;
		mem[0][117][4:0] = 5'b00000;
		end
	2:
		begin
		mem[0][120][4:0] = 5'b10010;
		mem[0][119][4:0] = 5'b10101;
		mem[0][118][4:0] = 5'b11001;
		mem[0][117][4:0] = 5'b10010;
		end
	3:
		begin
		mem[0][120][4:0] = 5'b01010;
		mem[0][119][4:0] = 5'b10101;
		mem[0][118][4:0] = 5'b10101;
		mem[0][117][4:0] = 5'b10001;		
		end
	4:
	begin
		mem[0][120][4:0] = 5'b11111;
		mem[0][119][4:0] = 5'b01010;
		mem[0][118][4:0] = 5'b01100;
		mem[0][117][4:0] = 5'b01000;	
	end
	5:
	begin
		mem[0][120][4:0] = 5'b01001;
		mem[0][119][4:0] = 5'b10101;
		mem[0][118][4:0] = 5'b10101;
		mem[0][117][4:0] = 5'b10111;
	end
	6:
	begin
		mem[0][120][4:0] = 5'b01000;
		mem[0][119][4:0] = 5'b10101;
		mem[0][118][4:0] = 5'b10101;
		mem[0][117][4:0] = 5'b01110;
	end
	7:
	begin
		mem[0][120][4:0] = 5'b00011;
		mem[0][119][4:0] = 5'b00101;
		mem[0][118][4:0] = 5'b01001;
		mem[0][117][4:0] = 5'b10001;
	end
	
	8:
	begin
		mem[0][120][4:0] = 5'b01010;
		mem[0][119][4:0] = 5'b10101;
		mem[0][118][4:0] = 5'b10101;
		mem[0][117][4:0] = 5'b01010;
	end
	9: begin
		mem[0][120][4:0] = 5'b01110;
		mem[0][119][4:0] = 5'b10101;
		mem[0][118][4:0] = 5'b10101;
		mem[0][117][4:0] = 5'b00010;
		end
	default : 
		begin
		mem[0][120][4:0] = 5'b01110;
		mem[0][119][4:0] = 5'b10001;
		mem[0][118][4:0] = 5'b10001;
		mem[0][117][4:0] = 5'b01110;
	end
	endcase
	
	//second digit
		case(timer%10)
	0:
		begin
		mem[0][125][4:0] = 5'b01110;
		mem[0][124][4:0] = 5'b10001;
		mem[0][123][4:0] = 5'b10001;
		mem[0][122][4:0] = 5'b01110;
		end
	1:
		begin
		mem[0][125][4:0] = 5'b10000;
		mem[0][124][4:0] = 5'b11111;
		mem[0][123][4:0] = 5'b10010;
		mem[0][122][4:0] = 5'b00000;
		end
	2:
		begin
		mem[0][125][4:0] = 5'b10010;
		mem[0][124][4:0] = 5'b10101;
		mem[0][123][4:0] = 5'b11001;
		mem[0][122][4:0] = 5'b10010;
		end
	3:
		begin
		mem[0][125][4:0] = 5'b01010;
		mem[0][124][4:0] = 5'b10101;
		mem[0][123][4:0] = 5'b10101;
		mem[0][122][4:0] = 5'b10001;		
		end
	4:
	begin
		mem[0][125][4:0] = 5'b11111;
		mem[0][124][4:0] = 5'b01010;
		mem[0][123][4:0] = 5'b01100;
		mem[0][122][4:0] = 5'b01000;	
	end
	5:
	begin
		mem[0][125][4:0] = 5'b01001;
		mem[0][124][4:0] = 5'b10101;
		mem[0][123][4:0] = 5'b10101;
		mem[0][122][4:0] = 5'b10111;
	end
	6:
	begin
		mem[0][125][4:0] = 5'b01000;
		mem[0][124][4:0] = 5'b10101;
		mem[0][123][4:0] = 5'b10101;
		mem[0][122][4:0] = 5'b01110;
	end
	7:
	begin
		mem[0][125][4:0] = 5'b00011;
		mem[0][124][4:0] = 5'b00101;
		mem[0][123][4:0] = 5'b01001;
		mem[0][122][4:0] = 5'b10001;
	end
	
	8:
	begin
		mem[0][125][4:0] = 5'b01010;
		mem[0][124][4:0] = 5'b10101;
		mem[0][123][4:0] = 5'b10101;
		mem[0][122][4:0] = 5'b01010;
	end
	9: begin
		mem[0][125][4:0] = 5'b01110;
		mem[0][124][4:0] = 5'b10101;
		mem[0][123][4:0] = 5'b10101;
		mem[0][122][4:0] = 5'b00010;
		end
	default : 
		begin
		mem[0][125][4:0] = 5'b01110;
		mem[0][124][4:0] = 5'b10001;
		mem[0][123][4:0] = 5'b10001;
		mem[0][122][4:0] = 5'b01110;
	end
	endcase
			
	end

	
	
	
	
	
	
	/*always @(negedge divider[24]) begin
		//Sheep
	if (right || left) begin
	mem[7][sheep_col][7:0] = 8'b00000000;
	mem[7][sheep_col+1][7:0] = 8'b00000000;
	mem[7][sheep_col+2][7:0] = 8'b00000000;
	mem[7][sheep_col+3][7:0] = 8'b00000000;
	
	sheep_col = (right && sheep_col != 124)? sheep_col +1 : sheep_col ; 
	sheep_col = (left && sheep_col!= 0)? sheep_col - 1 : sheep_col;
	
	mem[7][sheep_col][7:0] = 8'b00111000;
	mem[7][sheep_col+1][7:0] = 8'b01000110;
	mem[7][sheep_col+2][7:0] = 8'b01000110;
	mem[7][sheep_col+3][7:0] = 8'b00111000;
	end
	end*/
	
	//First lane
	always@(negedge divider[21]) begin
	if (init1 == 0) begin
		mem[1][0] = 8'b11111100;
		mem[1][1] = 8'b11111100;
		mem[1][2] = 8'b11111100;
		mem[1][3] = 8'b11111100;
		mem[1][4] = 8'b11111100;
		mem[1][5] = 8'b11111100;
		
		mem[1][15] = 8'b11111100;
		mem[1][16] = 8'b11111100;
		mem[1][17] = 8'b11111100;
		mem[1][18] = 8'b11111100;
		mem[1][19] = 8'b11111100;
		mem[1][20] = 8'b11111100;
		
		mem[1][50] = 8'b11111100;
		mem[1][51] = 8'b11111100;
		mem[1][52] = 8'b11111100;
		mem[1][53] = 8'b11111100;
		mem[1][54] = 8'b11111100;
		mem[1][55] = 8'b11111100;
		
		
		//mem[2][0] = 8'b11111100;
		//mem[2][1] = 8'b11111100;
		//mem[2][2] = 8'b11111100;
		//mem[2][3] = 8'b11111100;
		//mem[2][4] = 8'b11111100;
		//mem[2][5] = 8'b11111100;
		
		init1 = 1;
	end
		temp1[7:0] = mem[1][0][7:0] ;
		for ( move1 = 0; move1 < 127 ; move1 = move1+1) begin
			mem[1][move1][7:0] = mem[1][move1+1][7:0] ;
		end
		mem[1][127][7:0] = temp1[7:0];
end

//Second Lane
always@(negedge divider[21]) begin
	if (init2 == 0) begin
		mem[2][0] = 8'b11111100;
		mem[2][1] = 8'b11111100;
		mem[2][2] = 8'b11111100;
		mem[2][3] = 8'b11111100;
		mem[2][4] = 8'b11111100;
		mem[2][5] = 8'b11111100;
		
		init2 = 1;
	end
		temp2[7:0] = mem[2][127][7:0] ;
		for ( move2 = 127; move2 > 0 ; move2 = move2-1) begin
			mem[2][move2][7:0] = mem[2][move2-1][7:0] ;
		end
		mem[2][0][7:0] = temp2[7:0];
end



//Third lane
	always@(negedge divider[22]) begin
	if (init3 == 0) begin
		mem[3][0] = 8'b11111100;
		mem[3][1] = 8'b11111100;
		mem[3][2] = 8'b11111100;
		mem[3][3] = 8'b11111100;
		mem[3][4] = 8'b11111100;
		mem[3][5] = 8'b11111100;
		
		init3 = 1;
	end
		temp3[7:0] = mem[3][0][7:0] ;
		for ( move3 = 0; move3 < 127 ; move3 = move3+1) begin
			mem[3][move3][7:0] = mem[3][move3+1][7:0] ;
		end
		mem[3][127][7:0] = temp3[7:0];
end













//Fourth lane
	always@(negedge divider[22]) begin
	if (init4 == 0) begin
		mem[4][0] = 8'b11111100;
		mem[4][1] = 8'b11111100;
		mem[4][2] = 8'b11111100;
		mem[4][3] = 8'b11111100;
		mem[4][4] = 8'b11111100;
		mem[4][5] = 8'b11111100;
		
		mem[4][15] = 8'b11111100;
		mem[4][16] = 8'b11111100;
		mem[4][17] = 8'b11111100;
		mem[4][18] = 8'b11111100;
		mem[4][19] = 8'b11111100;
		mem[4][20] = 8'b11111100;
		
		mem[4][50] = 8'b11111100;
		mem[4][51] = 8'b11111100;
		mem[4][52] = 8'b11111100;
		mem[4][53] = 8'b11111100;
		mem[4][54] = 8'b11111100;
		mem[4][55] = 8'b11111100;
		
		init4 = 1;
	end
		temp4[7:0] = mem[1][0][7:0] ;
		for ( move4 = 0; move4 < 127 ; move4 = move4+1) begin
			mem[4][move4][7:0] = mem[4][move4+1][7:0] ;
		end
		mem[4][127][7:0] = temp4[7:0];
	
end








//Fifth lane
	always@(negedge divider[23]) begin
	if (init5 == 0) begin
		mem[5][0] = 8'b11111100;
		mem[5][1] = 8'b11111100;
		mem[5][2] = 8'b11111100;
		mem[5][3] = 8'b11111100;
		mem[5][4] = 8'b11111100;
		mem[5][5] = 8'b11111100;
		
		init5 = 1;
	end
		temp5[7:0] = mem[5][0][7:0] ;
		for ( move5 = 0; move5 < 127 ; move5 = move5+1) begin
			mem[5][move5][7:0] = mem[5][move5+1][7:0] ;
		end
		mem[5][127][7:0] = temp5[7:0];
	
end

//Sixth lane
	always@(negedge divider[28]) begin
	if (init6 == 0) begin
		/*mem[6][0] = 8'b11111100;
		mem[6][1] = 8'b11111100;
		mem[6][2] = 8'b11111100;
		mem[6][3] = 8'b11111100;
		mem[6][4] = 8'b11111100;
		mem[6][5] = 8'b11111100;
		
		mem[6][15] = 8'b11111100;
		mem[6][16] = 8'b11111100;
		mem[6][17] = 8'b11111100;
		mem[6][18] = 8'b11111100;
		mem[6][19] = 8'b11111100;
		mem[6][20] = 8'b11111100;
	/*	
		lane6[3] = 1;
		lane6[4] = 1;
		lane6[5] = 1;
		lane6[6] = 1; 
	*/
		init6 = 1;
	end
	/*else begin
	if (init6 == 2) begin
		mem[6][0] = 8'b00000000;
		mem[6][1] = 8'b00000000;
		mem[6][2] = 8'b00000000;
		mem[6][3] = 8'b00000000;
		mem[6][4] = 8'b00000000;
		mem[6][5] = 8'b00000000;
		
		mem[6][15] = 8'b00000000;
		mem[6][16] = 8'b00000000;
		mem[6][17] = 8'b00000000;
		mem[6][18] = 8'b00000000;
		mem[6][19] = 8'b00000000;
		mem[6][20] = 8'b00000000;
		
		mem[6][50] = 8'b00000000;
		mem[6][51] = 8'b00000000;
		mem[6][52] = 8'b00000000;
		mem[6][53] = 8'b00000000;
		mem[6][54] = 8'b00000000;
		mem[6][55] = 8'b00000000;
		init6 = 1;
	end*/	

		//temp6[7:0] = mem[6][0][7:0] ;
		for ( move6 = 0; move6 < 128 ; move6 = move6+1) begin
			temp6 = (pos6+move6)%128;
			mem[6][move6][7:0] = {1'b0, lane6[temp6],lane6[temp6],lane6[temp6],lane6[temp6],lane6[temp6],lane6[temp6],1'b0} ;
			//mem[6][move6] <= mem[6][move6+1];
		end
		pos6 =(pos6 == 127)? 0 : pos6 + 1;
		//mem[6][127][7:0] = temp6[7:0];
	/*if (left && left_prev == 0) begin
			if (!(mem[6][sheep_col][7:0] == 8'b11111100 || mem[6][sheep_col+1][7:0] == 8'b11111100 || mem[6][sheep_col+2][7:0] == 8'b11111100 || mem[6][sheep_col+3][7:0] == 8'b11111100)) begin
			mem[6][sheep_col][7:0] = 8'b00111000;
			mem[6][sheep_col+1][7:0] = 8'b01000110;
			mem[6][sheep_col+2][7:0] = 8'b01000110;
			mem[6][sheep_col+3][7:0] = 8'b00111000;	
	end
		end
	left_prev = left;*/
		
end
//Clock dividing function
always @ (posedge clk) divider <= divider + 1;
	
	//Screen Refreshing block
	always@(posedge divider[8]) begin
		count <= count + 1;
		reset <= 1;
		cs1 <= 1; 
		cs2 <= 1;
		
		if(count <= 9)
			begin lcd_rs <= 0; lcd_rw <= 0; lcd_e <= 0; lcd_data <= 8'b00000000; end
		else if(count == 10)
			begin lcd_rs <= 0; lcd_rw <= 0; lcd_data <= 8'b00111111; lcd_e <= 1; end
		else if(count == 11)
			lcd_e <= 0;
		else if(count == 12)
			begin lcd_rs <= 0; lcd_rw <= 0; lcd_data <= 184+page; lcd_e <= 1; end
		else if(count == 13)
			lcd_e <= 0;
		else if(count == 14)
			begin lcd_rs <= 0; lcd_rw <= 0; lcd_data <= 64+col ; lcd_e <= 1; end
		else if(count == 15)
			lcd_e <= 0;
		else begin		
			if(!already_on) begin
				if (i <64 ) begin
					cs1 <= 1;
					cs2 <= 0;
				end 
				else if (i > 63) begin
					cs1 <= 0;
					cs2 <= 1;
				end
				
				lcd_rs <=1 ; 
				lcd_rw <= 0; 
				lcd_data = /*(page <4 && page>0)? 8'b11111111-mem[page][i] : */ mem[page][i];
				lcd_e <= 1; 
				i <= i+1;
				already_on <= 1;
				if (i == 128) begin
					i <= 0;
					page = (page ==7)? 0 : page+ 1 ;
					count <= 10;
				end
			end
			else begin
				already_on <= 0;
				lcd_e <= 0;
			end
		end
end		
endmodule
