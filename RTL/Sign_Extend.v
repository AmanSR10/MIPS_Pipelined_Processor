`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 26.04.2026 15:14:05
// Design Name: 
// Module Name: Sign_Extend
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


/* this Sign_Extend block will convert the 16-bit immediate field from 
the instruction (instr[15:0]) into a 32-bit value. */

module Sign_Extend(input [15:0]in ,output [31:0]out);
assign out = {{16{in[15]}},in};
endmodule