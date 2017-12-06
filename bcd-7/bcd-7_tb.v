// Design: bcd-7
// Description: BCD to 7-segment converter. Test bench
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
    reg [3:0] d;

    // Output
    wire [0:6] seg;

    // UUT instance
    display uut (.d(d), .seg(seg));

    // Input initialization and simulation control
    initial begin
        // 'd' is initiated to '0'
        d = 0;

        // Waveform generation statements
        // $dumpfile("test.vcd");
        // $dumpvars(0,test);

        // Results printing
        $display("d\tseg");
        $monitor("%d\t%b", d, seg);

        // Simulation end after 16 ciclyes
        #(16*`BTIME) $finish;
    end

    // Input pattern generation
    always
        #(`BTIME) d = d + 1;

endmodule // test

/*
   EXERCISES

   1. Compile the test bench with:

        $ iverilog bcd-7.v bcd-7_tb.v

   2. Simulate the design with:

        $ vvp a.out

   3. Check the results printed in the terminal and check that the 'seg' values
      correspond to the input 'd'.
*/
