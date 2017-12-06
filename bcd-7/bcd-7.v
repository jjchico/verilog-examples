// Design: bcd-7
// Description: BCD to 7-segment converter
// Author: Jorge Juan <jjchico@gmail.com>
// Date: 23-Nov-2017

////////////////////////////////////////////////////////////////////////////////
// This file is free software: you can redistribute it and/or modify it under //
// the terms of the GNU General Public License as published by the Free       //
// Software Foundation, either version 3 of the License, or (at your option)  //
// any later version. See <http://www.gnu.org/licenses/>.                     //
////////////////////////////////////////////////////////////////////////////////

/*
       0             Segments are active low
      ---
   5 |   | 1
      --- 6
   4 |   | 2
      ---
       3
*/

`timescale 1ns / 1ps

module display(
    input wire [3:0] d,
    output reg [0:6] seg
    );

    always @*
        case (d)
        4'h0: seg = 7'b0000001;
        4'h1: seg = 7'b1001111;
        4'h2: seg = 7'b0010010;
        4'h3: seg = 7'b0000110;
        4'h4: seg = 7'b1001100;
        4'h5: seg = 7'b0100100;
        4'h6: seg = 7'b0100000;
        4'h7: seg = 7'b0001111;
        4'h8: seg = 7'b0000000;
        4'h9: seg = 7'b0000100;
        default: seg = 7'b1111110;    // input is not BCD
        endcase
endmodule   // display
