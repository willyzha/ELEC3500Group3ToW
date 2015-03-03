`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    12:12:24 02/24/2015 
// Design Name: 
// Module Name:    PBL 
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
module PBL(
    input pbi,
    input pbr,
    input rst,
    input clr,
    output push,
    output tie,
    output right
    );
	 
	//input pbi,pbr,rst,clear;
	//output push,tie,right;
	wire g,h,G,H;
	
	
	assign g = pbi && !H;
	assign h = pbr && !G;
	
	//make sure of left and right
	RSLatch leftLatch(.trigger(g), .clr(clr), .rst(rst), .Q(G));
	RSLatch rightLatch(.trigger(h),.clr(clr), .rst(rst), .Q(H));
	

	
	assign push = pbr || pbi;
	//checkpoint 1
	//assign tie <= pbi&pbi;
	assign tie = G&&H;
	assign right = H&!G;
	
	 
endmodule
