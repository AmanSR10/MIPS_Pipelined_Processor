`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 26.04.2026 15:13:06
// Design Name: 
// Module Name: Register_file
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


/* Register File is mainly part of the Decode stage (for reading operands) and Write-Back stage (for writing results) */

module Register_file(input clk,reset,RegWrite,input [4:0]rs,rt,rd,input [31:0]write_data, output [31:0]read_data1,read_data2);
reg [31:0] register [31:0]; //32 registers of 32 bit

assign read_data1 = (rs == 5'b0) ? 32'b0 : register[rs];
assign read_data2 = (rt == 5'b0) ? 32'b0 : register[rt];
integer i;
always @(posedge clk or posedge reset)
begin
if(reset) 
for (i = 0; i < 32; i = i + 1)
register[i] <= 0;
else if (RegWrite && (rd != 5'b0)) // Prevent writing to Register 0 because register[0] = 0
register[rd] <= write_data;
end
endmodule
