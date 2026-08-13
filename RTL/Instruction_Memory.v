`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 26.04.2026 15:06:08
// Design Name: 
// Module Name: Instruction_Memory
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

/* Instruction Memory get the PC value which holds the instruction address needs to executed
 ,based on which insruction Memory gets the Instructions */
module Instruction_Memory(input [31:0] read_address, output [31:0] instruction);
// 1024 bytes instruction memory
reg [7:0] Memory [0:1023];  // memory is of size 1 byte (8 bit) with depth of 1024 registers
initial begin
$readmemh("program.mem", Memory);
end
// Little-endian instruction fetch
assign instruction = {
Memory[read_address + 3],
Memory[read_address + 2],
Memory[read_address + 1],
Memory[read_address]
    };

endmodule