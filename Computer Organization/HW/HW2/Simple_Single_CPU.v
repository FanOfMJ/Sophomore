//Subject:     CO project 2 - Simple Single CPU
//--------------------------------------------------------------------------------
//Version:     1
//--------------------------------------------------------------------------------
//Writer:      
//----------------------------------------------
//Date:        
//----------------------------------------------
//Description: 
//--------------------------------------------------------------------------------
module Simple_Single_CPU(
        	clk_i,
		rst_i
		);
		
//I/O port
input         clk_i;
input         rst_i;

//Internal Signles
wire [31:0]instruction;
wire [4:0]mux1_output;
wire [31:0]mux2_output;
wire [31:0]mux3_output;
wire [31:0]adder1_output;
wire [31:0]adder2_output;
wire [31:0]shift_left_output;
wire [31:0]sign_extend_output;
wire [2:0]ALUop;
wire [3:0]ALUctrl;
wire [31:0] RSdata;
wire [31:0] RTdata;
wire [31:0] ALU_result;
wire [31:0] pc_output;
wire RegDst, RegWrite, Branch, ALUSrc;
wire zero;

//Greate componentes
ProgramCounter PC(
        .clk_i(clk_i),      
	    .rst_i (rst_i),     
	    .pc_in_i(mux3_output) ,   
	    .pc_out_o(pc_output) 
	    );

Adder Adder1(
        .src1_i(32'd4),     
	    .src2_i(pc_output),     
	    .sum_o(adder1_output)    
	    );
	
Instr_Memory IM(
        .pc_addr_i(pc_output),  
	    .instr_o(instruction)    
	    );

MUX_2to1 #(.size(5)) Mux_Write_Reg(
        .data0_i(instruction[20:16]),
        .data1_i(instruction[15:11]),
        .select_i(RegDst),
        .data_o(mux1_output)
        );	
		
Reg_File RF(
        .clk_i(clk_i),      
	    .rst_i(rst_i) ,     
        .RSaddr_i(instruction[25:21]) ,  
        .RTaddr_i(instruction[20:16]) ,  
        .RDaddr_i(mux1_output) ,  
        .RDdata_i(ALU_result)  , 
        .RegWrite_i (RegWrite),
        .RSdata_o(RSdata) ,  
        .RTdata_o(RTdata)   
        );
	
Decoder Decoder(
        .instr_op_i(instruction[31:26]), 
	    .RegWrite_o(RegWrite), 
	    .ALU_op_o(ALUop),   
	    .ALUSrc_o(ALUSrc),   
	    .RegDst_o(RegDst),   
		.Branch_o(Branch)   
	    );

ALU_Ctrl AC(
        .funct_i(instruction[5:0]),   
        .ALUOp_i(ALUop),   
        .ALUCtrl_o(ALUctrl) 
        );
	
Sign_Extend SE(
        .data_i(instruction[15:0]),
        .data_o(sign_extend_output)
        );

MUX_2to1 #(.size(32)) Mux_ALUSrc(
        .data0_i(RTdata),
        .data1_i(sign_extend_output),
        .select_i(ALUSrc),
        .data_o(mux2_output)
        );	
		
ALU ALU(
        .src1_i(RSdata),
	    .src2_i(mux2_output),
	    .ctrl_i(ALUctrl),
	    .result_o(ALU_result),
		.zero_o(zero)
	    );
		
Adder Adder2(
        .src1_i(adder1_output),     
	    .src2_i(shift_left_output),     
	    .sum_o(adder2_output)      
	    );
		
Shift_Left_Two_32 Shifter(
        .data_i(sign_extend_output),
        .data_o(shift_left_output)
        ); 		
		
MUX_2to1 #(.size(32)) Mux_PC_Source(
        .data0_i(adder1_output),
        .data1_i(adder2_output),
        .select_i(zero & Branch),
        .data_o(mux3_output)
        );	

endmodule
		  



