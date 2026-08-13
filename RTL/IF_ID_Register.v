`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 26.04.2026 13:35:23
// Design Name: 
// Module Name: IF_ID_Register
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
module IF_ID_Register(
    input clk, reset,
    input IF_ID_Write,     // stall control
    input flush,           // branch flush

    input [31:0] PC_in,
    input [31:0] instruction_in,

    output reg [31:0] PC_out,
    output reg [31:0] instruction_out
);

always @(posedge clk or posedge reset)
begin
    if(reset) begin
        PC_out <= 0;
        instruction_out <= 0;
    end

    // FLUSH (branch taken → insert bubble)
    else if (flush) begin
        PC_out <= 0;
        instruction_out <= 0;
    end

    // STALL (hold previous value)
    else if (!IF_ID_Write) begin
        PC_out <= PC_out;
        instruction_out <= instruction_out;
    end

    // NORMAL
    else begin
        PC_out <= PC_in;
        instruction_out <= instruction_in;
    end
end

endmodule