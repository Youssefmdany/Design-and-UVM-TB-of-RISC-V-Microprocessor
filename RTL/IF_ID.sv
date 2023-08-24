
`timescale 1ns / 1ns

//////////////////////////////////////////////////////////////////////////////////
// Company: 

// Engineer: Youssef Ahmed
// 
// Create Date:    14/08/2023

// Design Name:    IF_ID stage 

// Module Name:    IF_ID

// Project Name:   RISC-V

// Target Devices: 

// Tool versions: 

// Description: 
//
//
//////////////////////////////////////////////////////////////////////////////////





module IF_ID(

	           input clk,
	           input stalling,
              input [31:0] PC_in,
              input [31:0] inst_data_in,
	           input ACK_in,
	           output logic ACK_out,
              output logic [31:0] PC_out,
              output logic [31:0] inst_data_out
                                                     );
	 
	 
	


	
initial begin
PC_out = 0;
//inst_data_out = 0;
ACK_out = 0;
end




always_ff @(posedge clk) begin


  if(~stalling)begin
  
     PC_out <= PC_in;
     inst_data_out <= inst_data_in;
     ACK_out <= ACK_in;
	  
     end
	  
	  
end


endmodule