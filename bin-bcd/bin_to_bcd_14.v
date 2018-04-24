// Design: bin_to_bcd
// Module: bin_to_bcd_13
// Description: Binary to BCD converter using the double dabble algorithm.
// Author: Jorge Juan-Chico <jjchico@gmail.com>
// Date: 24-04-2018 (original)

////////////////////////////////////////////////////////////////////////////////
// This file is free software: you can redistribute it and/or modify it under //
// the terms of the GNU General Public License as published by the Free       //
// Software Foundation, either version 3 of the License, or (at your option)  //
// any later version. See <http://www.gnu.org/licenses/>.                     //
////////////////////////////////////////////////////////////////////////////////

//
// Binary to BCD 14-bit converter, 4 BCD digits, 0 -- 9999
//
// Binary input: bin[13:0]
//
// BCD output
//   dec[15:12] thousands
//   dec[11:8]  hundreds
//   dec[7:4]   tens
//   dec[3:0]   units
//
// Overflow (bin > 9999) is not checked!
//
// This is a combinational implementation of the double dabble algorithm.
// See:
//   * http://en.wikipedia.org/wiki/Double_dabble
//   * http://www.classiccmp.org/cpmarchives/cpm/mirrors/
//     cbfalconer.home.att.net/download/dubldabl.txt

module bin_to_bcd_14 (
    input wire [13:0] bin,   // binary input
    output reg [15:0] dec    // BCD output
    );

    reg [13:0] b;     // local copy of bin
    integer i;        // loop counter

    always @* begin
        b = bin;
        dec = 16'd0;

        for (i=0; i<13; i=i+1) begin
            // shift left dec and b
            {dec,b} = {dec,b} << 1;
            if (dec[3:0] > 4)        // check units
                dec[3:0] = dec[3:0] + 4'd3;
            if (dec[7:4] > 4)        // check tens
                dec[7:4] = dec[7:4] + 4'd3;
            if (dec[11:8] > 4)       // check hundreds
                dec[11:8] = dec[11:8] + 4'd3;
            if (dec[15:12] > 4)       // check thousands
                dec[15:12] = dec[15:12] + 4'd3;
        end
        {dec,b} = {dec,b} << 1;  // shift once more
    end
endmodule // bin_to_bcd_14
