`timescale 1ns / 1ns

//////////////////////////////////////////////////////////////////////////////////
// Company: 

// Engineer: Youssef Ahmed
// 
// Create Date:    12/08/2023

// Design Name:    Staller

// Module Name:    Staller 

// Project Name:   RISC-V

// Target Devices: 

// Tool versions: 

// Description: 
//
//
//////////////////////////////////////////////////////////////////////////////////



module Staller(

                 input[31:0] inst_data_EX,
					  input[31:0] inst_data_ID,
					  input MemRead_EX,
					  output logic Staller

                                   );

											  
											  
											  
parameter Load_Instr = 7'b0000011;




 always @(*) begin 
  
    if((( MemRead_EX && ((inst_data_EX[11:7] == inst_data_ID[19:15])
                    
						|| ((inst_data_EX[11:7] == inst_data_ID[24:20]) && (inst_data_EX[6:0] != Load_Instr))))) && inst_data_EX!=inst_data_ID)
						
						Staller = 1'b1;
		
		else Staller = 1'b0;
		  
		  
  
  
end
											  
											  
											
endmodule 
