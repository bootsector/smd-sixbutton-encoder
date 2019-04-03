/*
	Verilog Sega Genesis/Mega Drive Joystick Encoder v1.3
	(C) Bruno Freitas - 03/2019 - http://www.brunofreitas.com/
	Released under MIT License.
*/

module smdsixbutton (
	input clk,
	input p7,
	output reg [5:0] p = 6'b111111,
	input up,	 // Up button
	input dw,	 // Down button
	input lf,	 // Left button
	input rg,	 // Right button
	input a,	 // A button
	input b,	 // B button
	input c,	 // C button
	input st,	 // Start button
	input x,	 // X button
	input y,	 // Y button
	input z,	 // Z button
	input md	 // Mode button
);

parameter TIMEOUT = 8000; // For 10Mhz oscillator
//parameter TIMEOUT = 16000; // For 20Mhz oscillator

reg [2:0] transition = 3'b0;

reg [15:0] clk_counter = TIMEOUT;

reg last_p7 = 1'b0;

always @(posedge clk) begin
	if(clk_counter == 0) begin
		$display("Reset!");
		clk_counter <= TIMEOUT;
		transition <= 0;
		last_p7 <= p7;
	end else begin
		if(p7 != last_p7) begin
			clk_counter <= TIMEOUT;
			transition <= transition + 1;
			last_p7 <= p7;
		end

		clk_counter <= clk_counter - 1;
	end
end

always @(p7) begin
	case ({transition, p7})
		4'b0000: p = {up, dw, 1'b0, 1'b0, a, st};
		4'b0001: p = {up, dw, lf, rg, b, c};
		4'b0010: p = {up, dw, 1'b0, 1'b0, a, st};
		4'b0011: p = {up, dw, lf, rg, b, c};
		4'b0100: p = {up, dw, 1'b0, 1'b0, a, st};
		4'b0101: p = {up, dw, lf, rg, b, c};
		4'b0110: p = {1'b0, 1'b0, 1'b0, 1'b0, a, st};
		4'b0111: p = {up, dw, lf, rg, b, c};
		4'b1000: p = {1'b0, 1'b0, 1'b0, 1'b0, a, st};
		4'b1001: p = {z, y, x, md, 1'b1, 1'b1};
		4'b1010: p = {1'b1, 1'b1, 1'b1, 1'b1, a, st};
		4'b1011: p = {z, y, x, md, 1'b1, 1'b1};
		4'b1100: p = {1'b1, 1'b1, 1'b1, 1'b1, a, st};
		4'b1101: p = {up, dw, lf, rg, b, c};
		4'b1110: p = {up, dw, 1'b0, 1'b0, a, st};
		4'b1111: p = {up, dw, lf, rg, b, c};
	endcase
end

endmodule