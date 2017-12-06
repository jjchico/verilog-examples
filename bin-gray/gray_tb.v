// Design: gray
// Description: bin/gray converters. Test bench
// Author: Jorge Juan <jjchico@dte.us.es>
// Copyright Universidad de Sevilla, Spain
// Date: 28-10-2010


////////////////////////////////////////////////////////////////////////////////
// This file is free software: you can redistribute it and/or modify it under //
// the terms of the GNU General Public License as published by the Free       //
// Software Foundation, either version 3 of the License, or (at your option)  //
// any later version. See <http://www.gnu.org/licenses/>.                     //
////////////////////////////////////////////////////////////////////////////////

`timescale 1ns / 1ps

// Base time to easy simulation control
`define BTIME 10

module test();

    // Inputs
    reg [3:0] x;

    // Output
    wire [3:0] z_gray, z_bin;

    // Circuit under test: cascade connection of bin/gray and gray/bin
    // converters.
    bin_gray bin_gray1 (.x(x), .z(z_gray));
    gray_bin gray_bin1 (.x(z_gray), .z(z_bin));

    // Input initialization and simulation control
    initial begin
        // Initially all the inputs are zero
        x = 4'b0000;

        // Waveform generation statements
        /* $dumpfile("test.vcd"); */
        /* $dumpvars(0,test); */

        // Output printing
        /* 'z_bin' should be equal to 'x' if the converters are working
         * correctly. */
        $display("     ----------  z_gray  ----------         ");
        $display("x --| bin/gray |--------| gray/bin |-- z_bin");
        $display("     ----------          ----------         ");
        $display(" ");
        $display("x\tz_gray\tz_bin ");
        $monitor("%b\t%b\t%b", x, z_gray, z_bin);

        // Simulation end
        /* We will apply a new input pattern every BTIME ns. Simulation
         * end time is calculated from BTIME so that we simulate 16
         * input patterns (all the posibilities). */
        #(16*`BTIME) $finish;
    end

    // Input pattern generation
    /* Just incrementing 'x' is enough to generate all the possible input
     * patterns. */
    always
        #(`BTIME) x = x + 1;

endmodule // test

/*
   EXERCISES

   1. Compile the test bench with:

        $ iverilog gray.v gray_tb.v

   2. Simulate the design with:

        $ vvp a.out

   3. Modify the test bench to simulate 8-bit bin/gray and gray/bin converters.
*/
