// Design:      seg7-display
// File:        seg7.vh
// Description: Useful 7 segment definitions
// Author:      Jorge Juan <jjchico@gmail.com>
// Date:        23-Nov-2017

////////////////////////////////////////////////////////////////////////////////
// This file is free software: you can redistribute it and/or modify it under //
// the terms of the GNU General Public License as published by the Free       //
// Software Foundation, either version 3 of the License, or (at your option)  //
// any later version. See <http://www.gnu.org/licenses/>.                     //
////////////////////////////////////////////////////////////////////////////////

// Include only once
`ifndef SEG7_INCLUDED
`define SEG7_INCLUDED

// 7 segment hexadecimal digits
`define S7_0 7'b0000001
`define S7_1 7'b1001111
`define S7_2 7'b0010010
`define S7_3 7'b0000110
`define S7_4 7'b1001100
`define S7_5 7'b0100100
`define S7_6 7'b0100000
`define S7_7 7'b0001111
`define S7_8 7'b0000000
`define S7_9 7'b0000100
`define S7_A 7'b0001000
`define S7_B 7'b1100000
`define S7_C 7'b0110001
`define S7_D 7'b1000010
`define S7_E 7'b0110000
`define S7_F 7'b0111000

`endif
