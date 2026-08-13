`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 26.04.2026 15:24:31
// Design Name: 
// Module Name: Branch_AND_Gate
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

/* This Module will generate select line for Branch_Mux */

module Branch_AND_Gate(input Branch,Zero,output BrTaken);
assign BrTaken = Branch & Zero;
endmodule
