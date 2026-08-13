`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 26.04.2026 15:21:54
// Design Name: 
// Module Name: Shift_left_2_branch
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

/* this module will used in calculating target address for branch instruction */
// Target = (PC + 4) + (SignExtendedImmediate * 4)
module Shift_left_2_branch(input [31:0]in,output [31:0]out);
assign out = {in[29:0],2'b00};
endmodule
