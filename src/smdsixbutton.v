/*
	Verilog Sega Genesis/Mega Drive Joystick Encoder v2.2
	(C) Bruno Freitas - 03/2019 - http://www.brunofreitas.com/
	Released under MIT License.
*/

module smdsixbutton (
	input clk,
	input p7,	 // DB9_PIN7 (SEL)
	output reg [5:0] p = 6'b111111, // {DB9_PIN1, DB9_PIN2, DB9_PIN3, DB9_PIN4, DB9_PIN6, DB9_PIN9}
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

reg [15:0] clk_counter = TIMEOUT;

reg [1:0] hi_count = 2'b0;

reg mode_set = 1'b0;
reg three_button_mode = 1'b0;

reg last_p7_1 = 1'b0;
reg last_p7_2 = 1'b0;

always @(posedge clk) begin
	last_p7_1 <= p7;
	last_p7_2 <= last_p7_1;

	if(!mode_set) begin
		three_button_mode <= !md;
		mode_set <= 1'b1;
	end

	if(!three_button_mode) begin
		if (clk_counter == 0) begin
			$display("Reset!");
			clk_counter <= TIMEOUT;
			hi_count <= 0;
		end else begin
			if (last_p7_1 && !last_p7_2) begin
				hi_count <= hi_count + 1;
				clk_counter <= TIMEOUT;
			end else begin
				clk_counter <= clk_counter - 1;
			end
		end
	end
end

always @(p7) begin
	$display("hi_count=%d", hi_count);
	case ({hi_count, p7})
		3'b000: p = {up, dw, 1'b0, 1'b0, a, st};
		3'b001: p = {up, dw, lf, rg, b, c};
		3'b010: p = {up, dw, 1'b0, 1'b0, a, st};
		3'b011: p = {up, dw, lf, rg, b, c};
		3'b100: p = {1'b0, 1'b0, 1'b0, 1'b0, a, st};
		3'b101: p = {up, dw, lf, rg, b, c};
		3'b110: p = {1'b1, 1'b1, 1'b1, 1'b1, a, st};
		3'b111: p = {z, y, x, md, 1'b1, 1'b1};
	endcase
end

endmodule
