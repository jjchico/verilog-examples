// Design:      seg7-display
// File:        seg7-display-hex_tb.v
// Description: Seven segment display on terminal for test benches
//              (hexadecimal wrapper test bench)
// Author:      Jorge Juan <jjchico@gmail.com>
// Date:        23-Nov-2017

////////////////////////////////////////////////////////////////////////////////
// This file is free software: you can redistribute it and/or modify it under //
// the terms of the GNU General Public License as published by the Free       //
// Software Foundation, either version 3 of the License, or (at your option)  //
// any later version. See <http://www.gnu.org/licenses/>.                     //
////////////////////////////////////////////////////////////////////////////////

`timescale 1ns / 1ps

// We enable synchronous mode. Update display with posedge clk.
`define SEG7_DISPLAY_SYNC

`include "seg7-display.v"

// Base time for easy simulation control
`define BTIME 10


// Fibonacci senquence generation and display in 7-segment hexadecimal
module test();

    // Input
    reg [15:0] n, oldn;
    reg clk;

    // UUT instance
    seg7_display_hex #(
        .numdigits(4),
        .clear(0),      // set to '1' to overwrite previous value
        .vs(4),
        .hs(7),
        .vdotchar("O"),
        .hdotchar("O"),
        .hlwidth(1),
        .vlwidth(2),
        .interline(1),
        .gapchars("    ")) uut (.clk(clk), .hex(n));

    // Input initialization and simulation control
    initial begin
        // variables initialization
        n = 1; oldn = 0;

        // Simulation ends
        #(24*`BTIME) $finish;
    end

    // Input pattern generation
    always begin
        #(`BTIME/2) clk = 1;    // display current value
        n <= n + oldn;          // schedule new calculations
        oldn <= n;
        #(`BTIME/2) clk = 0;    // reset clock
    end
endmodule // test
