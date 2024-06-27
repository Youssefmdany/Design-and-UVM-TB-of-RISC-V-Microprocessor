class mem_ref_model extends uvm_object;

  `uvm_object_utils_begin(mem_ref_model)
  `uvm_object_utils_end

  logic [7:0] mem[(2**16)-1:0];  




  function new(string name = "mem_ref_model");
    super.new(name);  
  endfunction:new




  function void init_mem();

   for(int i =0; i<2**16 ; i++) mem[i] = 0;

  endfunction


  function logic[31:0] read_mem(logic[15:0] addr, int data_wsize);
    logic [31:0] temp;

    if(data_wsize == 32)
      temp = {mem[addr+3], mem[addr+2], mem[addr+1], mem[addr]};
    else if(data_wsize == 16)
      temp = {mem[addr+1], mem[addr]};
    else if(data_wsize == 8)
      temp = mem[addr];

    return temp;
  endfunction:read_mem

  function void write_mem(logic[15:0] addr, int data_wsize, logic [31:0] data);
    for(int i = 0; i < data_wsize/8; i++) begin
      mem[addr + i] = data[7:0];
      data = data >> 8;
    end
  endfunction:write_mem

endclass:mem_ref_model
