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
	
	//$display("In ALU, result=%p zero=%p", result_o, zero_o);

end

endmodule

