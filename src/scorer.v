`timescale 1ns / 1ps
module scorer(winrnd, right, leds_on, tie, clk, rst, fake, score, fake_score, speed_tie, speed_right, winspeed);
	`define WR  1
	`define R3  2
    `define R2  3
	`define R1  4
	`define N   5
	`define L1  6
	`define L2  7
	`define L3  8
	`define WL  9 
	`define ERROR  0

	input clk;		    // input clk 
	input rst;	// asynchronous reset
	input right;		// indicates who was pushed first 
	input leds_on;		// used to indicate whether the light's were on to determine a jump-the-light
	input tie;
	input winrnd;		// one-cycle pulse that someone has pushed
	input fake; //1 if fake play state, 0 if real
	input speed_tie;
	input speed_right;
	input winspeed;
	output [6:0] score;	//  MSB 5 [WL L2 L1 0 R1 R2 WR] LSB 0
   output [6:0] fake_score;	
	reg [6:0] score;	
	reg [3:0] state;	// One of WL, WR, L1, L2, L3, R1, R2, R3 or ERROR
	reg [3:0] nxtstate;	// C/L
	reg [6:0] fake_score;

	// SYNCHRONOUS STATE ASSIGNMENT ---------------------------------------------
	always @(posedge clk or posedge rst) begin
   		if (rst) state <= `N;
   		else state <= nxtstate;
	end

    //  Next State logic:  Determine next-state of scorer based on current state and input
    wire mr;            
	// move right if right pushed properly, or if left pushed improperly
	assign mr = (right & leds_on & ~fake) | (~right & ~leds_on) | (leds_on & ~right & fake) |(speed_right); //MR if right wins or left loses by pushing too fast, or left pushes in fake state, or fake state

	always @(state or mr or leds_on or winrnd or tie or fake or winspeed or speed_tie) begin
		nxtstate = state;		
		if((winrnd & ~tie)|(winspeed & ~speed_tie)) begin
			if(leds_on & ~fake) begin       
				// Proper pushes (uses favour the loser options)
				case(state) //if in real state
					`N:		if(mr) nxtstate = `R1; else nxtstate=`L1;	
					`L1:	if(mr) nxtstate = `N; else nxtstate=`L2;	
					`L2:	if(mr) nxtstate = `L1; else nxtstate=`L3;	
					`L3:	if(mr) nxtstate = `L1; else nxtstate=`WL;	
					`R1:	if(mr) nxtstate = `R2; else nxtstate=`N;	
					`R2:	if(mr) nxtstate = `R3; else nxtstate =`R1;
					`R3:	if(mr) nxtstate = `WR; else nxtstate=`R1; 
					`WL:	nxtstate = `WL;
					`WR:	nxtstate = `WR;
					default: nxtstate = `ERROR;
				endcase
			end else begin // the leds were off, player jumped the light, OR in fake state
				case(state)
					`N:		if(mr) nxtstate = `R1; else nxtstate=`L1;
					`L1:	if(mr) nxtstate = `N; else nxtstate=`L2;
					`L2:	if(mr) nxtstate = `L1; else nxtstate=`L3;
					`L3:	if(mr) nxtstate = `L2; else nxtstate=`WL;
					`R1:	if(mr) nxtstate = `R2; else nxtstate=`N;
					`R2:	if(mr) nxtstate = `R3; else nxtstate=`R1;
					`R3:	if(mr) nxtstate = `WR; else nxtstate=`R2; 
					`WL:	nxtstate = `WL;
					`WR:	nxtstate = `WR;	
					default: nxtstate = `ERROR;
				endcase
			end
		end
	end

    // output logic - what value of 'score' should show based on the internal state
	always @(state) begin
		case(state)
		`N:		begin score = 7'b0001000; fake_score = 7'b0001001; end
		`L1:	begin score = 7'b0010000; fake_score = 7'b0010010; end
		`L2:	begin score = 7'b0100000; fake_score = 7'b0011000; end
		`L3:	begin score = 7'b1000000; fake_score = 7'b0000011; end
		`R1:	begin score = 7'b0000100; fake_score = 7'b0000101; end
		`R2:	begin score = 7'b0000010; fake_score = 7'b0100010; end
		`R3:	begin score = 7'b0000001; fake_score = 7'b1000100; end
		`WL:	begin score = 7'b1110000; fake_score = 7'b1000010; end
		`WR:	begin score = 7'b0000111; fake_score = 7'b0010001; end
		default: begin score = 7'b1010101; fake_score = 7'b0001001; end 
		endcase
    end
endmodule

