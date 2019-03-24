`timescale 1ns / 100ps // time-unit = 1 ns, precision = 100 ps
module segasixbutton_tb;
	// Inputs
	reg p7; // Clock from Sega Mega Drive
	reg up; // Up button
	reg dw; // Down button
	reg lf; // Left button
	reg rg; // Right button
	reg a;  // A button
	reg b;  // B button
	reg c;  // C button
	reg st; // Start button
	reg x;  // X button
	reg y;  // Y button
	reg z;  // Z button
	reg md; // Mode button

	reg clk = 1'd0;

	// Outputs
	wire p1; // DB9 Pin 1 to Sega Mega Drive
	wire p2; // DB9 Pin 2 to Sega Mega Drive
	wire p3; // DB9 Pin 3 to Sega Mega Drive
	wire p4; // DB9 Pin 4 to Sega Mega Drive
	wire p6; // DB9 Pin 6 to Sega Mega Drive
	wire p9; // DB9 Pin 9 to Sega Mega Drive

	// Instantiate the Unit Under Test (UUT)
	md_sixbutton_encoder joystick (
		.p7(p7), 
		.up(up), 
		.dw(dw),
		.lf(lf),
		.rg(rg),
		.a(a),
		.b(b),
		.c(c),
		.st(st),
		.x(x),
		.y(y),
		.z(z),
		.md(md),
		.clk(clk),

		.p1(p1),
		.p2(p2),
		.p3(p3),
		.p4(p4),
		.p6(p6),
		.p9(p9)
	);

	always #50 clk <= !clk; // 20Mhz

	initial begin
		// Initialize Inputs
		p7 = 0;
		up = 1;
		dw = 1;
		lf = 1;
		rg = 1;
		a = 1;
		b = 1;
		c = 1;
		st = 1;
		x = 1;
		y = 1;
		z = 1;
		md = 1;

		#4000000 p7 = 1;
		#4000000 p7 = 0;
		#4000000 p7 = 1;
		#4000000 p7 = 0;
		#20 p7 = 1;
		#20 p7 = 0;
		#20 p7 = 1;
		#20 p7 = 0;

		// #20 p7 = 0;
		// #20 p7 = 1;
		// #20 p7 = 0;
		// #20 p7 = 1;
		// #20 p7 = 0;
		// #20 p7 = 1;
		// #20 p7 = 0;
		// #20 p7 = 1;
		// #20 p7 = 0;
		//#40
	end  

	initial begin
		$monitor("p7=%d,p1=%d,p2=%d,p3=%d,p4=%d,p6=%d,p9=%d \n",p7,p1,p2,p3,p4,p6,p9);
	end

endmodule