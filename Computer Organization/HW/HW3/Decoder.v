//Subject:     CO project 2 - Decoder
//--------------------------------------------------------------------------------
//Version:     1
//--------------------------------------------------------------------------------
//Writer:      Luke
//----------------------------------------------
//Date:        2010/8/16
//----------------------------------------------
//Description: 
//--------------------------------------------------------------------------------

module Decoder(
    instr_op_i,
	RegWrite_o,
	ALU_op_o,
	ALUSrc_o,
	RegDst_o,
	Branch_o,
	Jump_o,
	MemRead_o,
	MemWrite_o,
	MemtoReg_o
	);
     
//I/O ports
input  [6-1:0] instr_op_i;

output         RegWrite_o;
output [3-1:0] ALU_op_o;
output         ALUSrc_o;
output [2-1:0] RegDst_o;
output         Branch_o;
output 		   Jump_o;
output [2-1:0] MemtoReg_o;
output		   MemWrite_o;
output		   MemRead_o;
 
//Internal Signals
reg            RegWrite_o;
reg    [3-1:0] ALU_op_o;
reg            ALUSrc_o;
reg    [2-1:0] RegDst_o;
reg            Branch_o;
reg    	       Jump_o;
reg	   [2-1:0] MemtoReg_o;
reg			   MemWrite_o;
reg		       MemRead_o;

//Parameter


//Main function
always@(*)
	begin
	//Main function
	
	case(instr_op_i)
		6'b000000: //R-format
			begin
			 RegWrite_o = 1'b1;
	         ALU_op_o = 3'b010; //2
	         ALUSrc_o = 1'b0;
			 RegDst_o = 2'b01;
			 Branch_o = 1'b0;
			 Jump_o   = 1'b1;
			 MemRead_o= 1'b0;
			 MemWrite_o=1'b0;
			 MemtoReg_o=2'b0;
			end
		6'b000100: //BEQ
			begin
			 RegWrite_o = 1'b0;
			 ALU_op_o = 3'b001; //1
	         ALUSrc_o = 1'b0;
	        //RegDst_o don't care
			 Branch_o = 1'b1;
			 Jump_o   = 1'b1;
			 MemRead_o= 1'b0;
			 MemWrite_o=1'b0;
			 MemtoReg_o=2'b0;			
			end
		6'b001000: //ADDI
			begin
			 RegWrite_o = 1'b1;
			 ALU_op_o = 3'b000; //0
	         ALUSrc_o = 1'b1;
	         RegDst_o = 2'b00;
			 Branch_o = 1'b0;
			 Jump_o   = 1'b1;
			 MemRead_o= 1'b0;
			 MemWrite_o=1'b0;
			 MemtoReg_o=2'b0;
			end
		6'b001010: //SLTI
			begin
			 RegWrite_o = 1'b1;
			 ALU_op_o = 3'b011; //3
	         ALUSrc_o = 1'b1;
	         RegDst_o = 2'b00;
			 Branch_o = 1'b0;
			 Jump_o   = 1'b1;
			 MemRead_o= 1'b0;
			 MemWrite_o=1'b0;
			 MemtoReg_o=2'b0;
			end
		6'b100011: //lw
			begin
			 RegWrite_o = 1'b1;
			 ALU_op_o = 3'b000; //0
			 ALUSrc_o = 1'b1;
			 RegDst_o = 2'b00;
			 Branch_o = 1'b0;
			 Jump_o   = 1'b1;
			 MemRead_o= 1'b1;
			 MemWrite_o=1'b0;
			 MemtoReg_o=2'b01;
			end
		6'b101011: //sw
			begin
			 RegWrite_o = 1'b0;
			 ALU_op_o = 3'b000; //0
			 ALUSrc_o = 1'b1;
			 RegDst_o = 2'b00;
			 Branch_o = 1'b0;
			 Jump_o   = 1'b1;
			 MemRead_o= 1'b0;
			 MemWrite_o=1'b1;
			//MemtoReg_o don't care
			end
		6'b000010: //jump
			begin
			 RegWrite_o = 1'b0;
			//ALU_op_o don't care
			//ALUSrc_o don't care
			//RegDst_o don't care
			 Branch_o = 1'b0;
			 Jump_o   = 1'b0;
			 MemRead_o= 1'b0;
			 MemWrite_o=1'b0;
			//MemtoReg_o don't care
			end
		6'b000011: //jal
			begin
			 RegWrite_o = 1'b1;
			 //ALU_op_o 
			 //ALUSrc_o = 1'b1;
			 RegDst_o = 2'b10;
			 Branch_o = 1'b0;
			 Jump_o   = 1'b0;
			 MemRead_o= 1'b1;
			 MemWrite_o=1'b0;
			 MemtoReg_o=2'b11;			
			end
		default:
			begin
			 RegWrite_o = 1'b0;
			 //ALU_op_o 
			 //ALUSrc_o 
			 //RegDst_o 
			 Branch_o = 1'b0;
			 Jump_o   = 1'b1;
			 MemRead_o= 1'b0;
			 MemWrite_o=1'b0;
			 //MemtoReg_o		
			end
	endcase
	$display("In decoder, instr_op_i=%p",instr_op_i);
	$display("ALU_op_o = %p, ALUSrc_o = %p, RegWrite_o = %p, RegDst_o = %p, Branch_o = %p", ALU_op_o, ALUSrc_o, RegWrite_o, RegDst_o, Branch_o);
	$display("Jump_o = %p, MemRead_o = %p, MemWrite_o = %p, MemtoReg_o = %p", Jump_o, MemRead_o, MemWrite_o, MemtoReg_o);
end

endmodule





                    
                    