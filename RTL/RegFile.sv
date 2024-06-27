`timescale 1ns / 1ns

//////////////////////////////////////////////////////////////////////////////////
// Company: 

// Engineer: Youssef Ahmed
// 
// Create Date:    13/08/2023

// Design Name:    Regsiters File

// Module Name:    RegFile 

// Project Name:   RISC-V

// Target Devices: 

// Tool versions: 

// Description: 
//
//
//////////////////////////////////////////////////////////////////////////////////



module RegFile(

                input clk,
                input  we,
                input [4:0] rs1,
                input [4:0] rs2,
                input [4:0] rd,
                input [31:0] Wdata,
                output logic [31:0] rdata1,
                output logic [31:0] rdata2,
	             output logic[31:0] reg31
                                        );

													 
													 
logic [31:0] RegFile[31:0];






//initialize all regsiters by zero value 


initial begin


  foreach(RegFile[j]) 
  
    RegFile[j] = 0;
	 

	
end







 assign rdata1 = (rs1 == rd) && we ? Wdata : RegFile[rs1];
				  
				  
 assign rdata2 =  (rs2 == rd) && we ? Wdata : RegFile[rs2];
				  
				  
 assign reg31 = Wdata;

 
 
 
 
 
always @ (posedge clk) begin


if(we)begin
	
		RegFile[rd] <= Wdata;
		
		
	end 
	

	
end





endmodule
