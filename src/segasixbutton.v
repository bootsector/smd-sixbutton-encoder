/*
    Verilog Sega Genesis/Mega Drive Joystick Encoder v1.1
    (C) Bruno Freitas - 03/2019 - http://www.brunofreitas.com/
    Released under MIT License.
*/
module md_sixbutton_encoder (
    input p7,    // Select pin from Sega Mega Drive
    input up,    // Up button
    input dw,    // Down button
    input lf,    // Left button
    input rg,    // Right button
    input a,     // A button
    input b,     // B button
    input c,     // C button
    input st,    // Start button
    input x,     // X button
    input y,     // Y button
    input z,     // Z button
    input md,    // Mode button
    input clk,   // External clock for the timeout reset (i.e. 20Mhz)
    output reg p1 = 1, // DB9 Pin 1 to Sega Mega Drive
    output reg p2 = 1, // DB9 Pin 2 to Sega Mega Drive
    output reg p3 = 1, // DB9 Pin 3 to Sega Mega Drive
    output reg p4 = 1, // DB9 Pin 4 to Sega Mega Drive
    output reg p6 = 1, // DB9 Pin 6 to Sega Mega Drive
    output reg p9 = 1  // DB9 Pin 9 to Sega Mega Drive
);

parameter CLK_FREQ = 20000000; // For a 20Mhz oscillator

reg [2:0]  transition = 3'b111;

reg [15:0] clk_counter = CLK_FREQ / 500;

reg last_p7 = 1'b0;

always @(p7 or posedge clk) begin        
    if (p7 != last_p7) begin
        transition <= transition + 1;
        clk_counter <= CLK_FREQ / 500;
        last_p7 <= p7;
    end

    if (clk) begin
        clk_counter <= clk_counter - 1;

        // Reset transition at every 2ms (500Hz)
        if (clk_counter == 0) begin
            $display("Timeout!\n");
            transition <= 0;
            clk_counter <= CLK_FREQ / 500;
        end
    end
end

always @(*) begin
    if (p7) begin
        case (transition)
            0, 1, 2, 3, 6, 7: begin
                p1 <= up;
                p2 <= dw;
                p3 <= lf;
                p4 <= rg;
                p6 <= b;
                p9 <= c;
            end
            4, 5: begin
                p1 <= z;
                p2 <= y;
                p3 <= x;
                p4 <= md;
                p6 <= 1;
                p9 <= 1;
            end
        endcase
    end else begin
        case (transition)
            0, 1, 2, 7: begin
                p1 <= up;
                p2 <= dw;
                p3 <= 0;
                p4 <= 0;
                p6 <= a;
                p9 <= st;
            end
            3, 4: begin
                p1 <= 0;
                p2 <= 0;
                p3 <= 0;
                p4 <= 0;
                p6 <= a;
                p9 <= st;
            end
            5, 6: begin
                p1 <= 1;
                p2 <= 1;
                p3 <= 1;
                p4 <= 1;
                p6 <= a;
                p9 <= st;
            end
        endcase
    end
end

endmodule