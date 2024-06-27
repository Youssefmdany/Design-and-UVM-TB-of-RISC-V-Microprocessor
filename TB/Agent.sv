class Agent extends uvm_agent;



  `uvm_component_utils(Agent)
  
  
  
  Monitor RISCV_monitor;
  
  Driver RISCV_driver;
  
  Sequencer RISCV_sequencer;
  
  Coverage_collector  RISCV_coverage_collector; 
  
  
  function new(string name = "Agent" ,uvm_component parent);
  
  
    super.new(name,parent);
  
    `uvm_info(get_type_name(),"Inside constructor of Agent Class",UVM_LOW)
  
  
  endfunction :new
  
  
  
  
  
  
  
  function void build_phase(uvm_phase phase);
  
  
    super.build_phase(phase);
    
	 
	 `uvm_info(get_type_name(),"Inside build phase of Agent Class",UVM_LOW)

        RISCV_monitor = Monitor::type_id::create("RISCV_monitor",this);
	 
	      RISCV_driver = Driver::type_id::create("RISCV_driver",this);
	 
	      RISCV_sequencer = Sequencer::type_id::create("RISCV_sequencer",this);
	 
        RISCV_coverage_collector = Coverage_collector::type_id::create("RISCV_coverage_collector",this); 
        
  
  
  endfunction :build_phase 
  
  
  
  
  
  
  
  
  function void connect_phase (uvm_phase phase);
  
  
    super.connect_phase(phase);
	 
	 
	 `uvm_info(get_type_name(),"Inside connect phase of Agent Class",UVM_LOW)
	 
	 
	 RISCV_driver.seq_item_port.connect(RISCV_sequencer.seq_item_export);
	 RISCV_monitor.monitor_port.connect(RISCV_coverage_collector.analysis_export); 
  
  
  endfunction :connect_phase
  
  
  
  
  
  
  
  task  run_phase(uvm_phase phase);
  
  
    super.run_phase(phase);
  
  
	 `uvm_info(get_type_name(),"Inside run phase of Agent Class",UVM_LOW)
  
 
  endtask :run_phase
  
  
endclass :Agent
