`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 26.04.2026 13:48:23
// Design Name: 
// Module Name: ID_EX_Register
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

module ID_EX_Register(
    input clk, reset,

    // DATA SIGNALS
    input [31:0] PC_in,
    input [31:0] read_data1_in,
    input [31:0] read_data2_in,
    input [31:0] sign_ext_imm_in,
    input [4:0] rs_in, rt_in, rd_in,
    input [5:0] funct_in,   // <-- ADD THIS

    // CONTROL SIGNALS
    input RegDst_in,
    input ALUSrc_in,
    input [1:0] ALUOp_in,

    input MemRead_in,
    input MemWrite_in,
    input MemtoReg_in,
    input RegWrite_in,
    input Branch_in,

    // OUTPUTS
    output reg [31:0] PC_out,
    output reg [31:0] read_data1_out,
    output reg [31:0] read_data2_out,
    output reg [31:0] sign_ext_imm_out,
    output reg [4:0] rs_out, rt_out, rd_out,
    output reg [5:0] funct_out,  // <-- ADD THIS

    output reg RegDst_out,
    output reg ALUSrc_out,
    output reg [1:0] ALUOp_out,

    output reg MemRead_out,
    output reg MemWrite_out,
    output reg MemtoReg_out,
    output reg RegWrite_out,
    output reg Branch_out
);

always @(posedge clk or posedge reset)
begin
    if(reset) begin
        PC_out <= 0;
        read_data1_out <= 0;
        read_data2_out <= 0;
        sign_ext_imm_out <= 0;
        rs_out <= 0;
        rt_out <= 0;
        rd_out <= 0;
        funct_out <= 0;

        RegDst_out <= 0;
        ALUSrc_out <= 0;
        ALUOp_out <= 0;

        MemRead_out <= 0;
        MemWrite_out <= 0;
        MemtoReg_out <= 0;
        RegWrite_out <= 0;
        Branch_out <= 0;
    end
    else begin
        PC_out <= PC_in;
        read_data1_out <= read_data1_in;
        read_data2_out <= read_data2_in;
        sign_ext_imm_out <= sign_ext_imm_in;
        rs_out <= rs_in;
        rt_out <= rt_in;
        rd_out <= rd_in;
        funct_out <= funct_in;

        RegDst_out <= RegDst_in;
        ALUSrc_out <= ALUSrc_in;
        ALUOp_out <= ALUOp_in;

        MemRead_out <= MemRead_in;
        MemWrite_out <= MemWrite_in;
        MemtoReg_out <= MemtoReg_in;
        RegWrite_out <= RegWrite_in;
        Branch_out <= Branch_in;
    end
end

endmodule
