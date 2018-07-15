
`timescale 1ns/1ps
module alu_top(
               src1,       //1 bit source 1 (input)
               src2,       //1 bit source 2 (input)
               less,       //1 bit less     (input)
               A_invert,   //1 bit A_invert (input)
               B_invert,   //1 bit B_invert (input)
               cin,        //1 bit carry in (input)
               operation,  //operation      (input)
               result,     //1 bit result   (output)
               cout       //1 bit carry out(output)
               );

input         src1;
input         src2;
input         less;
input         A_invert;
input         B_invert;
input         cin;
input [2-1:0] operation;

output  reg    result;
output  reg    cout;

wire      src1_temp, src2_temp;

assign src1_temp=A_invert^src1;
assign src2_temp=B_invert^src2;

always@(src1_temp or src2_temp or operation or cin or less)
begin
 	cout = (operation>=2'b10) ? (cin&src2_temp) | (cin&src1_temp) | (src1_temp&src2_temp) : 1'b0 ;
	
	 case (operation)
		2'b00: result=src1_temp & src2_temp;
		2'b01: result=src1_temp | src2_temp;
		2'b10: result=src1_temp^src2_temp^cin;
		2'b11: result=less;
	endcase

end
endmodule

