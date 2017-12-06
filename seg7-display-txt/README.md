# seg7-display

Verilog module that displays seven segment codes in a terminal using ASCII characters.

## Introduction

The *seg7_display* module takes one or several seven-segment encoded number (seven bits) and displays the numbers graphically in the terminal using ASCII art.

As a bonus, a wrapper module *seg7_display_hex* takes a binary number and displays it on the terminal using a seven segment representation.

## Use cases

1. You have designed a circuit that outputs some 7-segment data and you want to
   check that the encoding is right.

2. Your circuit outputs regular binary but you want to see it as big 7-segment
   ASCII graphics when you run your simulation.

3. You want to generate long lists of hexadecimal numbers that will look awesome when printed in that old noisy continuous paper printer you have just found in your fathers penthouse, because it is a lot of fun.

## How does it look like?

These are outputs of the included test benches, run with the [Icarus Verilog](http://iverilog.icarus.com/) simulator.

### Format demo (partial output)

```
$ iverilog seg7-display_tb.v
$ vvp a.out
[...]
   ############        ############        ############                       
   ############        ############        ############                       
###            ###  ###            ###  ###            ###  ###               
###            ###  ###            ###  ###            ###  ###               
###            ###  ###            ###  ###            ###  ###               
###            ###  ###            ###  ###            ###  ###               
###            ###  ###            ###  ###            ###  ###               
###            ###  ###            ###  ###            ###  ###               
   ############        ############        ############        ############   
   ############        ############        ############        ############   
###            ###                 ###  ###            ###  ###            ###
###            ###                 ###  ###            ###  ###            ###
###            ###                 ###  ###            ###  ###            ###
###            ###                 ###  ###            ###  ###            ###
###            ###                 ###  ###            ###  ###            ###
###            ###                 ###  ###            ###  ###            ###
   ############        ############                            ############   
   ############        ############                            ############   


  =====      =====      =====             
||     ||  ||     ||  ||     ||  ||       
||     ||  ||     ||  ||     ||  ||       
||     ||  ||     ||  ||     ||  ||       
  =====      =====      =====      =====  
||     ||         ||  ||     ||  ||     ||
||     ||         ||  ||     ||  ||     ||
||     ||         ||  ||     ||  ||     ||
  =====      =====                 =====  
 ---   ---   ---       
|   | |   | |   | |    
|   | |   | |   | |    
 ---   ---   ---   ---
|   |     | |   | |   |
|   |     | |   | |   |
 ---   ---         ---
 -   -   -     
| | | | | | |  
 -   -   -   -
| |   | | | | |
 -   -       -

seg = 0000000_0000100_0001000_1100000
```

### Fibonacci sequence in hexadecimal (partial output)

```
    $ iverilog seg7-display-hex_tb.v
    $ vvp a.out
                     OOOOOOO        OOOOOOO                 
             OO    OO       OO    OO                      OO
             OO    OO       OO    OO                      OO
             OO    OO       OO    OO                      OO
             OO    OO       OO    OO                      OO
                     OOOOOOO        OOOOOOO        OOOOOOO  
             OO    OO       OO    OO       OO    OO       OO
             OO    OO       OO    OO       OO    OO       OO
             OO    OO       OO    OO       OO    OO       OO
             OO    OO       OO    OO       OO    OO       OO
                                    OOOOOOO        OOOOOOO  

      OOOOOOO        OOOOOOO        OOOOOOO        OOOOOOO  
             OO    OO       OO    OO                      OO
             OO    OO       OO    OO                      OO
             OO    OO       OO    OO                      OO
             OO    OO       OO    OO                      OO
      OOOOOOO        OOOOOOO                       OOOOOOO  
    OO             OO       OO    OO             OO         
    OO             OO       OO    OO             OO         
    OO             OO       OO    OO             OO         
    OO             OO       OO    OO             OO         
      OOOOOOO                       OOOOOOO        OOOOOOO  

                     OOOOOOO        OOOOOOO        OOOOOOO  
    OO       OO    OO                      OO    OO         
    OO       OO    OO                      OO    OO         
    OO       OO    OO                      OO    OO         
    OO       OO    OO                      OO    OO         
      OOOOOOO        OOOOOOO        OOOOOOO        OOOOOOO  
             OO             OO    OO             OO         
             OO             OO    OO             OO         
             OO             OO    OO             OO         
             OO             OO    OO             OO         
                     OOOOOOO        OOOOOOO                 

      OOOOOOO        OOOOOOO        OOOOOOO                 
    OO             OO             OO                      OO
    OO             OO             OO                      OO
    OO             OO             OO                      OO
    OO             OO             OO                      OO
      OOOOOOO        OOOOOOO        OOOOOOO                 
    OO       OO    OO             OO                      OO
    OO       OO    OO             OO                      OO
    OO       OO    OO             OO                      OO
    OO       OO    OO             OO                      OO
      OOOOOOO                                               
```

## Quick start

1. Download the *seg7-display.v* file at least. You may want to download the whole folder/repo to have the test benches.

1. Include *seg7-display.v* in your design.
   ```
   `include "seg7-display.v"
   ```
1. Place the *seg7_display* or *seg7_display_hex* module in your design. Connect the input of the module to the signal you want to display. E.g.
   ```
   seg7_display my_display (.seg(seven_segments_enconded_signal));
   ...
   seg7_display_hex my_hex_display (.hex(binary_number));
   ```
1. If you want the module to operate synchronously (with the rising edge of a clock signal), enable synchronous operation by defining the *SEG7_DISPLAY_SYNC* macro at the beginning of your file.
   ```
   `define SEG7_DISPLAY_SYNC
   ```

## Examples

See the test benches for additional examples.

### Example 1

Your signal *segmens* contains just one 7-segment-encoded number (7 bits) that you want to display using the default format. Just place the module in your design, connect your signal(s) to input *seg*.
```
seg7_display my_display (.seg(segments));
```

### Example 2

You have two signal *segs1* and *segs2* you want to display together. Tell the module you have two digits with parameter *numdigits* and combine the two signals in the order you want them displayed.
```
seg7_display #(.numdigits(2)) my_display (.seg({segs1, segs2}));
```

### Example 3

You want to go synchronous with your *strobe* signal:

```verilog
`define SEG7_DISPLAY_SYNC
// ...
seg7_display #(.numdigits(2))
    my_display (.clk(strobe), .seg({segs1, segs2}));
```

### Example 4

You want to display the output of your 16 bit counter in hexadecimal with a big 7 segments representation. This time, overwrite the old values instead of scrolling up the terminal.

```verilog
seg7_display_hex #(
    .numdigits(4),  // 16 bits are 4 hexadecimal digits
    .clear(1),      // clear and overwrite previous values
    .vs(4),         // vertical gap between horizontal segments
    .hs(7),         // horizontal gap between vertical segments
    .vdotchar("#"), // char to draw vertical segments
    .hdotchar("#")  // char to draw horizontal segments
    ) my_display (.seg(my_counter_output));
```

## Input, output and parameters

### Input signals

  * `seg` (*seg7_display* module): chained 7-segment encoded digits.
  * `hex` (*seg7_display_hex* module): chained 4-bit encoded digits.
  * `clk`: clock signal for synchronous operation. Printing takes place with the rising edge of `clk` if synchronous operation is selected

The behaviour of the modules and the format of the 7-segments representation can be controlled by a macro and optional parameters.

### Macros

  * `SEG7_DISPLAY_SYNC`: if defined, enables synchronous operation and the `clk` signal is relevant. Otherwise, printing takes place asynchronously whenever the input data changes.

### Parameters

All parameters are optional. Default values in parenthesis. You will probably want to change at least `numdigits`.

  * `numdigits (1)`   : number of digits in the input. Input `seg` is expected to be 7x*numdigits* bits wide, and input `hex` is expected to be 4x*numdigits* bits wide.
  * `active (0)`      : active level (0 - low, 1 - high)
  * `clear (0)`       : clear terminal (0 - no, 1 - yes)
  * `vlwidth (1)`     : vertical segments width in chars
  * `hlwidth (1)`     : horizontal segments width in chars
  * `vs (2)`          : vertical space between horizontal segments
  * `hs (3)`          : horizontal space between vertical segments
  * `hdotchar ("-")`  : char to draw active horizontal segments
  * `vdotchar ("|")`  : char to draw active vertical segments
  * `blankchar (" ")` : char to draw non-active segments
  * `gapchars (" ")`  : filling string between adjacent digits
  * `interline (0)`   : no. of lines between rows

## Running the test benches

Just simulate the included test bench files (ending in "\_tb.v") with your favorite Verilog simulator. For example, if you have Icarus Verilog installed, just run the following command in a terminal inside the project's folder:
```
$ iverilog seg7-display_tb.v
$ vvp a.out
...

$ iverilog seg7-display-hex_tb.v
$ vvp a.out
...
```

If you want to run the test benches with synchronous mode activated, just compile the desgings with the *SEG7_DISPLAY_SYNC* macro defined. E.g.
```
$ iverilog -D SEG7_DISPLAY_SYNC seg7-display_tb.v
$ vvp a.out
...
```

## Authors

  * **Jorge Juan-Chico**

## Licence

This is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version. See <http://www.gnu.org/licenses/>.
