`timescale 1ns / 1ns

//////////////////////////////////////////////////////////////////////////////////
// Company: 

// Engineer: Youssef Ahmed
// 
// Create Date:    13/08/2023

// Design Name:    Data Memory

// Module Name:    DataMem 

// Project Name:   RISC-V

// Target Devices: 

// Tool versions: 

// Description: 
//
//
//////////////////////////////////////////////////////////////////////////////////





module DataMem(

                     input clk,
                     input [31:0] Data_addr,
                     input [31:0] Wdata,
                     input [3:0] we,		
                     output logic [31:0] Rdata
        
		                                      );
		 
		 
		 
		 
    logic [7:0] memory [65535:0];
 

    logic [31:0] add0,add1,add2,add3;
	 
	
	

	 
//initialize the memory by zeros value 

integer j;

initial begin


  for(j = 0; j < 2**16; j = j+1) 
  
    memory[j] = $urandom();
	 
	 
end



	  
	 
	 
	
    always @(posedge clk) begin
	 
        if (we[0]==1)
		  
            memory[add0]= Wdata[7:0];
				
        if (we[1]==1)
		  
            memory[add1]= Wdata[15:8];
				
        if (we[2]==1)
		  
            memory[add2]= Wdata[23:16];
				
        if (we[3]==1)
		  
            memory[add3]= Wdata[31:24];
    end
	
	
	
	
	
	
	always@(*) begin 
	  
	  add0 = (Data_addr & 32'h0000fffc) + 32'h00000000;
	  add1 = (Data_addr & 32'h0000fffc) + 32'h00000001;
	  add2 = (Data_addr & 32'h0000fffc) + 32'h00000002;
	  add3 = (Data_addr & 32'h0000fffc) + 32'h00000003; 
	  
	   Rdata ={memory[add3],memory[add2],memory[add1],memory[add0]};
	   
	   
	end
	  
	
 
	 
	
endmodule