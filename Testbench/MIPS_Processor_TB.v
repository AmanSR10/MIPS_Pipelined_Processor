`timescale 1ns / 1ps

module tb_MIPS_Processor;

reg clk;
reg reset;

wire [31:0] PC;
wire [31:0] ALU_Result;
wire [31:0] Mem_Read_Data;
wire MemWrite;

//------------------------------------------------------------
// DUT
//------------------------------------------------------------
MIPS_Processor uut(
    .clk(clk),
    .reset(reset),
    .PC(PC),
    .ALU_Result(ALU_Result),
    .Mem_Read_Data(Mem_Read_Data),
    .MemWrite(MemWrite)
);

//------------------------------------------------------------
// Clock Generation (10ns period)
//------------------------------------------------------------
always #5 clk = ~clk;

integer i;

//------------------------------------------------------------
// Test Sequence
//------------------------------------------------------------
initial begin

    clk   = 0;
    reset = 1;

    //--------------------------------------------------------
    // Clear Data Memory
    // (Instruction Memory is loaded automatically from
    // program.mem using $readmemh)
    //--------------------------------------------------------
    for(i=0;i<1024;i=i+1)
        uut.data_memory_unit.RAM[i] = 8'd0;

    //--------------------------------------------------------
    // Hold reset for one clock cycle
    //--------------------------------------------------------
    #10;
    reset = 0;

    //--------------------------------------------------------
    // Run Simulation
    //--------------------------------------------------------
    #500;

    //--------------------------------------------------------
    // Final Register Values
    //--------------------------------------------------------
    $display("\n========================================");
    $display("        FINAL REGISTER VALUES");
    $display("========================================");

    $display("r1  = %0d", uut.register_unit.register[1]);
    $display("r2  = %0d", uut.register_unit.register[2]);
    $display("r3  = %0d", uut.register_unit.register[3]);
    $display("r4  = %0d", uut.register_unit.register[4]);
    $display("r5  = %0d", uut.register_unit.register[5]);
    $display("r6  = %0d", uut.register_unit.register[6]);
    $display("r7  = %0d", uut.register_unit.register[7]);
    $display("r8  = %0d", uut.register_unit.register[8]);
    $display("r11 = %0d", uut.register_unit.register[11]);

    //--------------------------------------------------------
    // Data Memory Contents
    //--------------------------------------------------------
    $display("\n========================================");
    $display("        DATA MEMORY");
    $display("========================================");

    // Word stored at Address 0
    $display("MEM[0] = %0d",
        {uut.data_memory_unit.RAM[3],
         uut.data_memory_unit.RAM[2],
         uut.data_memory_unit.RAM[1],
         uut.data_memory_unit.RAM[0]});

    // Word stored at Address 4
    $display("MEM[4] = %0d",
        {uut.data_memory_unit.RAM[7],
         uut.data_memory_unit.RAM[6],
         uut.data_memory_unit.RAM[5],
         uut.data_memory_unit.RAM[4]});

    $display("\nSimulation Finished Successfully.");

    $finish;

end

//------------------------------------------------------------
// Live Monitor
//------------------------------------------------------------
initial begin

$monitor("Time=%0t | PC=%0d | ALU=%0d | MemData=%0d | MemWrite=%b",
          $time,
          PC,
          ALU_Result,
          Mem_Read_Data,
          MemWrite);

end

//------------------------------------------------------------
// Register Trace
//------------------------------------------------------------
always @(posedge clk)
begin

$display("-----------------------------------------------");
$display("Time = %0t", $time);

$display("PC  = %0d", PC);

$display("r1  = %0d", uut.register_unit.register[1]);
$display("r2  = %0d", uut.register_unit.register[2]);
$display("r3  = %0d", uut.register_unit.register[3]);
$display("r4  = %0d", uut.register_unit.register[4]);
$display("r5  = %0d", uut.register_unit.register[5]);
$display("r6  = %0d", uut.register_unit.register[6]);
$display("r7  = %0d", uut.register_unit.register[7]);
$display("r8  = %0d", uut.register_unit.register[8]);
$display("r11 = %0d", uut.register_unit.register[11]);

end

endmodule