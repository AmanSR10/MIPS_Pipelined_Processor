`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 26.04.2026 15:18:08
// Design Name: 
// Module Name: ALU
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


/* Based on the Control Signal (ALUControl) and Opcode of the instructions this ALU block 
will perform ALU Operations */

//ALUControl Comes From ALU Control Unit
module ALU(input [31:0] ALUin1, ALUin2,input [2:0]ALUControl,output reg [31:0]ALUResult,output Zero);
assign Zero = (ALUResult) ? 1'b0 : 1'b1; // it is used in beq instructions
always@(*)
begin
case(ALUControl)
3'b000:  ALUResult = ALUin1 & ALUin2; // AND
3'b001:  ALUResult = ALUin1 | ALUin2; // OR
3'b010:  ALUResult = ALUin1 + ALUin2; // ADD
3'b110:  ALUResult = ALUin1 - ALUin2; // SUB
3'b111:  ALUResult = ($signed(ALUin1) < $signed(ALUin2)) ? 32'b1 : 32'b0; //SLT
default: ALUResult = 32'b0;
endcase
end
endmodule
