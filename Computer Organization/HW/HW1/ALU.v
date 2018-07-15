//Subject:     CO project 2 - ALU
//--------------------------------------------------------------------------------
//Version:     1
//--------------------------------------------------------------------------------
//Writer:      
//----------------------------------------------
//Date:        
//----------------------------------------------
//Description: 
//--------------------------------------------------------------------------------

/*module ALU(
    src1_i,
	src2_i,
	ctrl_i,
	result_o,
	zero_o
	);
     
//I/O ports
input  [32-1:0]  src1_i;
input  [32-1:0]	 src2_i;
input  [4-1:0]   ctrl_i;

output [32-1:0]	 result_o;
output           zero_o;

//Internal signals
reg    [32-1:0]  result_o;
wire             zero_o;

//Parameter

//Main function
assign zero_o = (result_o==0);
always @(ctrl_i, src1_i, src2_i) begin
	$display("In ALU, input1: %d", src1_i);
	$display("In ALU, input2: %d", src2_i);
	$display("In ALU, control: %d", ctrl_i);
	case (ctrl_i)
		4'b0000: result_o = (src1_i & src2_i); //and
		4'b0001: result_o = (src1_i | src2_i); //or
		4'b0010: result_o = (src1_i + src2_i); //add
		4'b0110: result_o = (src1_i - src2_i); //substract
		4'b0111: result_o = (src1_i < src2_i ? 1:0); //set less than 
		//12: result_o <= ~(src1_i | src2_i); //nor
		default: result_o <= 0;
	endcase
	$display("In ALU, output: %d", result_o);
end
endmodule*/
`timescale 1ns/1ps

module ALU(
    	src1_i,
	src2_i,
	ctrl_i,
	result_o,
	zero_o
	);
     
input  [32-1:0] src1_i;
input  [32-1:0] src2_i;
input   [4-1:0] ctrl_i;
//input   [3-1:0] bonus_control; 

output  [32-1:0]  result_o;        // 32 bits result            (output)
output            zero_o;       // 1 bit when the output is 0, zero must be set (output)
reg    [32-1:0]  result_o;
reg             zero_o;

wire [31:0]     tmp;

wire  cin[32:0];
wire  less;

assign cin[0]=ctrl_i[1]&ctrl_i[2];
assign less=(src1_i[31]^ctrl_i[3]) ^ (src2_i[31]^ctrl_i[2]) ^ cin[31];

generate
  genvar i;
  for (i = 0; i < 32; i = i + 1) begin: generate_32_bit_ALU
    if (i==0) 
     alu_top alu_top(
               .src1(src1_i[i]),         //1 bit source 1 (input)
               .src2(src2_i[i]),         //1 bit source 2 (input)
               .less(less),           //1 bit less     (input)
               .A_invert(ctrl_i[3]),   //1 bit A_invert (input)
               .B_invert(ctrl_i[2]),   //1 bit B_invert (input)
               .cin(cin[i]),          //1 bit carry in (input)
               .operation(ctrl_i[1:0]),       //operation      (input)
               .result(tmp[i]),    //1 bit result   (output)
               .cout(cin[i+1])          //1 bit carry out(output)
               );
    else
     alu_top alu_top_bit (
              .src1(src1_i[i]),                 //1 bit source 1 (input)
              .src2(src2_i[i]),                 //1 bit source 2 (input)
              .less(1'b0),                    //1 bit less     (input)
              .A_invert(ctrl_i[3]),         //1 bit A_invert (input)
              .B_invert(ctrl_i[2]),         //1 bit B_invert (input)
              .cin(cin[i]),                   //1 bit carry in (input)
              .operation(ctrl_i[1:0]),                //operation      (input)
              .result(tmp[i]),             //1 bit result   (output)
              .cout(cin[i+1])                 //1 bit carry out(output)
            );
  end
endgenerate

initial begin
    zero_o<=1'b0;
end

always@(*) 
begin
    zero_o <= (tmp == 32'b0) ? 1'b1 : 1'b0;
    result_o<=tmp;


	$display("In ALU, input1: %d", src1_i);
	$display("In ALU, input2: %d", src2_i);
	$display("In ALU, control: %d", ctrl_i);
	$display("In ALU, output: %d", result_o);
end

endmodule



