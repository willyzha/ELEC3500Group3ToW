`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    12:15:37 03/02/2015 
// Design Name: 
// Module Name:    scorer_tb 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module scorer_tb;
	
	reg clk;		 		// input clk 
	reg rst;				// asynchronous reset
	reg right;			// indicates who was pushed first 
	reg LEDS_ON;		// used to indicate whether the light's were on to determine a jump-the-light
	reg tie;
	reg winrnd;			// one-cycle pulse that someone has pushed
	reg fake; 			//1 if fake play state, 0 if real
	reg speed_tie;
	reg speed_right;
	reg winspeed;
	wire [6:0] score;	//  MSB 5 [WL L2 L1 0 R1 R2 WR] LSB 0
   wire [6:0] fake_score;
	
	
	scorer scorer_inst(.winrnd(winrnd), 
							.right(right), 
							.leds_on(LEDS_ON), 
							.tie(tie), 
							.clk(clk), 
							.rst(rst), 
							.fake(fake), 
							.score(score), 
							.fake_score(fake_score), 
							.speed_tie(speed_tie), 
							.speed_right(speed_right), 
							.winspeed(winspeed));

	//clock
	always #20 clk <= ~clk;
	
		initial begin
		LEDS_ON=1;
		winspeed=0;
		speed_right=0;
		speed_tie=0;
		fake=0;
		clk=0;
		rst=0;
		tie=0;
		winrnd=0;
		right = 0;
						
		@(posedge clk); #1;
		rst = 1;
		@(posedge clk); #1;
		rst = 0;
		repeat(4) @(posedge clk);
		//N to L1
		right=0;
		@(posedge clk); #1;
		winrnd=1;
		@(posedge clk); #1;
		winrnd=0;
		//L1 to L2
		right=0;
		@(posedge clk); #1;
		winrnd=1;
		@(posedge clk); #1;
		winrnd=0;
		//L2 to L3 (a)
		right=0;
		@(posedge clk); #1;
		winrnd=1;
		@(posedge clk); #1;
		winrnd=0;
		//L3 to L1
		right=1;
		@(posedge clk); #1;
		winrnd=1;
		@(posedge clk); #1;
		winrnd=0;
		//L1 to L2
		right=0;
		@(posedge clk); #1;
		winrnd=1;
		@(posedge clk); #1;
		winrnd=0;
		//L2 to L1 (b)
		right=1;
		@(posedge clk); #1;
		winrnd=1;
		@(posedge clk); #1;
		winrnd=0;
		//L1 to N
		right=1;
		@(posedge clk); #1;
		winrnd=1;
		@(posedge clk); #1;
		winrnd=0;
		//N to R1
		right=1;
		@(posedge clk); #1;
		winrnd=1;
		@(posedge clk); #1;
		winrnd=0;
		//R1 to R2
		right=1;
		@(posedge clk); #1;
		winrnd=1;
		@(posedge clk); #1;
		winrnd=0;
		//R2 to R3
		right=1;
		@(posedge clk); #1;
		winrnd=1;
		@(posedge clk); #1;
		winrnd=0;
		//R3 to R1 (c) favor the loser
		right=0;
		@(posedge clk); #1;
		winrnd=1;
		@(posedge clk); #1;
		winrnd=0;
		//R1 to R2
		right=1;
		@(posedge clk); #1;
		winrnd=1;
		@(posedge clk); #1;
		winrnd=0;
		//R2 to R3
		right=1;
		@(posedge clk); #1;
		winrnd=1;
		@(posedge clk); #1;
		winrnd=0;
		//R3 to R2 (d) Jumping the light
		LEDS_ON=0;
		right=1;
		@(posedge clk); #1;
		winrnd=1;
		@(posedge clk); #1;
		winrnd=0;
		//R2 to R3
		LEDS_ON=1;
		right=1;
		@(posedge clk); #1;
		winrnd=1;
		@(posedge clk); #1;
		winrnd=0;
		//R2 to RWIN (e) win
		right=1;
		@(posedge clk); #1;
		winrnd=1;
		@(posedge clk); #1;
		winrnd=0;
		
		repeat(5) @(posedge clk) #1;
		rst = 1;
		@(posedge clk); #1;
		rst = 0;
		
		repeat(5) @(posedge clk);
		$finish;
		
	end
	

endmodule
