`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    12:55:13 02/24/2015 
// Design Name: 
// Module Name:    top_tb 
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
module top_tb;
	
	reg pbl, pbr, rst, clr, clk;
	reg LEDS_ON, winspeed, fake;
	reg speedRound;
    reg speedExit;
	reg [6:0] speed_led;
	reg [2:0] led_control;
	wire [6:0] leds_out;
	
	
	//instantiate
	top topinst(.pbl(pbl), .pbr(pbr),.rst(rst),.clk(clk),.clr(clr),.fake(fake), 
	                            .LEDS_ON(LEDS_ON),
                                .winspeed(winspeed),
                                .speed_led(speed_led),
                                .leds_out(leds_out),
                                .led_control(led_control),
                                .speedRound(speedRound),
                                .speedExit(speedExit));
	
	//clock
	always #20 clk <= ~clk;
        
				initial begin
            LEDS_ON=1;
            winspeed=0;
            fake=0;
            clk=0;
            rst=0;
            pbl=0;
            pbr=0;
            speedRound = 0;
            speedExit = 0;
            speed_led=1;
            led_control=3'b000;
            
            
            @(posedge clk); #1;
            rst = 1;
            clr = 1;
            led_control= 3'b001;
            @(posedge clk); #1;
            rst = 0;
            clr = 0;     
            led_control= 3'b011;
            repeat(4) @(posedge clk);
            
            //N to L1
            repeat(4) @(posedge clk); #1;
            pbl=1;
            repeat(2) @(posedge clk); #1;
            pbl=0;
            
            repeat(3) @(posedge clk); #1;
            clr = 1;
            @(posedge clk); #1;
            clr = 0;
            
            //L1 to L2
            repeat(4) @(posedge clk); #1;
            pbl=1;
            repeat(2) @(posedge clk); #1;
            pbl=0;
            
            repeat(3) @(posedge clk); #1;
            clr = 1;
            @(posedge clk); #1;
            clr = 0;
            
            //L2 to L3 (a)
            repeat(4) @(posedge clk); #1;
            pbl=1;
            repeat(2) @(posedge clk); #1;
            pbl=0;
            
            repeat(3) @(posedge clk); #1;
            clr = 1;
            @(posedge clk); #1;
            clr = 0;
            
            //L3 to L1
            repeat(4) @(posedge clk); #1;
            pbr=1;
            repeat(2) @(posedge clk); #1;
            pbr=0;
            
            repeat(3) @(posedge clk); #1;
            clr = 1;
            @(posedge clk); #1;
            clr = 0;
            
            //L1 to L2
            repeat(4) @(posedge clk); #1;
            pbl=1;
            repeat(2) @(posedge clk); #1;
            pbl=0;
            
            repeat(3) @(posedge clk); #1;
            clr = 1;
            @(posedge clk); #1;
            clr = 0;
            
            //L2 to L1 (b)
            repeat(4) @(posedge clk); #1;
            pbr=1;
            repeat(2) @(posedge clk); #1;
            pbr=0;
            
            repeat(3) @(posedge clk); #1;
            clr = 1;
            @(posedge clk); #1;
            clr = 0;
            
            //L1 to N
            repeat(4) @(posedge clk); #1;
            pbr=1;
            repeat(2) @(posedge clk); #1;
            pbr=0;
            
            repeat(3) @(posedge clk); #1;
            clr = 1;
            @(posedge clk); #1;
            clr = 0;
            
            //N to R1
            repeat(4) @(posedge clk); #1;
            pbr=1;
            repeat(2) @(posedge clk); #1;
            pbr=0;
            
            repeat(3) @(posedge clk); #1;
            clr = 1;
            @(posedge clk); #1;
            clr = 0;
            
            //R1 to R2
            repeat(4) @(posedge clk); #1;
            pbr=1;
            repeat(2) @(posedge clk); #1;
            pbr=0;
            
            repeat(3) @(posedge clk); #1;
            clr = 1;
            @(posedge clk); #1;
            clr = 0;
            
            //R2 to R3
            repeat(4) @(posedge clk); #1;
            pbr=1;
            repeat(2) @(posedge clk); #1;
            pbr=0;
            
            repeat(3) @(posedge clk); #1;
            clr = 1;
            @(posedge clk); #1;
            clr = 0;
            
            
            //R3 to R1 (c)
            repeat(4) @(posedge clk); #1;
            pbl=1;
            repeat(2) @(posedge clk); #1;
            pbl=0;
            
            repeat(3) @(posedge clk); #1;
            clr = 1;
            @(posedge clk); #1;
            clr = 0;
            
            //R1 to R2
            repeat(4) @(posedge clk); #1;
            pbr=1;
            repeat(2) @(posedge clk); #1;
            pbr=0;
            
            repeat(3) @(posedge clk); #1;
            clr = 1;
            @(posedge clk); #1;
            clr = 0;
            
            //R2 to R3
            repeat(4) @(posedge clk); #1;
            pbr=1;
            repeat(2) @(posedge clk); #1;
            pbr=0;
            
            repeat(3) @(posedge clk); #1;
            clr = 1;
            @(posedge clk); #1;
            clr = 0;
            
            //R3 to R2 (d) Jumping the light
            LEDS_ON = 0;
            repeat(4) @(posedge clk); #1;
            pbr=1;
            repeat(2) @(posedge clk); #1;
            pbr=0;
            
            repeat(3) @(posedge clk); #1;
            clr = 1;
            @(posedge clk); #1;
            clr = 0;
            LEDS_ON = 1;
            
            //R2 to R3
            repeat(4) @(posedge clk); #1;
            pbr=1;
            repeat(2) @(posedge clk); #1;
            pbr=0;
            
            repeat(3) @(posedge clk); #1;
            clr = 1;
            @(posedge clk); #1;
            clr = 0;
            
            //R2 to RWIN (e) win
            repeat(4) @(posedge clk); #1;
            pbr=1;
            repeat(2) @(posedge clk); #1;
            pbr=0;
            
            repeat(3) @(posedge clk); #1;
            clr = 1;
            @(posedge clk); #1;
            clr = 0;
            
            repeat(20) @(posedge clk);
            $finish;
            end
	
	
endmodule
	
