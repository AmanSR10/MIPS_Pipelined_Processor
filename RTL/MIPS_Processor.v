`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 28.03.2026 01:27:18
// Design Name: 
// Module Name: Main_Module
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

module MIPS_Processor(
input clk,
input reset,
output [31:0]PC,                 
output [31:0]ALU_Result,         
output [31:0]Mem_Read_Data,      
output       MemWrite           
);

//Program Counter Wire
wire [31:0]pc_next;
wire [31:0]pc_current; 

//Pc Adder Wire          
wire [31:0]PC_IF;

//Instruction Memory Wire
wire [31:0]instruction_IF;

// IF/ID wires
wire [31:0]instruction_ID;
wire [31:0]PC_ID;

// FLUSH SIGNAL
wire flush;

//====================
// STALL SIGNALS
//====================
wire PCWrite;
wire IF_ID_Write;
wire ControlMuxSel;

//Control Unit wire
wire reg_dst, jump, branch, mem_read, mem_to_reg, mem_write, alu_src, reg_write;
wire [1:0] alu_op;

// AFTER CONTROL MUX
wire reg_dst_c, alu_src_c, reg_write_c, mem_read_c, mem_write_c, mem_to_reg_c, branch_c;
wire [1:0] alu_op_c;

//Register File Wire
wire [31:0]read_data1;
wire [31:0]read_data2;
wire [31:0]write_data;          

//Sign Extend Wire
wire [31:0]sign_ext_imm;


// ID/EX Pipeline wires

wire [31:0] read_data1_EX;
wire [31:0] read_data2_EX;
wire [31:0] sign_ext_imm_EX;
wire [31:0] PC_EX;

wire [4:0] rs_EX, rt_EX, rd_EX;
wire [5:0] funct_EX;

wire RegDst_EX;
wire ALUSrc_EX;
wire [1:0] ALUOp_EX;

wire MemRead_EX;
wire MemWrite_EX;
wire MemtoReg_EX;
wire RegWrite_EX;
wire Branch_EX;

//====================
// FORWARDING SIGNALS
//====================
wire [1:0] ForwardA, ForwardB;
wire [31:0] ALU_in1_final;
wire [31:0] forwardB_data;

// 🔥 NEW (store forwarding fix)
wire [31:0] StoreData_final;

//ALUSrc Mux Wire
wire [31:0]alu_in2;

//ALU Control Wire
wire [2:0]alu_control;

//ALU Wire
wire [31:0] alu_out;
wire zero;

//====================
// EX/MEM Pipeline wires
//====================
wire [31:0] ALU_MEM;
wire [31:0] WriteData_MEM;
wire [4:0] WriteReg_MEM;

wire MemRead_MEM;
wire MemWrite_MEM;
wire MemtoReg_MEM;
wire RegWrite_MEM;

//====================
// MEM/WB Pipeline wires
//====================
wire [31:0] ReadData_WB;
wire [31:0] ALU_WB;
wire [4:0] WriteReg_WB;

wire MemtoReg_WB;
wire RegWrite_WB;

//Data Memory Wire
wire [31:0] mem_read_data;

//Jump Address Logic Wire
wire [31:0]jump_address;

//Shift Left 2 Branch Wire
wire [31:0] branch_offset;

//Branch Addder Wire
wire [31:0] branch_address;

//Branch And Gate Wire
wire BrTaken;

//Branch Mux Wire
wire [31:0] pc_branch_out;

assign PC = pc_current;
assign ALU_Result = alu_out;
assign Mem_Read_Data = mem_read_data;
assign MemWrite = MemWrite_MEM;

// FLUSH LOGIC
assign flush = Branch_EX & zero;

//====================
// PC (UPDATED)
//====================
PC pc_unit(
.clk(clk),
.rst(reset),
.PCWrite(PCWrite),
.PCin(pc_next),
.PCout(pc_current)
);

//Pc Adder
PC_Adder pc_adder_unit(
.old_PC(pc_current),
.new_PC(PC_IF)
);

//Instruction Memory
Instruction_Memory instr_mem_unit(
.read_address(pc_current),
.instruction(instruction_IF)
);

// IF/ID Register
IF_ID_Register if_id(
.clk(clk),
.reset(reset),
.IF_ID_Write(IF_ID_Write),
.flush(flush),
.PC_in(PC_IF),
.instruction_in(instruction_IF),
.PC_out(PC_ID),
.instruction_out(instruction_ID)
);

// Stall Unit
Stall_Unit stall_unit(
.MemRead_EX(MemRead_EX),
.rt_EX(rt_EX),
.rs_ID(instruction_ID[25:21]),
.rt_ID(instruction_ID[20:16]),
.PCWrite(PCWrite),
.IF_ID_Write(IF_ID_Write),
.Control_Zero(ControlMuxSel)
);

//Control Unit
Control_Unit control_unit(
.Opcode(instruction_ID[31:26]),
.RegDst(reg_dst),
.Jump(jump),
.Branch(branch),
.MemRead(mem_read),
.MemtoReg(mem_to_reg),
.MemWrite(mem_write),
.ALUSrc(alu_src),
.RegWrite(reg_write),
.ALUOp(alu_op)
);

// CONTROL MUX
assign reg_dst_c   = ControlMuxSel ? 0 : reg_dst;
assign alu_src_c   = ControlMuxSel ? 0 : alu_src;
assign reg_write_c = ControlMuxSel ? 0 : reg_write;
assign mem_read_c  = ControlMuxSel ? 0 : mem_read;
assign mem_write_c = ControlMuxSel ? 0 : mem_write;
assign mem_to_reg_c= ControlMuxSel ? 0 : mem_to_reg;
assign branch_c    = ControlMuxSel ? 0 : branch;
assign alu_op_c    = ControlMuxSel ? 2'b00 : alu_op;

//Register File
Register_file register_unit(
.clk(clk),
.reset(reset),
.RegWrite(RegWrite_WB),
.rs(instruction_ID[25:21]),
.rt(instruction_ID[20:16]),
.rd(WriteReg_WB),
.write_data(write_data),
.read_data1(read_data1),
.read_data2(read_data2)
);

//Sign Extend
Sign_Extend sign_extend_unit(
.in(instruction_ID[15:0]),
.out(sign_ext_imm)                    
);

// ID/EX Register
ID_EX_Register id_ex(
.clk(clk),
.reset(reset),
.PC_in(PC_ID),
.read_data1_in(read_data1),
.read_data2_in(read_data2),
.sign_ext_imm_in(sign_ext_imm),
.rs_in(instruction_ID[25:21]),
.rt_in(instruction_ID[20:16]),
.rd_in(instruction_ID[15:11]),
.funct_in(instruction_ID[5:0]),
.RegDst_in(reg_dst_c),
.ALUSrc_in(alu_src_c),
.ALUOp_in(alu_op_c),
.MemRead_in(mem_read_c),
.MemWrite_in(mem_write_c),
.MemtoReg_in(mem_to_reg_c),
.RegWrite_in(reg_write_c),
.Branch_in(branch_c),
.PC_out(PC_EX),
.read_data1_out(read_data1_EX),
.read_data2_out(read_data2_EX),
.sign_ext_imm_out(sign_ext_imm_EX),
.rs_out(rs_EX),
.rt_out(rt_EX),
.rd_out(rd_EX),
.funct_out(funct_EX),
.RegDst_out(RegDst_EX),
.ALUSrc_out(ALUSrc_EX),
.ALUOp_out(ALUOp_EX),
.MemRead_out(MemRead_EX),
.MemWrite_out(MemWrite_EX),
.MemtoReg_out(MemtoReg_EX),
.RegWrite_out(RegWrite_EX),
.Branch_out(Branch_EX)
);

// Forwarding Unit
Forwarding_Unit fwd_unit(
.rs_EX(rs_EX),
.rt_EX(rt_EX),
.rd_MEM(WriteReg_MEM),
.rd_WB(WriteReg_WB),
.RegWrite_MEM(RegWrite_MEM),
.RegWrite_WB(RegWrite_WB),
.ForwardA(ForwardA),
.ForwardB(ForwardB)
);

// Forwarding MUX
assign ALU_in1_final =
    (ForwardA == 2'b00) ? read_data1_EX :
    (ForwardA == 2'b10) ? ALU_MEM :
    (ForwardA == 2'b01) ? write_data :
    read_data1_EX;

assign forwardB_data =
    (ForwardB == 2'b00) ? read_data2_EX :
    (ForwardB == 2'b10) ? ALU_MEM :
    (ForwardB == 2'b01) ? write_data :
    read_data2_EX;

// 🔥 STORE FORWARDING FIX
assign StoreData_final = forwardB_data;
// EX stage
wire [4:0] WriteReg_EX;
assign WriteReg_EX = (RegDst_EX) ? rd_EX : rt_EX;

ALUSrc_Mux alusrc_mux_unit(
.ALUSrc(ALUSrc_EX),
.read_data2(forwardB_data),
.SignExt_Imm(sign_ext_imm_EX),
.ALUin2(alu_in2)
);

ALUControl_Unit alu_control_unit(
.ALUOp(ALUOp_EX),
.funct(funct_EX),
.ALUControl(alu_control)
);

ALU alu_unit(
.ALUin1(ALU_in1_final),
.ALUin2(alu_in2),
.ALUControl(alu_control),
.ALUResult(alu_out),
.Zero(zero)
);

// EX/MEM Register
EX_MEM_Register ex_mem(
.clk(clk),
.reset(reset),
.ALUResult_in(alu_out),
.WriteData_in(StoreData_final),   // 🔥 FIXED
.WriteReg_in(WriteReg_EX),
.MemRead_in(MemRead_EX),
.MemWrite_in(MemWrite_EX),
.MemtoReg_in(MemtoReg_EX),
.RegWrite_in(RegWrite_EX),
.ALUResult_out(ALU_MEM),
.WriteData_out(WriteData_MEM),
.WriteReg_out(WriteReg_MEM),
.MemRead_out(MemRead_MEM),
.MemWrite_out(MemWrite_MEM),
.MemtoReg_out(MemtoReg_MEM),
.RegWrite_out(RegWrite_MEM)
);

// Data Memory
Data_Memory data_memory_unit(
.clk(clk),
.reset(reset),
.MemRead(MemRead_MEM),
.MemWrite(MemWrite_MEM),
.Address(ALU_MEM),
.Write_data(WriteData_MEM),
.Read_data(mem_read_data)
);

// MEM/WB Register
MEM_WB_Register mem_wb(
.clk(clk),
.reset(reset),
.ReadData_in(mem_read_data),
.ALUResult_in(ALU_MEM),
.WriteReg_in(WriteReg_MEM),
.MemtoReg_in(MemtoReg_MEM),
.RegWrite_in(RegWrite_MEM),
.ReadData_out(ReadData_WB),
.ALUResult_out(ALU_WB),
.WriteReg_out(WriteReg_WB),
.MemtoReg_out(MemtoReg_WB),
.RegWrite_out(RegWrite_WB)
);

// MemtoReg Mux
MemtoReg_Mux mem_to_reg_unit(
.Read_data(ReadData_WB),
.ALU_Result(ALU_WB),
.MemtoReg(MemtoReg_WB),
.Write_data(write_data)
);

// Branch Logic
Shift_left_2_branch shiftleftby2_unit(
.in(sign_ext_imm_EX),
.out(branch_offset)
);

Branch_Adder branch_adder_unit(
.a(PC_EX),
.b(branch_offset),
.sum(branch_address)
);

Branch_AND_Gate and_unit(
.Branch(Branch_EX),
.Zero(zero),
.BrTaken(BrTaken)
);

Branch_Mux branch_mux_unit(
.PC_Plus(PC_EX),
.Branch_Target(branch_address),
.BrTaken(BrTaken),
.next_PC(pc_branch_out)
);

// Jump
Jump_Address_Logic jump_logic_unit(
.instruction(instruction_ID[25:0]),
.PC_Plus4(PC_ID),
.Jump_address(jump_address)
);

Jump_Mux jump_mux_unit(
.Branch_Mux_Out(pc_branch_out),
.Jump_Address(jump_address),
.Jump(jump),
.next_PC(pc_next)
);

endmodule