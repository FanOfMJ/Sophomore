`timescale 1ns / 1ps
//Subject:     CO project 4 - Pipe Register
//--------------------------------------------------------------------------------
//Version:     1
//--------------------------------------------------------------------------------
//Writer:      
//----------------------------------------------
//Date:        
//----------------------------------------------
//Description: 
//--------------------------------------------------------------------------------
module Pipe_Reg(
    clk_i,
    rst_i,
    data_i,
    data_o
    );
					
parameter size = 0;

input   clk_i;		  
input   rst_i;
input   [size-1:0] data_i;
output reg  [size-1:0] data_o;
	  
always@(posedge clk_i) begin
    if(~rst_i)
        data_o <= 0;
    else
        data_o <= data_i;
	$display("in PipREG data_i=%p", data_i);
	$display("%p, %p, %p, %p, %p, %p, %p, ", data_i[size-1:size-2], data_i[size-3:size-5], data_i[size-6:size-37], data_i[size-38], data_i[size-39:size-70], data_i[size-71:size-102], data_i[size-103:size-107]);
	
	$display("data_o=%p", data_o);
end

endmodule	

