`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 26.04.2026 15:25:28
// Design Name: 
// Module Name: Branch_Mux
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

/* This Mus will Select new_PC value depends on Control signal and Branch Instruction */

module Branch_Mux(input [31:0]PC_Plus,Branch_Target,input BrTaken,output [31:0]next_PC);
assign next_PC = (BrTaken) ? Branch_Target : PC_Plus;
endmodule
