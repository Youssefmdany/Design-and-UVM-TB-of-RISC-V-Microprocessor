class Sequencer  extends uvm_sequencer #(RISCV_seq_item);



  `uvm_component_utils(Sequencer)
  
  
  
  
  
  function new(string name = "Sequencer" ,uvm_component parent);
  
  
    super.new(name,parent);
  
    `uvm_info(get_type_name(),"Inside constructor of Sequencer Class",UVM_LOW)
  
  
  endfunction :new
  
  
  
  
  
  
  
  function void build_phase(uvm_phase phase);
  
  
    super.build_phase(phase);
    
	 
	 `uvm_info(get_type_name(),"Inside build phase of Sequencer Class",UVM_LOW)

  
  endfunction :build_phase 
  
  
  
  
  
  
  
  
  function void connect_phase (uvm_phase phase);
  
  
    super.connect_phase(phase);
	 
	 
	 `uvm_info(get_type_name(),"Inside connect phase of Sequencer Class",UVM_LOW)
	 
  
  endfunction :connect_phase
  
  
  
  
  
  
  
  task  run_phase(uvm_phase phase);
  
  
    super.run_phase(phase);
  
  
	 `uvm_info(get_type_name(),"Inside run phase of Sequencer Class",UVM_LOW)
  
 
  endtask :run_phase
  
  
endclass :Sequencer