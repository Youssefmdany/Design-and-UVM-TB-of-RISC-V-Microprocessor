`timescale 1ns / 1ns

//////////////////////////////////////////////////////////////////////////////////
// Company: 

// Engineer: Youssef Ahmed
// 
// Create Date:    14/08/2023

// Design Name:    ID_EX stage 

// Module Name:    ID_EX

// Project Name:   RISC-V

// Target Devices: 

// Tool versions: 

// Description: 
//
//
//////////////////////////////////////////////////////////////////////////////////





module ID_EX(

	 	 	 	 	 input clk,
 	 	   	 	 input [1:0] regin_in,
	 	 	 	 	 input [2:0] branch_in,
	 	 	 	 	 input memtoreg_in,
	 	 	 	 	 input [1:0] ALUop_in,
	 	 	 	 	 input [1:0] ALUsrc_in,
	 	 	 	 	 input  regwrite_in,
	 	 	 	 	 input [3:0] memwrite_in,
	 	 	 	 	 input [31:0] rdata1_in,
	 	 	 	 	 input [31:0] rdata2_in,
	 	 	 	 	 input opinvalid_in,
	 	 	 	 	 input ACK_in,
	 	 	 	 	 input [31:0] immgen_in,
	 	 	 	 	 input [31:0] PC_in,
                input [3:0] mul_div_op_in,
	 	 	 	 	 input [31:0] inst_data_in,
	 	 	 	 	 output logic ACK_out,
	 	 	 	 	 output logic opinvalid_out,
	 	 	 	 	 output logic[31:0] rdata1_out,
	 	 	 	 	 output logic[31:0] rdata2_out,
	 	 	 	 	 output logic[31:0] immgen_out,
	 	 	 	 	 output logic[1:0] regin_out,
	 	 	 	 	 output logic[2:0] branch_out,
	 	 	 	 	 output logic memtoreg_out,
	 	 	 	 	 output logic[1:0] ALUop_out,
	 	 	 	 	 output logic[1:0] ALUsrc_out,
	 	 	 	 	 output logic regwrite_out,
	 	 	 	 	 output logic[3:0] memwrite_out,
	 	 	 	 	 output logic[31:0] PC_out,
                output logic [3:0] mul_div_op_out,
	 	 	 	 	 output logic[31:0] inst_data_out
	 	 	 	 	 	 	 	 	 	 	 	 	 	     	  );
															  
															  
															  
initial begin
	 
	regin_out =0;
	branch_out = 0;
	memtoreg_out = 0;
	ALUop_out = 0;
	ALUsrc_out = 0;
	regwrite_out = 0;
	memwrite_out = 0;
	rdata1_out = 0;
	rdata2_out = 0;
	immgen_out = 0;
	PC_out = 0;
	inst_data_out = 0;
	opinvalid_out = 0;
	ACK_out = 0;
	mul_div_op_out = 4'b1111 ;
	
	
	
	 end
	 
	 
	 
	 
always_ff @(posedge clk) begin

	regin_out <= regin_in;
	
	branch_out <= branch_in;
	
	memtoreg_out <= memtoreg_in;
	
	ALUop_out <= ALUop_in;
	
	ALUsrc_out <= ALUsrc_in;
	
	regwrite_out <= regwrite_in;
	
	memwrite_out <= memwrite_in;
	
	rdata1_out <= rdata1_in;
	
	rdata2_out <= rdata2_in;
	
	immgen_out <= immgen_in;
	
	PC_out <= PC_in;
	
	inst_data_out <= inst_data_in;
	
	opinvalid_out <= opinvalid_in;
	
	ACK_out <= ACK_in;

   mul_div_op_out <= mul_div_op_in;
	
end






endmodule