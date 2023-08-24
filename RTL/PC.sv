`timescale 1ns / 1ns

//////////////////////////////////////////////////////////////////////////////////
// Company: 

// Engineer: Youssef Ahmed
// 
// Create Date:    13/08/2023

// Design Name:    Program Counter

// Module Name:    PC 

// Project Name:   RISC-V

// Target Devices: 

// Tool versions: 

// Description: 
//
//
//////////////////////////////////////////////////////////////////////////////////




module PC(
             input [31:0] PC,
             input [31:0] immgen,
             input [2:0] branch,
             input zero,
	          input invalid,
	          input [31:0] alu_out,
	          output logic [31:0] PC_plus4,
	          output logic [31:0] PC_next,
             output logic PCsrc
                                        );
	 

	 
	 
	 
	 
assign PC_plus4 = PC + 4;



logic [31:0] PC_branch;




assign PC_branch = PC + immgen;




					  
					  
always@(*)

begin 

   
	
	if(invalid) 
	     PC_next = 0;
	
   else if(branch == 3'b001) begin 
	
	   if(~zero) begin 
		
		PC_next = PC_branch;
		PCsrc = 1'b1;
		
		 end
		 
		 
	   else 	begin 
		
		PC_next = PC_plus4;
 		PCsrc = 1'b0;        
		end
		
    end
	 
	 
	 
	 else if(branch == 3'b010 ) begin 
	 
	   if(~zero) begin 
		
		PC_next = PC_plus4;
 		PCsrc = 1'b0;        
		
		end
		
	   else 	begin
		
		PC_next = PC_branch;
 		PCsrc = 1'b1;        
		
	   end

	 end


	 else if(branch == 3'b011 ) begin 
	 

		PC_next = PC_branch;
 		PCsrc = 1'b1;        
	   

	 end

	 
	 
	 
	 else if(branch == 3'b100 ) begin 
	 

		PC_next = (alu_out & 32'hFFFFFFFE);
	   PCsrc = 1'b1;        


	 end
	
  
  
    else begin
	 
	 PC_next = PC_plus4;
	   PCsrc = 1'b0;        
	 
	end
	 
end					  
					  
					  
					  
endmodule