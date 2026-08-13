`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 26.04.2026 14:05:45
// Design Name: 
// Module Name: EX_MEM_Register
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

module EX_MEM_Register(
    input clk, reset,

    // DATA
    input [31:0] ALUResult_in,
    input [31:0] WriteData_in,
    input [4:0] WriteReg_in,

    // CONTROL
    input MemRead_in,
    input MemWrite_in,
    input MemtoReg_in,
    input RegWrite_in,

    // OUTPUTS
    output reg [31:0] ALUResult_out,
    output reg [31:0] WriteData_out,
    output reg [4:0] WriteReg_out,

    output reg MemRead_out,
    output reg MemWrite_out,
    output reg MemtoReg_out,
    output reg RegWrite_out
);

always @(posedge clk or posedge reset)
begin
    if(reset) begin
        ALUResult_out <= 0;
        WriteData_out <= 0;
        WriteReg_out <= 0;

        MemRead_out <= 0;
        MemWrite_out <= 0;
        MemtoReg_out <= 0;
        RegWrite_out <= 0;
    end
    else begin
        ALUResult_out <= ALUResult_in;
        WriteData_out <= WriteData_in;
        WriteReg_out <= WriteReg_in;

        MemRead_out <= MemRead_in;
        MemWrite_out <= MemWrite_in;
        MemtoReg_out <= MemtoReg_in;
        RegWrite_out <= RegWrite_in;
    end
end

endmodule
