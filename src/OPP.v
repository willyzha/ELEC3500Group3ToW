`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    12:25:21 02/24/2015 
// Design Name: 
// Module Name:    OPP 
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
module OPP(
    input sypush,
    input clk,
    input rst,
    output winrnd
    );

	//input sypush,clk,rst;
   //output winrnd;
	reg winrnd_delay;
	
	always @(posedge clk or negedge rst)
    begin
		if(rst)
			winrnd_delay = 0;
		else
			winrnd_delay = sypush;
	end

	assign winrnd = sypush & ~winrnd_delay;

endmodule
