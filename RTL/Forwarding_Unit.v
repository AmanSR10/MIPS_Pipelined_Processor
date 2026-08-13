`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 26.04.2026 16:35:01
// Design Name: 
// Module Name: Forwarding_Unit
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


module Forwarding_Unit(
    input [4:0] rs_EX, rt_EX,
    input [4:0] rd_MEM, rd_WB,
    input RegWrite_MEM, RegWrite_WB,

    output reg [1:0] ForwardA,
    output reg [1:0] ForwardB
);

always @(*) begin
    // default
    ForwardA = 2'b00;
    ForwardB = 2'b00;

    // EX hazard (MEM stage)
    if (RegWrite_MEM && (rd_MEM != 0) && (rd_MEM == rs_EX))
        ForwardA = 2'b10;

    if (RegWrite_MEM && (rd_MEM != 0) && (rd_MEM == rt_EX))
        ForwardB = 2'b10;

    // MEM hazard (WB stage)
    if (RegWrite_WB && (rd_WB != 0) &&
        !(RegWrite_MEM && (rd_MEM != 0) && (rd_MEM == rs_EX)) &&
        (rd_WB == rs_EX))
        ForwardA = 2'b01;

    if (RegWrite_WB && (rd_WB != 0) &&
        !(RegWrite_MEM && (rd_MEM != 0) && (rd_MEM == rt_EX)) &&
        (rd_WB == rt_EX))
        ForwardB = 2'b01;
end

endmodule
