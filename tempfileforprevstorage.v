
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
	reg[7:0] temp1, temp2, temp3, temp4, temp5, temp6, temp7;


	integer move1=0, move2 =0 , move3 = 0, move4= 0, move5 =0, move6 = 0, move7 = 0;
	integer timer = 0 ;
	integer init1 = 0, init2 =0 ,init3 =0, init4 = 0, init5 =0, init6 = 0, init7 = 0;
	integer col = 0;
	integer i = 0;
	integer page = 0;
	
	wire sclk;
	

	always@(*) begin
	//Clock Symbol -- Score lettering should come here..
	
	//Letter "S"
	mem[0][75][4:0] = 5'b10010; 
	mem[0][76][4:0] = 5'b10101; 
	mem[0][77][4:0] = 5'b10101; 
	mem[0][78][4:0] = 5'b10101; 
	mem[0][79][4:0] = 5'b01001;

	//Letter "C"
	mem[0][81][4:0] = 5'b00100; 
	mem[0][82][4:0] = 5'b01010; 
	mem[0][83][4:0] = 5'b10001;
	mem[0][84][4:0] = 5'b10001;
	mem[0][85][4:0] = 5'b10001;
	
	//Letter "O"
	mem[0][87][4:0] = 5'b01110; 
	mem[0][88][4:0] = 5'b10001; 
	mem[0][89][4:0] = 5'b10001;
	mem[0][90][4:0] = 5'b10001;
	mem[0][91][4:0] = 5'b01110;
	
	//Letter "R"
	mem[0][93][4:0] = 5'b11111; 
	mem[0][94][4:0] = 5'b00101; 
	mem[0][95][4:0] = 5'b00101;
	mem[0][96][4:0] = 5'b01010;
	mem[0][97][4:0] = 5'b10000;
	
	//Letter "E"
	mem[0][99][4:0] = 5'b11111; 
	mem[0][100][4:0] = 5'b10101; 
	mem[0][101][4:0] = 5'b10101;
	mem[0][102][4:0] = 5'b10101;
	mem[0][103][4:0] = 5'b10001;
	
	
	
	//Colon
	mem[0][105][4:0] = 5'b01010;
	end
	
	//Score increasing block			Change in divider[**] ** accordingly for rate of increase of score
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

	
//First lane
	always@(negedge divider[21]) begin
	if (init1 == 0) begin
		mem[1][0] = 8'b11001100;
		mem[1][1] = 8'b11111100;
		mem[1][2] = 8'b00110000;
		mem[1][3] = 8'b11111100;
		mem[1][4] = 8'b11111100;
		mem[1][5] = 8'b00110000;
		
		mem[1][15] = 8'b11001100;
		mem[1][16] = 8'b11111100;
		mem[1][17] = 8'b00110000;
		mem[1][18] = 8'b11111100;
		mem[1][19] = 8'b11111100;
		mem[1][20] = 8'b00110000;
		
		mem[1][50] = 8'b11001100;
		mem[1][51] = 8'b11111100;
		mem[1][52] = 8'b00110000;
		mem[1][53] = 8'b11111100;
		mem[1][54] = 8'b11111100;
		mem[1][55] = 8'b00110000;
		
/*		mem[1][70] = 8'b11001100;
		mem[1][71] = 8'b11111100;
		mem[1][72] = 8'b00110000;
		mem[1][73] = 8'b11111100;
		mem[1][74] = 8'b11111100;
		mem[1][75] = 8'b00110000;
		
		mem[1][77] = 8'b11001100;
		mem[1][78] = 8'b11111100;
		mem[1][79] = 8'b00110000;
		mem[1][80] = 8'b11111100;
		mem[1][81] = 8'b11111100;
		mem[1][82] = 8'b00110000;
		
		mem[1][88] = 8'b11001100;
		mem[1][89] = 8'b11111100;
		mem[1][90] = 8'b00110000;
		mem[1][91] = 8'b11111100;
		mem[1][92] = 8'b11111100;
		mem[1][93] = 8'b00110000;
		
		mem[1][105] = 8'b11001100;
		mem[1][106] = 8'b11111100;
		mem[1][107] = 8'b00110000;
		mem[1][108] = 8'b11111100;
		mem[1][109] = 8'b11111100;
		mem[1][110] = 8'b00110000;
*/				
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
		mem[2][0] = 8'b10000100;
		mem[2][1] = 8'b00110000;
		mem[2][2] = 8'b10110100;
		mem[2][3] = 8'b11111100;
		mem[2][4] = 8'b11111100;
		mem[2][5] = 8'b10110100;
		
		init2 = 1;
	end
		temp2[7:0] = mem[2][0][7:0] ;
		for ( move2 = 0; move2 < 127 ; move2 = move2+1) begin
			mem[2][move2][7:0] = mem[2][move2+1][7:0] ;
		end
		mem[2][127][7:0] = temp2[7:0];
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
	always@(negedge divider[23]) begin
	if (init6 == 0) begin
		mem[6][0] = 8'b11111100;
		mem[6][1] = 8'b11111100;
		mem[6][2] = 8'b11111100;
		mem[6][3] = 8'b11111100;
		mem[6][4] = 8'b11111100;
		mem[6][5] = 8'b11111100;
		
		init6 = 1;
	end
		temp6[7:0] = mem[6][0][7:0] ;
		for ( move6 = 0; move6 < 127 ; move6 = move6+1) begin
			mem[6][move6][7:0] = mem[6][move6+1][7:0] ;
		end
		mem[6][127][7:0] = temp6[7:0];
		
end

//Seventh lane
	always@(negedge divider[23]) begin
	if (init7 == 0) begin
		mem[7][0] = 8'b11111100;
		mem[7][1] = 8'b11111100;
		mem[7][2] = 8'b11111100;
		mem[7][3] = 8'b11111100;
		mem[7][4] = 8'b11111100;
		mem[7][5] = 8'b11111100;
		
		init7 = 1;
	end
		temp7[7:0] = mem[7][0][7:0] ;
		for ( move7 = 0; move7 < 127 ; move7 = move7+1) begin
			mem[7][move7][7:0] = mem[7][move7+1][7:0] ;
		end
		mem[7][127][7:0] = temp7[7:0];
		
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
				lcd_data = mem[page][i];
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
