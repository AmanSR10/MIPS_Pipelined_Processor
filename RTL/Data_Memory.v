`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 26.04.2026 15:19:09
// Design Name: 
// Module Name: Data_Memory
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

//MemRead is Control Signal for data Read 
//MemWrite is Control Signal for data Write
//Address Comes From ALU Result
//Write_data is the data from read_data2 of register file during Store instruction
//Read_data Goes to Register File during LOAD instruction
/* This Module is used to Load/Store data value into register file */

module Data_Memory(input clk,input reset,input MemRead,input MemWrite,input [31:0] Address, 
input [31:0] Write_data,output [31:0] Read_data);
integer i;
reg [7:0] RAM [0:1023]; //memory is of size 8 bit with depth of 1023 registers

assign Read_data = (MemRead) ? {RAM[Address+3],RAM[Address+2],RAM[Address+1],RAM[Address]} : 32'b0;

always @(posedge clk or posedge reset)
begin
if(reset)
for(i=0;i<1024;i=i+1)
RAM[i] <= 8'd0;
else if(MemWrite)
begin
RAM[Address]   <= Write_data[7:0];
RAM[Address+1] <= Write_data[15:8];
RAM[Address+2] <= Write_data[23:16];
RAM[Address+3] <= Write_data[31:24];
end

end
endmodule