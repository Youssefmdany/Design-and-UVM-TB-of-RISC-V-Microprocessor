

class Environment  extends uvm_env;



  `uvm_component_utils(Environment)
  
  
  Agent RISCV_Agent;
  
  
  
  
  
  
  function new(string name = "Environment" ,uvm_component parent);
  
  
    super.new(name,parent);
  
    `uvm_info(get_type_name(),"Inside constructor of Environment Class",UVM_LOW)
  
  
  endfunction :new
  
  
  
  
  
  
  
  function void build_phase(uvm_phase phase);
  
  
    super.build_phase(phase);
    
	 
	 `uvm_info(get_type_name(),"Inside build phase of Environment Class",UVM_LOW)

    
	 RISCV_Agent = Agent::type_id::create("RISCV_Agent",this);

   
  
  endfunction :build_phase 
  
  
  
  
  
  
  
  
  function void connect_phase (uvm_phase phase);
  
  
    super.connect_phase(phase);
	 
	 
	 `uvm_info(get_type_name(),"Inside connect phase of Environment Class",UVM_LOW)
	 
	 
  
  endfunction :connect_phase
  
  
  
  
  
  
  
  task  run_phase(uvm_phase phase);
  
  
    super.run_phase(phase);
  
  
	 `uvm_info(get_type_name(),"Inside run phase of Environment Class",UVM_LOW)
  
 
  endtask :run_phase
  
  
endclass :Environment