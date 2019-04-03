`timescale 1ns / 100ps // time-unit = 1 ns, precision = 100 ps
module smdsixbutton_tb;
	// Inputs
	reg p7; // Clock from Sega Mega Drive
	reg up; // Up button
	reg dw; // Down button
	reg lf; // Left button
	reg rg; // Right button
	reg a;	// A button
	reg b;	// B button
	reg c;	// C button
	reg st; // Start button
	reg x;	// X button
	reg y;	// Y button
	reg z;	// Z button
	reg md; // Mode button

	reg clk = 1'd0;

	integer j, k;

	// Outputs
	wire [5:0] p;

	// Instantiate the Unit Under Test (UUT)
	smdsixbutton joystick (
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

		.p(p)
	);

	//always #50 clk <= !clk; // 20Mhz
	always #100 clk <= !clk; // 10Mhz

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

		for(j = 0; j < 3; j++) begin
			for(k = 0; k < 10; k++) begin
				//$display("Current simulation time = %t",$time);
				//$strobe("transition=%d,p7=%d,p1=%d,p2=%d,p3=%d,p4=%d,p6=%d,p9=%d \n",debug,p7,p[5],p[4],p[3],p[2],p[1],p[0]);
				#13000 p7 = !p7;
			end
			#1600000 $display("delay");
			//$strobe("p7=%d,p1=%d,p2=%d,p3=%d,p4=%d,p6=%d,p9=%d \n",p7,p[5],p[4],p[3],p[2],p[1],p[0]);
			//#1800000 p7 = !p7;
		end

		// $strobe("p7=%d,p1=%d,p2=%d,p3=%d,p4=%d,p6=%d,p9=%d \n",p7,p[5],p[4],p[3],p[2],p[1],p[0]);
		// #13000 p7 = 1;
		// $strobe("p7=%d,p1=%d,p2=%d,p3=%d,p4=%d,p6=%d,p9=%d \n",p7,p[5],p[4],p[3],p[2],p[1],p[0]);
		// #13000 p7 = 0;
		// $strobe("p7=%d,p1=%d,p2=%d,p3=%d,p4=%d,p6=%d,p9=%d \n",p7,p[5],p[4],p[3],p[2],p[1],p[0]);
		// #13000 p7 = 1;
		// $strobe("p7=%d,p1=%d,p2=%d,p3=%d,p4=%d,p6=%d,p9=%d \n",p7,p[5],p[4],p[3],p[2],p[1],p[0]);
		// #13000 p7 = 0;
		// $strobe("p7=%d,p1=%d,p2=%d,p3=%d,p4=%d,p6=%d,p9=%d \n",p7,p[5],p[4],p[3],p[2],p[1],p[0]);
		// #13000 p7 = 1;
		// $strobe("p7=%d,p1=%d,p2=%d,p3=%d,p4=%d,p6=%d,p9=%d \n",p7,p[5],p[4],p[3],p[2],p[1],p[0]);
		// #13000 p7 = 0;
		// $strobe("p7=%d,p1=%d,p2=%d,p3=%d,p4=%d,p6=%d,p9=%d \n",p7,p[5],p[4],p[3],p[2],p[1],p[0]);
		// #13000 p7 = 1;
		// $strobe("p7=%d,p1=%d,p2=%d,p3=%d,p4=%d,p6=%d,p9=%d \n",p7,p[5],p[4],p[3],p[2],p[1],p[0]);
		// #13000 p7 = 0;
		// $strobe("p7=%d,p1=%d,p2=%d,p3=%d,p4=%d,p6=%d,p9=%d \n",p7,p[5],p[4],p[3],p[2],p[1],p[0]);

		// $strobe("p7=%d,p1=%d,p2=%d,p3=%d,p4=%d,p6=%d,p9=%d \n",p7,p[5],p[4],p[3],p[2],p[1],p[0]);
		// #13000 p7 = 0;
		// $strobe("p7=%d,p1=%d,p2=%d,p3=%d,p4=%d,p6=%d,p9=%d \n",p7,p[5],p[4],p[3],p[2],p[1],p[0]);
		// #13000 p7 = 1;
		// $strobe("p7=%d,p1=%d,p2=%d,p3=%d,p4=%d,p6=%d,p9=%d \n",p7,p[5],p[4],p[3],p[2],p[1],p[0]);
		// #13000 p7 = 0;
		// $strobe("p7=%d,p1=%d,p2=%d,p3=%d,p4=%d,p6=%d,p9=%d \n",p7,p[5],p[4],p[3],p[2],p[1],p[0]);
		// #13000 p7 = 1;
		// $strobe("p7=%d,p1=%d,p2=%d,p3=%d,p4=%d,p6=%d,p9=%d \n",p7,p[5],p[4],p[3],p[2],p[1],p[0]);
		// #13000 p7 = 0;
		// $strobe("p7=%d,p1=%d,p2=%d,p3=%d,p4=%d,p6=%d,p9=%d \n",p7,p[5],p[4],p[3],p[2],p[1],p[0]);
		// #13000 p7 = 1;
		// $strobe("p7=%d,p1=%d,p2=%d,p3=%d,p4=%d,p6=%d,p9=%d \n",p7,p[5],p[4],p[3],p[2],p[1],p[0]);
		// #13000 p7 = 0;
		// $strobe("p7=%d,p1=%d,p2=%d,p3=%d,p4=%d,p6=%d,p9=%d \n",p7,p[5],p[4],p[3],p[2],p[1],p[0]);
		// #13000 p7 = 1;
		// $strobe("p7=%d,p1=%d,p2=%d,p3=%d,p4=%d,p6=%d,p9=%d \n",p7,p[5],p[4],p[3],p[2],p[1],p[0]);
		// #13000 p7 = 0;
		// $strobe("p7=%d,p1=%d,p2=%d,p3=%d,p4=%d,p6=%d,p9=%d \n",p7,p[5],p[4],p[3],p[2],p[1],p[0]);
		//#40
	end	 

	initial begin
		//$monitor("p7=%d,p1=%d,p2=%d,p3=%d,p4=%d,p6=%d,p9=%d \n",p7,p[5],p[4],p[3],p[2],p[1],p[0]);
		$monitor("p7=%d,p1=%d,p2=%d,p3=%d,p4=%d,p6=%d,p9=%d \n",p7,p[5],p[4],p[3],p[2],p[1],p[0]);
	end

endmodule