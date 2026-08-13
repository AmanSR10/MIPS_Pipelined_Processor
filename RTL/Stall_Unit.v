`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 26.04.2026 16:43:54
// Design Name: 
// Module Name: Stall_Unit
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


module Stall_Unit(
    input MemRead_EX,
    input [4:0] rt_EX,
    input [4:0] rs_ID,
    input [4:0] rt_ID,

    output reg PCWrite,
    output reg IF_ID_Write,
    output reg Control_Zero
);

always @(*) begin
    if (MemRead_EX && ((rt_EX == rs_ID) || (rt_EX == rt_ID))) begin
        PCWrite     = 0; // stall PC
        IF_ID_Write = 0; // stall IF/ID
        Control_Zero= 1; // insert bubble
    end
    else begin
        PCWrite     = 1;
        IF_ID_Write = 1;
        Control_Zero= 0;
    end
end

endmodule