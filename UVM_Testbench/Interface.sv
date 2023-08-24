


interface Interface (input logic CLK);


	         

  logic reset;
	logic I_Req;    
  logic[31:0] Rdata;
  logic[31:0] inst_data;
  logic[31:0] inst_addr; 
  logic[31:0] Data_addr;
  logic[31:0] Wdata;
  logic[3:0] we;    
  logic[31:0] reg31;
  logic [31:0] PC;
  logic IACK;




endinterface 