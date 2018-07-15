`timescale 1ns / 1ps
//Subject:     CO project 4 - Pipe CPU 1
//--------------------------------------------------------------------------------
module Pipe_CPU_1(
    clk_i,
    rst_i
    );
/****************************************
I/O ports
****************************************/
input clk_i;
input rst_i;
//parameter
//pc
wire [31:0]pc_output;

//adder 1
wire [31:0]adder1_output_IF;
wire [31:0]adder1_output_ID;
wire [31:0]adder1_output_EX;

//adder 2
wire [31:0]adder2_output_EX;
wire [31:0]adder2_output_Mem;

//mux
wire [31:0]mux0_output;
wire [31:0]mux1_output;
wire [4:0]mux2_output_EX;
wire [4:0]mux2_output_Mem;
wire [4:0]mux2_output_WB;
wire [31:0]mux3_output;

//instruction
wire [31:0]instruction_IF;
wire [31:0]instruction_ID;

//RD
//wire [4:0]RDaddr_ID = instruction_ID[20:16];
wire [4:0]RDaddr_EX;

//RS
wire [31:0]RSdata_ID;
wire [31:0]RSdata_EX;

//RT
//wire [4:0]RTaddr_ID = instruction_ID[15:11];  
wire [4:0]RTaddr_EX;

wire [31:0]RTdata_ID;
wire [31:0]RTdata_EX;
wire [31:0]RTdata_Mem;

//sign_extend
wire [31:0]sign_extend_output_ID;
wire [31:0]sign_extend_output_EX;

//sign_shift
wire [31:0]sign_shift_output;

wire RegWrite_ID, Branch_ID, MemRead_ID, MemWrite_ID, ALU_Src_ID, MemToReg_ID, RegDst_ID;
wire RegWrite_EX, Branch_EX, MemRead_EX, MemWrite_EX, ALU_Src_EX, MemToReg_EX, RegDst_EX;
wire RegWrite_Mem, Branch_Mem, MemRead_Mem, MemWrite_Mem, MemToReg_Mem;
wire RegWrite_WB,MemToReg_WB;
wire [2:0]ALU_op_ID;
wire [2:0]ALU_op_EX;

wire [3:0]ALU_op_output;
wire zero_EX, zero_Mem;
wire [31:0]ALU_output_EX;
wire [31:0]ALU_output_Mem;
wire [31:0]ALU_output_WB;

//data memeory
wire [31:0]data_memory_o_Mem;
wire [31:0]data_memory_o_WB;

wire Mux_bch;
//******************************************************************************************//
//Level 1
MUX_2to1 #(.size(32)) Mux0(
	.data0_i(adder1_output_IF),
        .data1_i(adder2_output_Mem),
        .select_i(zero_Mem&Branch_Mem&instruction_IF[28]),
        .data_o(mux0_output)
);

ProgramCounter PC(
        .clk_i(clk_i),      
	.rst_i (rst_i),     
	.pc_in_i(mux0_output),   
	.pc_out_o(pc_output)
);

Instruction_Memory IM(
	.addr_i(pc_output),  
	.instr_o(instruction_IF)
);
			
Adder Add_pc(
	.src1_i(32'd4),     
	.src2_i(pc_output),     
	.sum_o(adder1_output_IF) 

);
	
//Level 2
Pipe_Reg #(.size(64)) IF_ID(       //N is the total length of input/output
	.clk_i(clk_i),
    	.rst_i(rst_i),
    	.data_i({adder1_output_IF, instruction_IF}),
    	.data_o({adder1_output_ID, instruction_ID})
);

//Instantiate the components in ID stage
Decoder Control( 
	.instr_op_i(instruction_ID[31:26]),
	.funtion_field_i(instruction_ID[5:0]),
	.RegWrite_o(RegWrite_ID),
	.ALU_op_o(ALU_op_ID),
	.ALUSrc_o(ALU_Src_ID),
	.RegDst_o(RegDst_ID),
	.Branch_o(Branch_ID),
	.MemRead_o(MemRead_ID),
	.MemWrite_o(MemWrite_ID),
	.MemtoReg_o(MemToReg_ID)
);

Reg_File RF(
	.clk_i(clk_i),      
	.rst_i(rst_i) ,     
        .RSaddr_i(instruction_ID[25:21]) ,  
        .RTaddr_i(instruction_ID[20:16]) ,  
        .RDaddr_i(mux2_output_WB) ,  
        .RDdata_i(mux3_output)  , 
        .RegWrite_i(RegWrite_WB),
        .RSdata_o(RSdata_ID) ,  
        .RTdata_o(RTdata_ID)   
);

Sign_Extend #(.size(16)) Sign_Extend(
	.data_i(instruction_ID[15:0]),
        .data_o(sign_extend_output_ID)
);	

Pipe_Reg #(.size(148)) ID_EX(
	.clk_i(clk_i),
    	.rst_i(rst_i),
    	.data_i({MemToReg_ID, RegWrite_ID, 
					Branch_ID, MemRead_ID, MemWrite_ID,
					RegDst_ID, ALU_op_ID, ALU_Src_ID,
					adder1_output_ID, 
					RSdata_ID, RTdata_ID, 
					sign_extend_output_ID, 
					instruction_ID[20:16], instruction_ID[15:11]}),
    	.data_o({MemToReg_EX, RegWrite_EX, 
					Branch_EX, MemRead_EX, MemWrite_EX, 
					RegDst_EX, ALU_op_EX, ALU_Src_EX, 
					adder1_output_EX,
					RSdata_EX, RTdata_EX, 
					sign_extend_output_EX, 
					RDaddr_EX, RTaddr_EX})
);

//Level 3
//Instantiate the components in EX stage	   
Shift_Left_Two_32 #(.size(32)) Shifter(
	.data_i(sign_extend_output_EX),
    	.data_o(sign_shift_output)
);

MUX_2to1 #(.size(32)) Mux1(
	.data0_i(RTdata_EX),
        .data1_i(sign_extend_output_EX),
        .select_i(ALU_Src_EX),
        .data_o(mux1_output)
);
		
ALU_Ctrl ALU_Ctrl(
	.funct_i(sign_extend_output_EX[5:0]),
        .ALUOp_i(ALU_op_EX),
        .ALUCtrl_o(ALU_op_output)
);

ALU ALU(
	.src1_i(RSdata_EX),
	.src2_i(mux1_output),
	.ctrl_i(ALU_op_output),
	.result_o(ALU_output_EX),
	.zero_o(zero_EX)
);
		
MUX_2to1 #(.size(5)) Mux2(
	.data0_i(RDaddr_EX),
        .data1_i(RTaddr_EX),
        .select_i(RegDst_EX),
        .data_o(mux2_output_EX)
);

Adder Add_pc_branch(
 	.src1_i(adder1_output_EX),
	.src2_i(sign_shift_output),
	.sum_o(adder2_output_EX)  
);



Pipe_Reg #(.size(107)) EX_MEM(
	.clk_i(clk_i),
    	.rst_i(rst_i),
    	.data_i({RegWrite_EX,MemToReg_EX, 
					Branch_EX,MemRead_EX,MemWrite_EX,
					adder2_output_EX,
					zero_EX,ALU_output_EX,
					RTdata_EX,
					mux2_output_EX}),
    	.data_o({RegWrite_Mem,MemToReg_Mem,
					Branch_Mem,MemRead_Mem,MemWrite_Mem,
					adder2_output_Mem,
					zero_Mem,ALU_output_Mem,
					RTdata_Mem,
					mux2_output_Mem})
);

//Level 4
//Instantiate the components in MEM stage

Data_Memory DM(
	.clk_i(clk_i),
    	.addr_i(ALU_output_Mem),
    	.data_i(RTdata_Mem),
    	.MemRead_i(MemRead_Mem),
    	.MemWrite_i(MemWrite_Mem),
    	.data_o(data_memory_o_Mem)
);

Pipe_Reg #(.size(71)) MEM_WB(
	.clk_i(clk_i),
    	.rst_i(rst_i),
    	.data_i({RegWrite_Mem,MemToReg_Mem,
					data_memory_o_Mem,ALU_output_Mem,
					mux2_output_Mem}),
    	.data_o({RegWrite_WB,MemToReg_WB,
					data_memory_o_WB,ALU_output_WB,
					mux2_output_WB})
);

//Instantiate the components in WB stage
MUX_2to1 #(.size(32)) Mux3(
	.data0_i(data_memory_o_WB),
        .data1_i(ALU_output_WB),
        .select_i(MemToReg_WB),
        .data_o(mux3_output)
);
endmodule