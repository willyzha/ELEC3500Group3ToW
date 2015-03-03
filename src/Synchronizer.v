`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    12:21:22 02/24/2015 
// Design Name: 
// Module Name:    Synchronizer 
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
module Synchronizer(
    input push,
    input clk,
    input rst,
    output reg sypush
    );
	 
	//input push,clk,rst;
   //output sypush;
	
	
	always @(posedge clk or posedge rst)
	begin
	if(rst)sypush = 0;
	else sypush = push;
	
	end
	
endmodule
