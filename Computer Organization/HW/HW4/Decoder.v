
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
	funtion_field_i,
	RegWrite_o,
	ALU_op_o,
	ALUSrc_o,
	RegDst_o,
	Branch_o,
	//Jump_o,
	MemRead_o,
	MemWrite_o,
	MemtoReg_o
	);
     
//I/O ports
input  [6-1:0] instr_op_i;
input  [6-1:0] funtion_field_i;
output         RegWrite_o;
output [3-1:0] ALU_op_o;
output         ALUSrc_o;
output         RegDst_o;
output         Branch_o;
//output 		   Jump_o;
output  	   MemtoReg_o;
output		   MemWrite_o;
output		   MemRead_o;
 
//Internal Signals
reg            RegWrite_o;
reg    [3-1:0] ALU_op_o;
reg            ALUSrc_o;
reg            RegDst_o;
reg            Branch_o;
//reg    	       Jump_o;
reg	   		   MemtoReg_o;
reg			   MemWrite_o;
reg		       MemRead_o;

//Parameter


//Main function
always@(*)
	begin
	//Main function
	assign MemtoReg_o=(!instr_op_i[0]);
	
	case(instr_op_i)
		6'b000000: //R-format
			begin
			if (funtion_field_i>6'd30 || funtion_field_i==6'd8)
			begin
				assign ALU_op_o= 3'b010;
				assign ALUSrc_o= 1'b0;
				assign RegWrite_o= 1'b1;
				assign RegDst_o= 1'b1;
				assign Branch_o= 1'b0;
				 //assign Jump_o   = 1'b1;
				assign MemRead_o=1'b0;
				assign MemWrite_o=1'b0;
				//MemtoReg_o=1'b1;
			end
			end
		6'b000100: //BEQ
			begin
			assign ALU_op_o = 3'b001;
	        assign ALUSrc_o = 1'b0;
	        assign RegWrite_o = 1'b0;
			//RegDst_o don't care
			assign Branch_o = 1'b1;
			 //Jump_o   = 1'b1;
			assign MemRead_o= 1'b0;
			assign MemWrite_o=1'b0;
			 //MemtoReg_o=1'b1;			
			end
		6'b001000: //ADDI
			begin
			assign ALU_op_o = 3'b000;
	        assign ALUSrc_o = 1'b1;
	        assign RegWrite_o = 1'b1;
			assign RegDst_o = 1'b0;
			assign Branch_o = 1'b0;
			 //Jump_o   = 1'b1;
			assign MemRead_o= 1'b0;
			assign MemWrite_o=1'b0;
			//assign MemtoReg_o=1'b1;
			end
		6'b001010: //SLTI
			begin
			assign ALU_op_o = 3'b011;
	        assign ALUSrc_o = 1'b1;
	        assign RegWrite_o = 1'b1;
			assign RegDst_o = 1'b0;
			assign Branch_o = 1'b0;
			 //Jump_o   = 1'b1;
			assign MemRead_o= 1'b0;
			assign MemWrite_o=1'b0;
			//assign MemtoReg_o=1'b1;
			end
		6'b100011: //lw
			begin
			assign RegWrite_o = 1'b1;
			assign ALU_op_o = 3'b000; //0
			assign ALUSrc_o = 1'b1;
			assign RegDst_o = 1'b0;
			assign Branch_o = 1'b0;
			 //Jump_o   = 1'b1;
			assign MemRead_o= 1'b1;
			assign MemWrite_o=1'b0;
			//assign MemtoReg_o=1'b0;
			end
		6'b101011: //sw
			begin
			assign RegWrite_o = 1'b0;
			assign ALU_op_o = 3'b000; //0
			assign ALUSrc_o = 1'b1;
			assign RegDst_o = 1'b0;
			assign Branch_o = 1'b0;
			 //Jump_o   = 1'b1;
			assign MemRead_o= 1'b0;
			assign MemWrite_o=1'b1;
			//MemtoReg_o don't care
			end
		/* 6'b000010: //jump
			begin
			 RegWrite_o = 1'b0;
			//ALU_op_o don't care
			//ALUSrc_o don't care
			//RegDst_o don't care
			 Branch_o = 1'b0;
			 //Jump_o   = 1'b0;
			 MemRead_o= 1'b0;
			 MemWrite_o=1'b0;
			//MemtoReg_o don't care
			end */
		/* 6'b000011: //jal
			begin
			 RegWrite_o = 1'b1;
			 //ALU_op_o 
			 //ALUSrc_o = 1'b1;
			 RegDst_o = 2'b10; //Lab4 won't use jal cmd, in order to satisfy the bit of RegDst_o, just commit it.
			 Branch_o = 1'b0;
			 //Jump_o   = 1'b0;
			 MemRead_o= 1'b1;
			 MemWrite_o=1'b0;
			 MemtoReg_o=2'b11;	//Lab4 won't use		
			end */
		default:
			begin
			assign RegWrite_o = 1'b0;
			 //ALU_op_o 
			 //ALUSrc_o 
			 //RegDst_o 
			assign Branch_o = 1'b0;
			 //Jump_o   = 1'b1;
			assign MemRead_o= 1'b0;
			assign MemWrite_o=1'b0;
			 //MemtoReg_o		
			end
	endcase
	$display("In decoder, instr_op_i=%p",instr_op_i);
	$display("ALU_op_o = %p, ALUSrc_o = %p, RegWrite_o = %p, RegDst_o = %p, Branch_o = %p", ALU_op_o, ALUSrc_o, RegWrite_o, RegDst_o, Branch_o);
	$display("MemRead_o = %p, MemWrite_o = %p, MemtoReg_o = %p", MemRead_o, MemWrite_o, MemtoReg_o);
end

endmodule





                    
                    
