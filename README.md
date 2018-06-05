# Verilog Examples

**Repository moved to: https://gitlab.com/jjchico/verilog-examples**

Various, hopefully useful, Verilog examples.

## Introduction

Some Verilog examples I use for teaching Verilog, that may be useful for other projects as well. Most (if not all) the examples are tested with [Icarus Verilog](http://iverilog.icarus.com/).

Are you new to Verilog? Verilog is a hardware description language. With Verilog you design digital hardware, from a simple controller to a full microprocessor. Thanks to Hardware Description Languages (HDLs) like Verilog and Field Programmable Gate Array (FPGA) chips, anyone can design and build their own hardware. Here you are a couple of places to start with:

  * [curso-verilog.v](https://github.com/jjchico/curso-verilog.v) - My introductory digital circuits course using only Verilog examples (only in Spanish at the moment).
  * [Open FPGA Verilog Tutorial](https://github.com/Obijuan/open-fpga-verilog-tutorial/wiki/Home_EN) - Learn digital design and Verilog in the most practical and free way.

## List of examples

Some examples, the most elaborated, include their own **README.md** file with a detailed description. Other examples includes all the relevant information in the source code. Some examples propose some exercises.

Featured examples are highlighted.

  * [bcd-7](bcd-7) - Simple BCD to seven segments converter.
  * [bin-bcd](bin-bcd) - Binary to BCD converter using the double-dabble algorithm.
  * [bin-gray](bin-gray) - Binary-to-Gray and Gray-to-binary parametrizable converters.
  * [debouncer](debouncer) - De-bouncing and edge-detecting circuits. A must if you are taking your input from a physical switch or button.
  * [seg7-4d-display](seg7-4d-display) - 4-digit 7-segment display controller for typical devices like found in several FPGA and microcontroller boards.
  * **[seg7-display-txt](seg7-display-txt)** - Fully fledged Verilog module that displays seven segment codes in a terminal using ASCII characters.


## Authors

  * **Jorge Juan-Chico**

## Licence

This is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version. See <http://www.gnu.org/licenses/>.

## Thanks

  * My students at the [ETSII](https://www.informatica.us.es/) who motivated most of these examples.
