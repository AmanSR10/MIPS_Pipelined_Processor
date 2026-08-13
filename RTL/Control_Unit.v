`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 26.04.2026 15:07:03
// Design Name: 
// Module Name: Control_Unit
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


/* This Module Will Generate Control Signal Based On the Opcode of the Instructions */ 
module Control_Unit(input [5:0]Opcode,output reg RegDst,Jump,Branch,MemRead,MemtoReg,MemWrite,ALUSrc,RegWrite,output reg [1:0]ALUOp);
always@(*) begin
case (Opcode)
6'b000000: begin          // R-type (add, sub, and, or, slt)
           RegDst  = 1'b1;
           Jump    = 1'b0;
           Branch  = 1'b0;
           MemRead = 1'b0;
           MemtoReg= 1'b0; 
           MemWrite= 1'b0;
           ALUSrc  = 1'b0;
           RegWrite= 1'b1;
           ALUOp   = 2'b10;
           end
//23hex 
6'b100011: begin          //lw (Load Word)
           RegDst  = 1'b0;
           Jump    = 1'b0;
           Branch  = 1'b0;
           MemRead = 1'b1;
           MemtoReg= 1'b1; 
           MemWrite= 1'b0;
           ALUSrc  = 1'b1;
           RegWrite= 1'b1;
           ALUOp   = 2'b00;
           end
//2bhex
6'b101011: begin          //sw (Store Word)
           RegDst  = 1'b0; //dont'care
           Jump    = 1'b0;
           Branch  = 1'b0;
           MemRead = 1'b0;
           MemtoReg= 1'b0; //dont'care
           MemWrite= 1'b1;
           ALUSrc  = 1'b1;
           RegWrite= 1'b0;
           ALUOp   = 2'b00;
           end
//4hex
6'b000100: begin          //beq (Branch on Equal)
           RegDst  = 1'b0; //dont'care
           Jump    = 1'b0;
           Branch  = 1'b1;
           MemRead = 1'b0;
           MemtoReg= 1'b0; //dont'care
           MemWrite= 1'b0;
           ALUSrc  = 1'b0;
           RegWrite= 1'b0;
           ALUOp   = 2'b01;
           end 
//2hex
6'b000010: begin          //j (Jump)
           RegDst  = 1'b0; //dont'care
           Jump    = 1'b1;
           Branch  = 1'b0;
           MemRead = 1'b0;
           MemtoReg= 1'b0; //dont'care
           MemWrite= 1'b0;
           ALUSrc  = 1'b0;//dont'care
           RegWrite= 1'b0;
           ALUOp   = 2'b00;//dont'care
           end 
           
6'b001000: begin          // addi
           RegDst  = 1'b0;
           Jump    = 1'b0;
           Branch  = 1'b0;
           MemRead = 1'b0;
           MemtoReg= 1'b0;
           MemWrite= 1'b0;
           ALUSrc  = 1'b1;
           RegWrite= 1'b1;
           ALUOp   = 2'b00; // ADD
           end
                         
default: begin  // Default State
         RegDst   = 1'b0;
         Jump     = 1'b0;
         Branch   = 1'b0;
         MemRead  = 1'b0;
         MemtoReg = 1'b0; 
         MemWrite = 1'b0;
         ALUSrc   = 1'b0;
         RegWrite = 1'b0; 
         ALUOp    = 2'b00;
end 
endcase
end                                     
endmodule
