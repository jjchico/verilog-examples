// Design: display_ctrl
// Description: Four-digit, 7-segment display controller.
// Author: Jorge Juan <jjchico@gmail.com>
// Date: 13-11-2011 (original)

////////////////////////////////////////////////////////////////////////////////
// This file is free software: you can redistribute it and/or modify it under //
// the terms of the GNU General Public License as published by the Free       //
// Software Foundation, either version 3 of the License, or (at your option)  //
// any later version. See <http://www.gnu.org/licenses/>.                     //
////////////////////////////////////////////////////////////////////////////////

//////////////////////////////////////////////////////////////////////////
// Display controller                                                   //
//////////////////////////////////////////////////////////////////////////

/*
    Display controller for typical 4-digit 7-segment display devices like found
    in several FPGA and microcontroller boards.
*/

module display_ctrl #(
    parameter cdbits = 18,      // clock divider bits
                                // Clock freq.  bits
                                //       50MHz  18
                                //      100MHz  19
                                //      200MHz  20
                                //      400MHz  21
                                //      800MHz  22    etc.
    parameter hex = 0           // output hexadecimal format
                                //   0 - decimal only (display invalid as "-")
                                //   1 - hexadecimal (0123456789AbCdEf)
    )(
    input wire ck,              // system clock
    input wire [3:0] x3,        // display digits, from left to right
    input wire [3:0] x2,
    input wire [3:0] x1,
    input wire [3:0] x0,
    input wire [3:0] dp_in,     // decimal point vector
    output reg [0:6] seg,       // 7-segment output
    output reg [3:0] an,        // anode output
    output reg dp               // decimal point output
    );

    // Internal signals
    reg [cdbits-1:0] counter = 'd0;    // clock divider counter
    reg [3:0] d;                       // 7-seg converter input

    // Clock divider
    always @(posedge ck)
        counter = counter + 1;

    // Anode signal decoder
    always @*
        case (counter[cdbits-1:cdbits-2])
        2'd0: an = 4'b1110;
        2'd1: an = 4'b1101;
        2'd2: an = 4'b1011;
        2'd3: an = 4'b0111;
        endcase

    // 7-seg converter multiplexer
    always @*
        case (counter[cdbits-1:cdbits-2])
        2'd0: d = x0;
        2'd1: d = x1;
        2'd2: d = x2;
        2'd3: d = x3;
        endcase

    // 7-seg converter
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
        4'ha: seg = hex ? 7'b0001000 : 7'b1111110;
        4'hb: seg = hex ? 7'b1100000 : 7'b1111110;
        4'hc: seg = hex ? 7'b0110001 : 7'b1111110;
        4'hd: seg = hex ? 7'b1000010 : 7'b1111110;
        4'he: seg = hex ? 7'b0110000 : 7'b1111110;
        default: seg = hex ? 7'b0111000 : 7'b1111110; // F
        endcase

    // Decimal point decoder
    always @*
        case (counter[cdbits-1:cdbits-2])
        2'd0: dp = dp_in[0];
        2'd1: dp = dp_in[1];
        2'd2: dp = dp_in[2];
        2'd3: dp = dp_in[3];
        endcase

endmodule // display ctrl
