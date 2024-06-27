

class Environment  extends uvm_env;



  `uvm_component_utils(Environment)
  
  
  Agent RISCV_Agent;
  
  Scoreboard RISCV_Scoreboard; 
  
  mem_ref_model mem_ref_model_h;
 
  reg_ref_model reg_ref_model_h;


  
  
  function new(string name = "Environment" ,uvm_component parent);
  
  
    super.new(name,parent);
  
    `uvm_info(get_type_name(),"Inside constructor of Environment Class",UVM_LOW)
  
  
  endfunction :new
  
  
  
  
  
  
  
  function void build_phase(uvm_phase phase);
  
  
    super.build_phase(phase);
    
	 
	 `uvm_info(get_type_name(),"Inside build phase of Environment Class",UVM_LOW)

    
	 RISCV_Agent = Agent::type_id::create("RISCV_Agent",this);

         RISCV_Scoreboard = Scoreboard::type_id::create("RISCV_Scoreboard",this);

         mem_ref_model_h = new("mem_ref_model_h");
 
         reg_ref_model_h = new("mem_ref_model_h");

         uvm_config_db #(mem_ref_model)::set(this,"*","mem_ref_model_h",mem_ref_model_h);

         uvm_config_db #(reg_ref_model)::set(this,"*","reg_ref_model_h",reg_ref_model_h);

  
  endfunction :build_phase 
  
  
  
  
  
  
  
  
  function void connect_phase (uvm_phase phase);
  
  
    super.connect_phase(phase);
	 
	 
	 `uvm_info(get_type_name(),"Inside connect phase of Environment Class",UVM_LOW)
	 
	 RISCV_Agent.RISCV_monitor.monitor_port.connect(RISCV_Scoreboard.SB_ex_port);
  
  endfunction :connect_phase
  
  
  
  
  
  
  
  task  run_phase(uvm_phase phase);
  
  
    super.run_phase(phase);
  
  
	 `uvm_info(get_type_name(),"Inside run phase of Environment Class",UVM_LOW)
  
 
  endtask :run_phase
  
  
endclass :Environment
