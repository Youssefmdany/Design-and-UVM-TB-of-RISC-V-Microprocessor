class RISCV_seq_item extends uvm_sequence_item;




  `uvm_object_utils(RISCV_seq_item)
  
  
  
  
  rand logic reset;
  rand logic I_Req;    
  randc logic[31:0] inst_data;

  logic[31:0] Rdata;
  logic[31:0] inst_addr; 
  logic[31:0] Data_addr;
  logic[31:0] Wdata;
  logic [31:0] PC; 
  logic [31:0] reg31;

  
  constraint c_opcode{ inst_data[6:0] inside {    7'b0110111 ,
                                                  7'b0010111 ,
                                                  7'b1101111 ,
                                                  7'b1100111 ,
                                                  7'b1100011 ,
                                                  7'b0000011 ,
                                                  7'b0100011 ,
                                                  7'b0010011 ,
                                                  7'b0110011 ,
                                                  7'b0100011  };   }
                                              

    
  constraint funct { 
  
                       (inst_data[6:0]==7'b0110011) -> (inst_data[31:25] inside {7'b0000000, 7'b0100000, 7'b0000001} );  //R-Type
                       
                       (inst_data[6:0]==7'b0110011 && inst_data[31:25]== 7'b0100000) -> (inst_data[14:12] inside {3'b101, 3'b000} );  //R-Type                       
                       
                       (inst_data[6:0]==7'b0000011) -> ((inst_data[14:12] inside {3'b000,3'b001,3'b010,3'b100,3'b101} ) && (inst_data[31]==0));  //Load
                       
                       (inst_data[6:0]==7'b1100011) -> (inst_data[14:12] inside {3'b000,3'b001,3'b100,3'b101,3'b110,3'b111} );  //Branch
                       
                       (inst_data[6:0]==7'b1100111) -> (inst_data[14:12] inside {3'b000});  //JALR
                       
                       (inst_data[6:0] == 7'b0100011) -> (inst_data[14:12] inside {3'b000,3'b001,3'b010})   ;  //Store
                       
                       ((inst_data[6:0] == 7'b0010011) & (inst_data[13:12] == 2'b01)) -> (inst_data[31:25] inside {7'b0000000, 7'b0100000} );  //I-Type
  
                                                      
                                                                                                                                                 }
                                                                                                                              
                                                                                                                              
 constraint load_into_memory {
 
                                 (inst_data[6:0]==7'b0000011 & inst_data[14:12] inside {3'b001,3'b101}) -> (inst_data[8:7] inside {2'b00,2'b10});
                                 
                                 (inst_data[6:0]==7'b0000011 & inst_data[14:12]==3'b010) -> (inst_data[8:7] inside {2'b00});
 
 
 
                                   };
 
  
  

                                                  
                                                  
  
  function new(string name = "RISCV_seq_item");
  
  
    super.new(name);
  
    `uvm_info(get_type_name(),"Inside constructor of RISCV seq item Class",UVM_HIGH)
  
  
  endfunction :new
  
  
  
  
  
  
  
  
  
endclass :RISCV_seq_item
