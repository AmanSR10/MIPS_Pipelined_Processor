`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 26.04.2026 15:23:05
// Design Name: 
// Module Name: Branch_Adder
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

/* This Module Will used to calcule target address for branch instruction */
// Target = (PC + 4) + (SignExtendedImmediate * 4)
module Branch_Adder(input [31:0]a,b,output [31:0]sum);
assign sum = a + b;
endmodule