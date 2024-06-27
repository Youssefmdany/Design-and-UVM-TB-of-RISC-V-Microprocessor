`timescale 1ns / 1ns

//////////////////////////////////////////////////////////////////////////////////
// Company: 

// Engineer: Youssef Ahmed
// 
// Create Date:    14/08/2023

// Design Name:    EX_MEM stage 

// Module Name:    EX_MEM

// Project Name:   RISC-V

// Target Devices: 

// Tool versions: 

// Description: 
//
//
//////////////////////////////////////////////////////////////////////////////////




module EX_MEM(


	                input clk,
                        input reset,
                   input memtoreg_in,
                   input regwrite_in,
                   input [3:0] memwrite_in,
                   input [31:0] ALUout_in,
                   input [31:0] rdata2_in,
	                input invalid_in,
                   input [31:0] immgen_in,
                   input [1:0] regin_in,
                   input [31:0] PC_plus4_in,
	                input [31:0] inst_data_in,	 
	                output logic invalid_out,
                   output logic [31:0] rdata2_out,
                   output logic [31:0] ALUout_out,
                   output logic [3:0] memwrite_out,
                   output logic regwrite_out,
                   output logic memtoreg_out,
                   output logic [31:0] immgen_out,
                   output logic [1:0] regin_out,
                   output logic [31:0] PC_plus4_out,
	                output logic [31:0] inst_data_out
						 
                                                        );
																		  
																		  
	 

	
	
	
always_ff @(posedge clk)begin

     if(reset) begin

	regin_out = 0;
	
	memtoreg_out = 0;
	
	memwrite_out = 0;
	
	PC_plus4_out = 0;
	
	ALUout_out = 0;
	
	rdata2_out = 0;
	
	immgen_out = 0;
	
	regwrite_out = 0;
	
	inst_data_out = 0;
	
	invalid_out =0;


      end


     else begin  

	regin_out <= regin_in;
	
	memtoreg_out <= memtoreg_in;
	
	memwrite_out <= memwrite_in;
	
	PC_plus4_out <= PC_plus4_in;
	
	ALUout_out <= ALUout_in;
	
	rdata2_out <= rdata2_in;
	
	immgen_out <= immgen_in;
	
	regwrite_out <= regwrite_in;
	
	inst_data_out <= inst_data_in;
	
	invalid_out <= invalid_in;
	
	
           end	
	
	end
	
	
	
	
	
endmodule
