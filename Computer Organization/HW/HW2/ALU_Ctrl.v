//Subject:     CO project 2 - ALU Controller
//--------------------------------------------------------------------------------
//Version:     1
//--------------------------------------------------------------------------------
//Writer:      
//----------------------------------------------
//Date:        
//----------------------------------------------
//Description: 
//--------------------------------------------------------------------------------

module ALU_Ctrl(
          funct_i,
          ALUOp_i,
          ALUCtrl_o
          );
          
//I/O ports 
input      [6-1:0] funct_i;
input      [3-1:0] ALUOp_i;

output     [4-1:0] ALUCtrl_o;    
     
//Internal Signals
reg        [4-1:0] ALUCtrl_o;

//Parameter

       
//Select exact operation

always@(*)
begin 
	case(ALUOp_i)
		0: ALUCtrl_o=4'd2;
		1: ALUCtrl_o=4'd6;
		2: begin
				ALUCtrl_o[0]= funct_i[0] || funct_i[3];
				ALUCtrl_o[1]= (!funct_i[2]);
				ALUCtrl_o[2]= funct_i[1];
				ALUCtrl_o[3]= 1'b0;
			
		    end
		3: ALUCtrl_o=4'd7;
	endcase
	$display("ALUCtrl_o = %p", ALUCtrl_o);
end

endmodule     





                    
                    

