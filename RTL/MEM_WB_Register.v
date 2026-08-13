`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 26.04.2026 14:14:58
// Design Name: 
// Module Name: MEM_WB_Register
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


module MEM_WB_Register(
    input clk, reset,

    input [31:0] ReadData_in,
    input [31:0] ALUResult_in,
    input [4:0] WriteReg_in,

    input MemtoReg_in,
    input RegWrite_in,

    output reg [31:0] ReadData_out,
    output reg [31:0] ALUResult_out,
    output reg [4:0] WriteReg_out,

    output reg MemtoReg_out,
    output reg RegWrite_out
);

always @(posedge clk or posedge reset)
begin
    if(reset) begin
        ReadData_out <= 0;
        ALUResult_out <= 0;
        WriteReg_out <= 0;
        MemtoReg_out <= 0;
        RegWrite_out <= 0;
    end
    else begin
        ReadData_out <= ReadData_in;
        ALUResult_out <= ALUResult_in;
        WriteReg_out <= WriteReg_in;
        MemtoReg_out <= MemtoReg_in;
        RegWrite_out <= RegWrite_in;
    end
end

endmodule
