`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 26.04.2026 15:20:14
// Design Name: 
// Module Name: MemtoReg_Mux
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


/* This mux Will select ALU Result or Read Data from Memory based upon control Signal Memtoreg*/

module MemtoReg_Mux(input [31:0]Read_data,ALU_Result,input MemtoReg,output [31:0]Write_data);
assign Write_data = (MemtoReg) ? Read_data : ALU_Result;
endmodule
