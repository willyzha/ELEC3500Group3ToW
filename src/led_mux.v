 `timescale 1ns / 1ps

module led_mux(score, led_control, fake_score, speed_led, leds_out);

    input wire [6:0] score; 
	input wire [6:0] fake_score;
	input wire [6:0] speed_led;
	input wire [2:0] led_control;
    output reg [6:0] leds_out;
 
always @(led_control or score or fake_score or speed_led) begin
//score output by scorer controls which LEDs are on, as dictated by led_control
//states are 00 = display reset code, 01 = all leds off (dark), 11 = display score
	case(led_control)
		3'b000: leds_out = 7'b0000000; //all off - dark state
		3'b001: leds_out = 7'b1001011; //RESET student number = 1008867[75]
		3'b010: leds_out = 7'b1111111;//all on - wait states
		3'b011: leds_out = score;//displaying score in play state;
		3'b100: leds_out = fake_score;//display fake round score
		3'b110: leds_out = speed_led;//SPEED SOMETHING OR ANOTHER!
		default: leds_out = 7'b1001011; //Default case same as reset
	endcase
end

endmodule
