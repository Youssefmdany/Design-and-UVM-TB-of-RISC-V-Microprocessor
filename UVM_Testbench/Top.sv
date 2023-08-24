`timescale 1ns / 1ns


`include "Interface.sv"



module Top();


import RISCV_pkg::*;

import uvm_pkg::*;


logic clk;




Interface intf(.CLK(clk));




RISC_V risc_v (    

                .clk(clk),
                .reset(intf.reset),
                .I_Req(intf.I_Req),
				        .Rdata(intf.Rdata),
				        .inst_data(intf.inst_data),
				        .inst_addr(intf.inst_addr),
				        .Data_addr(intf.Data_addr),
				        .Wdata(intf.Wdata),
				        .we(intf.we),
				        .reg31(intf.reg31),
                .PC(intf.PC),
                .IACK(intf.IACK)
                
				                                    );




                                               
                                         
 
 
 DataMem Dmem (

                .clk(clk),
				        .Data_addr(intf.Data_addr),
                .Wdata(intf.Wdata),
				        .we(intf.we),
                .Rdata(intf.Rdata)    
				                           
				                                             );
                                               
                                               
                                               
                                               
                                               
                                               
 
 


initial begin 


  clk = 1;
  
  forever  #20 clk = ~clk;


end







initial begin 


  uvm_config_db #(virtual Interface)::set(null,"*","intf",intf);
  
  
  run_test("RISCV_Test");
  

end







initial begin 


  #4100000

  $finish();


end









endmodule 