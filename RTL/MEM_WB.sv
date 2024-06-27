`timescale 1ns / 1ns

//////////////////////////////////////////////////////////////////////////////////
// Company: 

// Engineer: Youssef Ahmed
// 
// Create Date:    14/08/2023

// Design Name:    MEM_WB stage 

// Module Name:    MEM_WB

// Project Name:   RISC-V

// Target Devices: 

// Tool versions: 

// Description: 
//
//
//////////////////////////////////////////////////////////////////////////////////


module MEM_WB(

		 	 	 	  input clk,
		 	 	 	  input reset,
  	 	 	 	     input memtoreg_in,
   	 	 	 	  input regwrite_in,
   	 	 	 	  input [31:0] ALUout_in,
    	 	 	 	  input [31:0] Rdata_in,
    	 	 	 	  input [31:0] immgen_in,
   	 	 	 	  input [31:0] PC_plus4_in,
   	 	 	 	  input [1:0] regin_in,
		 	 	 	  input [31:0] inst_data_in,
		 	 	 	  input [31:0] Data_addr_in,
		 	 	 	  input invalid_in,
		 	 	 	  output logic invalid_out,
		 	 	 	  output logic [31:0] Data_addr_out,
		 	 	 	  output logic [31:0] inst_data_out,
   	 	 	 	  output logic [1:0] regin_out,
   	 	 	 	  output logic [31:0] PC_plus4_out,
   	 	 	 	  output logic [31:0] immgen_out,
   	 	 	 	  output logic [31:0] ALUout_out,
   	 	 	 	  output logic [31:0] Rdata_out,
   	 	 	 	  output logic memtoreg_out,
   	 	 	 	  output logic regwrite_out
  	 	 	 	 	 	 	 	 	 	 	 	 	 	 	 	   );
	 	 	 	 
				 
				 
				 
	 
	 
	 
always_ff@(posedge clk)begin

        if(reset) begin 

	 ALUout_out = 0;
	 
	 memtoreg_out = 0;
	 
	 regwrite_out = 0;
	 
	 regin_out = 0;
	 
	 immgen_out = 0;
	 
	 Rdata_out = 0;
	 
	 PC_plus4_out = 0;
	 
	 inst_data_out = 0;
	 
	 Data_addr_out = 0; 
	 
	 invalid_out =0;
	 
	 Rdata_out = 0;


        end


       else begin 

	 ALUout_out <= ALUout_in;
	 
	 memtoreg_out <= memtoreg_in;
	 
	 regwrite_out <= regwrite_in;
	 
	 regin_out <= regin_in;
	 
	 immgen_out <= immgen_in;
	 
	 Rdata_out <= Rdata_in;
	 
	 PC_plus4_out <= PC_plus4_in;
	 
	 inst_data_out <= inst_data_in;
	 
	 Data_addr_out <= Data_addr_out; 
	 
	 invalid_out <= invalid_in;
	 
        end	 
end


endmodule
