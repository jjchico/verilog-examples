// Design: gray
// Description: Parametrized bin/gray converters
// Author: Jorge Juan <jjchico@dte.us.es>
// Copyright Universidad de Sevilla, Spain
// Date: 12-11-2011

////////////////////////////////////////////////////////////////////////////////
// This file is free software: you can redistribute it and/or modify it under //
// the terms of the GNU General Public License as published by the Free       //
// Software Foundation, either version 3 of the License, or (at your option)  //
// any later version. See <http://www.gnu.org/licenses/>.                     //
////////////////////////////////////////////////////////////////////////////////

/*
   Parametrized (n-bit) bin/gray and Gray/bin converter. Visit
   http://www.wisc-online.com/Objects/ViewObject.aspx?ID=IAU8307
   for a nice explanation of bin/Gray conversion fundamentals.
*/

`timescale 1ns / 1ps

// Bin/Gray converter
module bin_gray #(
    parameter n = 4
    )(
    input wire [n-1:0] x,
    output wire [n-1:0] z
    );

    assign z = x ^ (x >> 1);

endmodule    // bin_gray

// Gray/bin converter
module gray_bin #(
    parameter n = 4
    )(
    input wire [n-1:0] x,
    output wire [n-1:0] z
    );

    assign z = x ^ (z >> 1);

endmodule    // gray_bin

/*
   EXERCISES

   Check that the design syntax is correct by compiling the file with:

      $ iverilog gray.v

   (This example continues in file gray_tb.v)
*/
