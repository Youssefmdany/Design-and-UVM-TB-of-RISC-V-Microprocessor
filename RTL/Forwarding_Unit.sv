`timescale 1ns / 1ns

//////////////////////////////////////////////////////////////////////////////////
// Company: 

// Engineer: Youssef Ahmed
// 
// Create Date:    13/08/2023

// Design Name:    Forwarding Unit

// Module Name:    Forwarding_Unit 

// Project Name:   RISC-V

// Target Devices: 

// Tool versions: 

// Description: 
//
//
//////////////////////////////////////////////////////////////////////////////////


module Forwarding_Unit(

                       	input [31:0] inst_data_EX,
                       	input [31:0] inst_data_MEM,
                       	input [31:0] inst_data_WB,
                       	input regwrite_MEM,
                       	input regwrite_WB,
                       	output [1:0] forward1,
                       	output [1:0] forward2
                                                   
																	);
	 

	 
	 
	 
assign forward1 = (regwrite_MEM && (inst_data_MEM[11:7] == inst_data_EX[19:15])) ? 2'b10 :
						(regwrite_WB  && (inst_data_WB[11:7] == inst_data_EX[19:15])) ? 2'b01 : 2'b00;
						
assign forward2 = (regwrite_MEM && ~(inst_data_MEM[11:7] == 0) && (inst_data_MEM[11:7] == inst_data_EX[24:20])) ? 2'b10 :
						(regwrite_WB && ~(inst_data_WB[11:7] == 0) && (inst_data_WB[11:7] == inst_data_EX[24:20])) ? 2'b01 : 2'b00;



						
endmodule
