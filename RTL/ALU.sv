`timescale 1ns / 1ns

//////////////////////////////////////////////////////////////////////////////////
// Company: 

// Engineer: Youssef Ahmed
// 
// Create Date:    13/08/2023

// Design Name:    ALU

// Module Name:    ALU 

// Project Name:   RISC-V

// Target Devices: 

// Tool versions: 

// Description: 
//
//
//////////////////////////////////////////////////////////////////////////////////



module ALU(
 					    input [31:0] in1,
   					    input [31:0] in2,
   					    input [3:0] alu_contrl,
   					    input diff,             //differentiate between I_Type and R_Type
   					    output logic[31:0] out,
   					    output logic zero
   											                );
	

	// They are the same instructions for I_Type inst
	
	 parameter ADD = 4'b0000; 
	 parameter SLL = 4'b0001; 
	 parameter SLT = 4'b0010;
	 parameter SLTU = 4'b0011;
	 parameter XOR = 4'b0100;
	 parameter SRL = 4'b0101;
	 parameter SUB = 4'b1000;
	 parameter SRA = 4'b1101;
	 parameter OR = 4'b0110;
	 parameter AND = 4'b0111;
	 
	 parameter ADDI = 3'b000; 
	 parameter SLLI = 3'b001; 
	 parameter SLTI = 3'b010;
	 parameter SLTUI = 3'b011;
	 parameter XORI = 3'b100;
	 parameter SRLI_OR_SRAI = 3'b101;
	 parameter ORI = 3'b110;
	 parameter ANDI = 3'b111;
	 	 
	 
	 
	assign zero = (out == 0);
	 
	
	
	
	
 always_comb begin
 
 
  if(!diff) begin
    
   case(alu_contrl) 
	
	  ADD: out = in1 + in2;
	  
     SLL: out = in1 << in2[4:0];
	  
     SLT: out = $signed(in1) < $signed(in2) ? 1 : 0;
	  
     SLTU: out = in1 < in2 ? 1 : 0;
	  
	   XOR: out = in1 ^ in2;
	  
     SRL: out = in1 >> in2[4:0];
	  
     SRA: out = $signed(in1) >>> in2[4:0];

     SUB: out = in1 - in2;
	  
     OR: out = in1 | in2;	  
	  
     AND: out = in1 & in2;
     
     
     endcase
     
     
	  end
    	  
 else begin 
   
   
   case(alu_contrl[2:0]) 
	
	   ADDI: out = in1 + in2;
	  
     SLLI: out = in1 << in2[4:0];
	  
     SLTI: out = in1 < in2 ? 1 : 0;
	  
     SLTUI: out = in1 < in2 ? 1 : 0;
	  
	   XORI: out = in1 ^ in2;
	  
     SRLI_OR_SRAI: out = (alu_contrl[3]==1'b1)? $signed(in1) >>> in2[4:0] : in1 >> in2[4:0];
	  	  
     ORI: out = in1 | in2;	  
	  
     ANDI: out = in1 & in2;
   
      endcase
   
 end
 
   
	
	
	
 end






	
endmodule
