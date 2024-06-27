class reg_ref_model extends uvm_object;

  `uvm_object_utils(reg_ref_model)

  logic [31:0] regfile[31:0];  


  function new(string name = "reg_ref_model");
    super.new(name);  
  endfunction:new



  function void init_reg();

   for(int i =0; i<32 ; i++) regfile[i] = 0;

  endfunction




  function void print_reg();

   for(int i =0; i<32 ; i++) $display("regfile[%d] = %h,", i, regfile[i]);

  endfunction




  function logic[31:0] read_reg(int regnum);

    return regfile[regnum];

  endfunction:read_reg




  function void write_reg(int regnum, logic [31:0] data);
             

        regfile[regnum] = data ; 

  endfunction:write_reg




endclass:reg_ref_model
