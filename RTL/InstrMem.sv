`timescale 1ns / 1ps

//////////////////////////////////////////////////////////////////////////////////
// Company: 

// Engineer: Youssef Ahmed
// 
// Create Date:    14/08/2023

// Design Name:    instruction Memory 

// Module Name:    InstrMem

// Project Name:   RISC-V

// Target Devices: 

// Tool versions: 

// Description: 
//
//
//////////////////////////////////////////////////////////////////////////////////




module InstrMem(
                    input [31:0] inst_addr,
                    output [31:0] inst_data
                                                 );
																 
																 
					
					
    logic [7:0] instruction_Memory[0:4095];

    assign inst_data = {instruction_Memory[inst_addr[31:0]+3],instruction_Memory[inst_addr[31:0]+2],instruction_Memory[inst_addr[31:0]+1],instruction_Memory[inst_addr[31:0]]}; // as the address of instruction is multiple of 4



	 
endmodule