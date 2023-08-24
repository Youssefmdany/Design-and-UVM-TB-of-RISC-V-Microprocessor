`timescale 1ns / 1ns

//////////////////////////////////////////////////////////////////////////////////
// Company: 

// Engineer: Youssef Ahmed
// 
// Create Date:    13/08/2023

// Design Name:    ALU Control

// Module Name:    ALU_Control 

// Project Name:   RISC-V

// Target Devices: 

// Tool versions: 

// Description: 
//
//
//////////////////////////////////////////////////////////////////////////////////



module ALU_Control(
  								  input [1:0] aluop,
  								  input [6:0] funct7,
  								  input [2:0] funct3,
  								  output logic [3:0] alu_contrl
  																            );
 

																  
																  

				

always_comb begin 

   
	if(aluop==2'b10) 
	
		      alu_contrl = {funct7[5], funct3};//ALU
				
				
	else if(aluop==2'b00)
 
            alu_contrl =  4'b0000; //LW, SW, JALR 

				
   else if(aluop==2'b01) begin //BRANCH
	
	
	   if(funct3==3'b000)
		              
						  alu_contrl =  4'b1000;
						  
		else if(funct3==3'b001)	
                    
						  alu_contrl =  4'b1000;
						  
		else if(funct3==3'b100)	
                    
						  alu_contrl =  4'b0010;
                    		
		else if(funct3==3'b101)	
                    
						  alu_contrl =  4'b0010;

		else if(funct3==3'b110)	
                    
						  alu_contrl =  4'b0011;
						  
		else if(funct3==3'b111)	
                    
						  alu_contrl =  4'b0011;
						  
	 
	           end

	
	else
						  
			 alu_contrl =  4'b1010; //default
	
	
	
	
end				
				
	


	
		
		
endmodule