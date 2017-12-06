// Design:      seg7-display
// File:        seg7-display.v
// Description: Seven segment display on terminal for test benches
// Author:      Jorge Juan <jjchico@gmail.com>
// Date:        23-Nov-2017

////////////////////////////////////////////////////////////////////////////////
// This file is free software: you can redistribute it and/or modify it under //
// the terms of the GNU General Public License as published by the Free       //
// Software Foundation, either version 3 of the License, or (at your option)  //
// any later version. See <http://www.gnu.org/licenses/>.                     //
////////////////////////////////////////////////////////////////////////////////

`timescale 1ns / 1ps

// Uncomment or define elsewhere if you want the synchronous behaviour
// triggered by a positive edge in clk
//`define SEG7_DISPLAY_SYNC

// Some convenient macros acting as enum
`define SEG7_FIRST_LINE 0
`define SEG7_UPPER_LINE 1
`define SEG7_MIDDLE_LINE 2
`define SEG7_LOWER_LINE 3
`define SEG7_BOTTOM_LINE 4

// ANSI terminal control sequences
`define TTY_CLEAR {8'o33, "[2J"}    // clear terminal
`define TTY_HOME {8'o33, "[H"}      // move cursor to home (top-left corner)

/*
    seg7_display - display 7-segments vectors as ASCII graphics in the terminal

    Input:
        seg: chained 7-segment input vectors. Vectors are redndered from left
             to right. Number of input digits is selected with "numdigits"
             parameter. Active value of the segments is selected with "active"
             parameter.
        clk: clock signal. Output is rendered with the rising edge of clk if
             the synchronous behaviour is selected by defining SEG7_DISPLAY_SYNC
             macro. Otherwise, clk is ignored and output is rendered whenever
             seg changes its value.
    Output:
        An ASCII graphics representation of the 7-segment input vectors is
        displayed on the standard output (terminal, console, etc.). Output
        format can be controlled by multiple parameters.
*/

module seg7_display #(
    parameter numdigits = 1,    // number of digits in the input
    parameter active = 0,       // active level (0 - low, 1 - high)
    parameter clear = 0,        // clear terminal (0 - no, 1 - yes)
    parameter vlwidth = 1,      // vertical segments width in chars
    parameter hlwidth = 1,      // horizontal segments width in chars
    parameter vs = 2,           // vertical space between horizontal segments
    parameter hs = 3,           // horizontal space between vertical segments
    parameter hdotchar = "-",   // char to draw active horizontal segments
    parameter vdotchar = "|",   // char to draw active vertical segments
    parameter blankchar = " ",  // char to draw non-active segments
    parameter gapchars = " ",   // filling string between adjacent digits
    parameter interline = 0     // no. of lines between rows
    )(
    input wire clk,                  // clock signal for synchronous operation
    input wire [0:7*numdigits-1] seg // chained 7-seg input vectors
    );

    localparam dotwidth = 8*vlwidth;

    reg [dotwidth-1:0] vdot = {vlwidth{vdotchar[7:0]}};
    reg [dotwidth-1:0] hdot = {vlwidth{hdotchar[7:0]}};
    reg [dotwidth-1:0] blank = {vlwidth{blankchar[7:0]}};

    // a couple of convenient macros
    `define BLANKLINE {blank, {hs{blankchar}}, blank}
    `define HLINE {blank, {hs{hdotchar}}, blank}

    reg [0:7*numdigits-1] s;
    reg starting = 1'b1;

    // renders a line corresponding to a 7-seg vector
    task render_line (
        input  [0:6] seg,
        input [3:0] ln);
        begin
            case (ln)
            `SEG7_FIRST_LINE:
                $write("%s", seg[0] == active ? `HLINE : `BLANKLINE);
            `SEG7_UPPER_LINE:
                $write("%s%s%s", seg[5] == active ? vdot : blank,
                    {hs{blankchar}}, seg[1] == active ? vdot : blank);
            `SEG7_MIDDLE_LINE:
                $write("%s", seg[6] == active ? `HLINE : `BLANKLINE);
            `SEG7_LOWER_LINE:
                $write("%s%s%s", seg[4] == active ? vdot : blank,
                    {hs{blankchar}}, seg[2] == active ? vdot : blank);
            `SEG7_BOTTOM_LINE:
                $write("%s", seg[3] == active ? `HLINE : `BLANKLINE);
            default:
                $write("??????");    // should never get here
            endcase
        end
    endtask

    // render lines with ASCII
`ifdef SEG7_DISPLAY_SYNC
    always @ (posedge clk) begin
`else
    always @ (seg) begin
`endif
        // clear terminal. Real clear only first time, then just go home
        if (clear == 1'b1)
            if(!starting)
                $write("%s", `TTY_HOME);
            else begin
                starting = 1'b0;
                $write("%s", `TTY_CLEAR);
                $write("%s", `TTY_HOME);
            end
        $fflush();
        // draw first line
        repeat(hlwidth) begin
            s = seg;
            repeat(numdigits-1) begin
                render_line(s[0:6], `SEG7_FIRST_LINE);
                s = (s << 7);
                $write("%s", gapchars);
            end
            render_line(s[0:6], `SEG7_FIRST_LINE);
            $write("\n");
        end
        // draw upper lines
        repeat(vs) begin
            s = seg;
            repeat(numdigits-1) begin
                render_line(s[0:6], `SEG7_UPPER_LINE);
                s = s << 7;
                $write("%s", gapchars);
            end
            render_line(s[0:6], `SEG7_UPPER_LINE);
            $write("\n");
        end
        // draw middle line
        repeat(hlwidth) begin
            s = seg;
            repeat(numdigits-1) begin
                render_line(s[0:6], `SEG7_MIDDLE_LINE);
                s = s << 7;
                $write("%s", gapchars);
            end
            render_line(s[0:6], `SEG7_MIDDLE_LINE);
            $write("\n");
        end
        // draw lower lines
        repeat(vs) begin
            s = seg;
            repeat(numdigits-1) begin
                render_line(s[0:6], `SEG7_LOWER_LINE);
                s = s << 7;
                $write("%s", gapchars);
            end
            render_line(s[0:6], `SEG7_LOWER_LINE);
            $write("\n");
        end
        // draw bottom line
        repeat(hlwidth) begin
            s = seg;
            repeat(numdigits-1) begin
                render_line(s[0:6], `SEG7_BOTTOM_LINE);
                s = s << 7;
                $write("%s", gapchars);
            end
            render_line(s[0:6], `SEG7_BOTTOM_LINE);
            $write("\n");
        end
        // interline
        repeat(interline)
            $write("\n");
        $fflush();
    end
endmodule

/*
    seg7_display_hex - display binary vector as hex ASCII graphics
        in the terminal

    Input:
        hex: chained 4-bit hex input vectors. Vectors are redndered from left
             to right. Number of input digits is selected with "numdigits"
             parameter.
        clk: clock signal. Output is rendered with the rising edge of clk if
             the synchronous behaviour is selected by defining SEG7_DISPLAY_SYNC
             macro. Otherwise, clk is ignored and output is rendered whenever
             seg changes its value.
    Output:
        An ASCII graphics representation of the hexadecimal input vectors is
        displayed on the standard output (terminal, console, etc.). Output
        format can be controlled by multiple parameters.

    It is a wrapper to seg7_display including an hex-7segment converter.
*/

module seg7_display_hex #(
    parameter numdigits = 1,    // number of digits in the input
    parameter active = 0,       // active level (0 - low, 1 - high)
    parameter clear = 0,        // clear terminal (0 - no, 1 - yes)
    parameter vlwidth = 1,      // vertical segments width in chars
    parameter hlwidth = 1,      // horizontal segments width in chars
    parameter vs = 2,           // vertical space between horizontal segments
    parameter hs = 3,           // horizontal space between vertical segments
    parameter hdotchar = "-",   // char to draw active horizontal segments
    parameter vdotchar = "|",   // char to draw active vertical segments
    parameter blankchar = " ",  // char to draw non-active segments
    parameter gapchars = " ",   // filling string between adjacent digits
    parameter interline = 0     // no. of lines between rows
    )(
    input wire clk,                  // clock signal for synchronous operation
    input wire [4*numdigits-1:0] hex // chained hexadecimal input digits
    );

    function [6:0] hex2seven(
        input [3:0] hex
        );
        case (hex)
        4'h0: hex2seven = 7'b0000001;
        4'h1: hex2seven = 7'b1001111;
        4'h2: hex2seven = 7'b0010010;
        4'h3: hex2seven = 7'b0000110;
        4'h4: hex2seven = 7'b1001100;
        4'h5: hex2seven = 7'b0100100;
        4'h6: hex2seven = 7'b0100000;
        4'h7: hex2seven = 7'b0001111;
        4'h8: hex2seven = 7'b0000000;
        4'h9: hex2seven = 7'b0000100;
        4'ha: hex2seven = 7'b0001000;
        4'hb: hex2seven = 7'b1100000;
        4'hc: hex2seven = 7'b0110001;
        4'hd: hex2seven = 7'b1000010;
        4'he: hex2seven = 7'b0110000;
        4'hf: hex2seven = 7'b0111000;
        // default: hex2seven = 7'b0110110;
        /* setting a default here makes Icarus Verilog to evaluate the
           module and execute seg7_display at compile time, even without
           instantiating the seg7_display_hex module! If it is the expected
           behaviour of a Verilog simulator or a bug, I do not know. */
        endcase
    endfunction

    reg [0:7*numdigits-1] seg;
    reg [4*numdigits-1:0] d;

    always @(hex) begin
        d = hex;
        repeat(numdigits-1) begin
            seg[0:6] = hex2seven(d[3:0]);
            seg = seg >> 7;
            d = d >> 4;
        end
        seg[0:6] = hex2seven(d[3:0]);
    end

    seg7_display #(
        .numdigits(numdigits),
        .active(active),
        .clear(clear),
        .vlwidth(vlwidth),
        .hlwidth(hlwidth),
        .vs(vs),
        .hs(hs),
        .hdotchar(hdotchar),
        .vdotchar(vdotchar),
        .blankchar(blankchar),
        .gapchars(gapchars),
        .interline(interline)
        )  s7_display (.clk(clk), .seg(seg));

endmodule //seg7_display_hex
