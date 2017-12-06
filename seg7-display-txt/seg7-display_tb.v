// Design:      seg7-display
// File:        seg7-display_tb.v
// Description: Seven segment display on terminal for test benches (test bench)
// Author:      Jorge Juan <jjchico@gmail.com>
// Date:        23-Nov-2017

////////////////////////////////////////////////////////////////////////////////
// This file is free software: you can redistribute it and/or modify it under //
// the terms of the GNU General Public License as published by the Free       //
// Software Foundation, either version 3 of the License, or (at your option)  //
// any later version. See <http://www.gnu.org/licenses/>.                     //
////////////////////////////////////////////////////////////////////////////////

`timescale 1ns / 1ps

// Uncomment to enable synchronous mode instead of asynchronous mode
//`define SEG7_DISPLAY_SYNC
`include "seg7-display.v"

// Some useful 7-segment definitions
`include "seg7.vh"

// Base time for easy simulation control
`define BTIME 10

module test();

    // Input
    reg [0:4*7-1] seg;  // 4 digits
    reg clk = 1'b0;

    // Tiny
    seg7_display #(
        .numdigits(4),
        .hs(1),             // horizontal space (controls width)
        .vs(1),             // vertical space (controls height)
        .interline(1))      // additional interlining
         uut_tiny (.clk(clk), .seg(seg));

    // Default format
    seg7_display #(.numdigits(4)) uut_default (.clk(clk), .seg(seg));

    // Bigger, more spacing, double lines
    seg7_display #(
        .numdigits(4),
        .hs(5),             // horizontal space (controls width)
        .vs(3),             // vertical space (controls height)
        .vlwidth(2),        // vertical lines width
        .hdotchar("="),     // horizontal lines character
        .gapchars("  "))   // digit separator
         uut_bigger (.clk(clk), .seg(seg));

    // Huge
    seg7_display #(
        .numdigits(4),
        .hs(12),             // horizontal space (controls width)
        .vs(6),             // vertical space (controls height)
        .vlwidth(3),        // vertical lines width
        .hlwidth(2),        // horizontal lines width
        .vdotchar("#"),     // vertical lines character
        .hdotchar("#"),     // horizontal lines character
        .gapchars("  "),    // digit separator
        .interline(2))      // more interlining
        uut_huge (.clk(clk), .seg(seg));


    // Input initialization and simulation control
    initial begin
        // show vector being processed
        $monitor("seg = %b_%b_%b_%b", seg[0:6], seg[7:13],
                                      seg[14:20], seg[21:27]);

        #(`BTIME/2) seg = {`S7_0,`S7_1,`S7_2,`S7_3};
        #`BTIME     seg = {`S7_4,`S7_5,`S7_6,`S7_7};
        #`BTIME     seg = {`S7_8,`S7_9,`S7_A,`S7_B};
        #`BTIME     seg = {`S7_C,`S7_D,`S7_E,`S7_F};

        // Simulation end
        #`BTIME $finish;
    end

    // Used in synchronous mode. Only part of the vectors are displayed
    always
        #`BTIME clk = ~clk;

endmodule // test
