`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    12:10:07 02/24/2015 
// Design Name: 
// Module Name:    RSLatch 
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
module RSLatch(
    input trigger,
    input clr,
    input rst,
    output Q
    );
	
	
	//input trigger,clr,rst;
	//output Q;
	wire x;
	
	//using blocking
	assign x = (trigger | Q);
	assign Q = x & ~(rst|clr);
	
endmodule
