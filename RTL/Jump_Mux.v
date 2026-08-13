`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 26.04.2026 15:27:38
// Design Name: 
// Module Name: Jump_Mux
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

/* This Mus will Select new_PC value depends on Control signal and Branch/Jump Instruction */

module Jump_Mux(input [31:0]Branch_Mux_Out,Jump_Address,input Jump,output [31:0]next_PC);
assign next_PC = (Jump) ? Jump_Address : Branch_Mux_Out;
endmodule

