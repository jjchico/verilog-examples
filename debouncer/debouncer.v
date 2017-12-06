// Design: debouncer
// Description: Counter-based debouncers.
// Author: Jorge Juan <jjchico@dte.us.es>
// Copyright Universidad de Sevilla, Spain
// Date: 21-12-2011

////////////////////////////////////////////////////////////////////////////////
// This file is free software: you can redistribute it and/or modify it under //
// the terms of the GNU General Public License as published by the Free       //
// Software Foundation, either version 3 of the License, or (at your option)  //
// any later version. See <http://www.gnu.org/licenses/>.                     //
////////////////////////////////////////////////////////////////////////////////

/*
   Every button or switch may produces "bounces" when changing from on to off or
   from off to on: the contact oscillates during the connection or disconnection
   process and several pulses can be produced before the connection settles to
   an stable value. In digital, the signal may oscillate between '0' and '1'
   before reaching the final state.

   For this reason, in any practical digital circuits, inputs coming from
   switches or push buttons are filtered through special circuits called
   "debouncers" that eliminate the oscillating part of the signal and produce
   a single transition when the signal changes from one value to the other.

   Because bounces are produced very quickly and last for a very short time
   (less than 1ms) a possible strategy to implement a bouncer is to use a
   counter so that the input (bouncing) value is copied to the output only
   when it has been stable for a given number of clock cycles.

   In this examples, a debouncer circuit with an input x and an output z is
   implemented so that the input is considered stable and copied to the
   output when it has been stable for about 1ms. The system clock is
   considered to run at 50MHz.

   An edge detector is also implemented. The edge detector generates single
   clock cycle pulse when the input changes its value. In this example, only
   positive (rising) edges are detected. An edge detector can be used together
   with a debouncer to generate a clean single cycle pulse from a noisy input.
*/

`timescale 1ns / 1ps

//////////////////////////////////////////////////////////////////////////
// Debouncer                                                            //
//////////////////////////////////////////////////////////////////////////

module debouncer #(
    parameter delay = 50000   // number of cycles to consider stable
                              // it makes 1ms with a 50MHz clock
    )(
    input wire ck,      // clock
    input wire x,       // input
    output reg z = 0    // output
    );

    reg [15:0] count = 0;    // can count from 0 to 65535

    always @(posedge ck) begin
        /* If the input is equal to the output, keep the same output
         * and reset the counter */
        if (x == z)
            count <= delay;
        /* If the input is different from the output, change the
         * output but only if the diference lasts for the defined
         * delay */
        else begin
            count <= count - 1;
            if (count == 0)
                z <= x;
        end
    end
endmodule // debouncer

//////////////////////////////////////////////////////////////////////////
// Edge detector                                                        //
//////////////////////////////////////////////////////////////////////////

module edge_detector (
    input wire ck,      // clock
    input wire x,       // input
    output reg z = 0    // output
    );

    reg old_x = 0;

    always @(posedge ck) begin
        old_x <= x;
        if (old_x != x && x == 1'b1)
            z <= 1;
        else
            z <= 0;
    end
endmodule // edge_detector

/*
   EXERCISE

   1. Compile the modules in this file with:

      $ iverilog debouncer.v

      to check that there are not syntax errors.
*/
