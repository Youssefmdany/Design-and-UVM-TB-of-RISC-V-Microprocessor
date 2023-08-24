`timescale 1ns / 1ns

class RISCV_Test  extends uvm_test;



  `uvm_component_utils(RISCV_Test)
  
  
  
  Environment RISCV_environment;
  
  
  
  Reset_seq reset_seq;
  
  RISCV_seq seq;

  temp_seq  temp;
  
  invalid_instr seq1;
  
  instr_with_interrupt seq2;
  
  
  
  
  function new(string name = "RISCV_Test" ,uvm_component parent);
  
  
    super.new(name,parent);
  
    `uvm_info(get_type_name(),"Inside constructor of RISCV Test Class",UVM_LOW)
  
  
  endfunction :new
  
  
  
  
  
  
  
  
  
  function void build_phase(uvm_phase phase);
  
  
    super.build_phase(phase);
    
	 
	 `uvm_info(get_type_name(),"Inside build phase of RISCV Test Class",UVM_LOW)

	 
	 RISCV_environment = Environment::type_id::create("RISCV_environment",this);
	 
	 
  
  endfunction :build_phase 
  
  
  
  
  
  
  
  
  function void connect_phase (uvm_phase phase);
  
  
    super.connect_phase(phase);
	 
	 
	 `uvm_info(get_type_name(),"Inside connect phase of RISCV Test Class",UVM_LOW)
	 
  
  endfunction :connect_phase
  
  
  
  
  
  
  
  
  
  task  run_phase(uvm_phase phase);
  
  
    super.run_phase(phase);
  
  
	 `uvm_info(get_type_name(),"Inside run phase of RISCV Test Class",UVM_LOW)
  
   
	
	 phase.raise_objection(this);
  
    
	    //apply reset sequence
	    
      
      reset_seq = Reset_seq::type_id::create("reset_seq");
	 
	    reset_seq.start(RISCV_environment.RISCV_Agent.RISCV_sequencer);
		 
     // #40;

	    
		 
		 repeat(50)begin	 
      		 
		   temp = temp_seq::type_id::create("temp");
	  
	     temp.start(RISCV_environment.RISCV_Agent.RISCV_sequencer);
	    
		  //#40;		 

	   end
	   
	   
		 
		 
     repeat(100000 )begin	 
      		 
		   seq = RISCV_seq::type_id::create("seq");
	  
	     seq.start(RISCV_environment.RISCV_Agent.RISCV_sequencer);
	    
		  //#40;		 

	   end
	 
	 
	 
	 		 seq1 = invalid_instr::type_id::create("seq1");
	  
	     seq1.start(RISCV_environment.RISCV_Agent.RISCV_sequencer);	
	     
	     
	     
	     
	  repeat(10)begin	 
      		 
		   seq = RISCV_seq::type_id::create("seq");
	  
	     seq.start(RISCV_environment.RISCV_Agent.RISCV_sequencer);
	    
		  //#40;		 

	   end
	 
	 
	 	     
	     
		   seq2 = instr_with_interrupt::type_id::create("seq2");
	  
	     seq2.start(RISCV_environment.RISCV_Agent.RISCV_sequencer);	  
	  
	  
	  
	  
	  
	  repeat(10)begin	 
      		 
		   seq = RISCV_seq::type_id::create("seq");
	  
	     seq.start(RISCV_environment.RISCV_Agent.RISCV_sequencer);
	    
		  //#40;		 

	   end
	 
	  
	  
	  
	   
	  
	  
	  	  
	  
	 phase.drop_objection(this);
  
  
  
  
 
  endtask :run_phase
  
  
  
  
  
  
  
  
endclass :RISCV_Test
