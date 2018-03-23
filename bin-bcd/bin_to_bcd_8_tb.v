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
// 8-bit binary to BCD converter. Test bench.
//

`timescale 1ns/1ps

module test ();

    reg [7:0] bin;
    wire [9:0] dec;

    bin_to_bcd_8 uut(.bin(bin), .dec(dec));

    always
        #10 bin = bin + 1;

    initial begin
        $dumpfile("bin_to_bcd_8_tb.vcd");
        $dumpvars(0,test);

        bin = 0;

        $display("binary (decimal) -> BCD (BCD decimal)");
        $monitor("%b (%d) -> %b (%d%d%d)", bin, bin, dec,
                 dec [9:8], dec[7:4], dec[3:0]);

        #2560 $finish;
    end
endmodule // test
