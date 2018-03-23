// Design: bin_to_bcd
// Module: bin_to_bcd_8
// Description: Binary to BCD converter using the double dabble algorithm.
// Author: Jorge Juan <jjchico@gmail.com>
// Date: 02-12-2011 (original)

////////////////////////////////////////////////////////////////////////////////
// This file is free software: you can redistribute it and/or modify it under //
// the terms of the GNU General Public License as published by the Free       //
// Software Foundation, either version 3 of the License, or (at your option)  //
// any later version. See <http://www.gnu.org/licenses/>.                     //
////////////////////////////////////////////////////////////////////////////////

//
// 8-bit binary to BCD converter, 2 1/2 BCD digits, 0 -- 255
//
// See
//   http://en.wikipedia.org/wiki/Double_dabble
//   http://www.classiccmp.org/cpmarchives/cpm/mirrors/
//     cbfalconer.home.att.net/download/dubldabl.txt

module bin_to_bcd_8 (
    input wire [7:0] bin,   // binary input
    output reg [9:0] dec    // BCD output
    );

    reg [7:0] b;    // local copy of b
    integer i;      // loop counter

    always @* begin
        b = bin;
        dec = 10'd0;

        for (i=0; i<7; i=i+1) begin
            // shift left d and bi
            {dec,b} = {dec,b} << 1;
                if (dec[7:4] > 4)        // check tens
                    dec[7:4] = dec[7:4] + 4'd3;
                if (dec[3:0] > 4)        // check units
                    dec[3:0] = dec[3:0] + 4'd3;
        end
        {dec,b} = {dec,b} << 1;  // shift once more
    end
endmodule // bin_to_bcd_8
