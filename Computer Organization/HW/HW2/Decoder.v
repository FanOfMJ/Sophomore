//Subject:     CO project 2 - Decoder
//--------------------------------------------------------------------------------
//Version:     1
//--------------------------------------------------------------------------------
//Writer:      Luke
//----------------------------------------------
//Date:        
//----------------------------------------------
//Description: 
//--------------------------------------------------------------------------------

module Decoder(
    instr_op_i,
	RegWrite_o,
	ALU_op_o,
	ALUSrc_o,
	RegDst_o,
	Branch_o
	);
     
//I/O ports
input  [6-1:0] instr_op_i;

output         RegWrite_o;
output [3-1:0] ALU_op_o;
output         ALUSrc_o;
output         RegDst_o;
output         Branch_o;
 
//Internal Signals
reg    [3-1:0] ALU_op_o;
reg            ALUSrc_o;
reg            RegWrite_o;
reg            RegDst_o;
reg            Branch_o;

//Parameter

always@(*)
	begin
	//Main function
	
	case(instr_op_i)
		6'b000000: //R-format
			begin
			assign ALU_op_o = 3'b010; //2
	            	assign ALUSrc_o = 1'b0;
	            	assign RegWrite_o = 1'b1;
			assign RegDst_o = 1'b1;
			assign Branch_o = 1'b0;
			end
		6'b000100: //BEQ
			begin
			assign ALU_op_o = 3'b001; //1
	            	assign ALUSrc_o = 1'b0;
	            	assign RegWrite_o = 1'b0;
			//RegDst_o don't care
			assign Branch_o = 1'b1;
			end
		6'b001000: //ADDI
			begin
			assign ALU_op_o = 3'b000; //0
	            	assign ALUSrc_o = 1'b1;
	            	assign RegWrite_o = 1'b1;
			assign RegDst_o = 1'b0;
			assign Branch_o = 1'b0;
			end
		6'b001010: //SLTI
			begin
			assign ALU_op_o = 3'b011; //3
	            	assign ALUSrc_o = 1'b1;
	            	assign RegWrite_o = 1'b1;
			assign RegDst_o = 1'b0;
			assign Branch_o = 1'b0;
			end
	endcase
	$display("In decoder, instr_op_i = %p", instr_op_i);
	$display("In decoder, ALU_op_o = %p, ALUSrc_o = %p, RegWrite_o = %p, RegDst_o = %p, Branch_o = %p", ALU_op_o, ALUSrc_o, RegWrite_o, RegDst_o, Branch_o);
end

endmodule





                    
                    

