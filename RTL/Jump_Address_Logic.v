`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 26.04.2026 15:26:38
// Design Name: 
// Module Name: Jump_Address_Logic
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

/* This module will calculate jump Address */
/* Jump_Address = { [31:28](PC + 4) , 26Immediate , 2'b00 } */
module Jump_Address_Logic(input [25:0]instruction,input [31:0]PC_Plus4,output [31:0]Jump_address);
assign Jump_address = {PC_Plus4[31:28],instruction,2'b00};
endmodule