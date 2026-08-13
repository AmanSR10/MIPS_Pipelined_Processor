`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 26.04.2026 15:15:31
// Design Name: 
// Module Name: ALUSrc_Mux
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


/* this Mux will select 2nd ALU input  based on control signal ALUSrc */
module ALUSrc_Mux(input ALUSrc,input [31:0]read_data2,SignExt_Imm,output [31:0]ALUin2 );
assign ALUin2 = (ALUSrc) ? SignExt_Imm : read_data2;
endmodule