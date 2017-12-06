// Design: bin_bcd
// Description: Binary to BCD converter using the double dabble algorithm.
// Author: Jorge Juan <jjchico@dte.us.es>
// Copyright Universidad de Sevilla, Spain
// Date: 02-12-2011

////////////////////////////////////////////////////////////////////////////////
// This file is free software: you can redistribute it and/or modify it under //
// the terms of the GNU General Public License as published by the Free       //
// Software Foundation, either version 3 of the License, or (at your option)  //
// any later version. See <http://www.gnu.org/licenses/>.                     //
////////////////////////////////////////////////////////////////////////////////

//////////////////////////////////////////////////////////////////////////
// 8 bit binary to BCD converter using the double dabble algorithm      //
//////////////////////////////////////////////////////////////////////////
// See
//   http://en.wikipedia.org/wiki/Double_dabble
//   http://www.classiccmp.org/cpmarchives/cpm/mirrors/
//     cbfalconer.home.att.net/download/dubldabl.txt
// BCD output
//   d[9:8]  hundreds
//   d[7:4]  tens
//   d[3:0]  units

module bin_to_bcd_8 (
    input wire [7:0] b,   // binary input
    output reg [9:0] d    // BCD output
    );

    reg [7:0] bi;     // local copy of b
    integer i;        // loop counter

    always @* begin
        bi = b;
        d = 10'd0;

        for (i = 0; i < 8; i = i + 1) begin
            // shift left d and bi
            d = {d[8:0], bi[7]};
            bi = bi << 1;

            if (i < 7) begin           // except the last loop
                if (d[7:4] > 4)        // check tens
                    d[7:4] = d[7:4] + 4'd3;
                if (d[3:0] > 4)        // check units
                    d[3:0] = d[3:0] + 4'd3;
            end
        end
    end
endmodule // bin_to_bcd_8
