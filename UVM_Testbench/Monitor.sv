class Monitor  extends uvm_monitor;



  `uvm_component_utils(Monitor)
  
  
  virtual Interface intf;
  
  
  
  uvm_analysis_port #(RISCV_seq_item) monitor_port;
  
  
  RISCV_seq_item item;
  
  

  
  
  
  
  
  
  
  function new(string name = "Monitor" ,uvm_component parent);
  
  
    super.new(name,parent);
  
    `uvm_info(get_type_name(),"Inside constructor of Monitor Class",UVM_LOW)
    
    
    
  endfunction :new
  
  
  
  
  
  
  
  function void build_phase(uvm_phase phase);
  
  
  
    super.build_phase(phase);
    
	 
	 `uvm_info(get_type_name(),"Inside build phase of Monitor Class",UVM_LOW)
	 
    
	 if(!(uvm_config_db #(virtual Interface)::get(this,"*","intf",intf)))
	 
	     `uvm_error(get_type_name(),"failed to get virtual interface inside Monitor class")
  
  
    
	 monitor_port = new("monitor_port",this);
	 
	 
	 
  endfunction :build_phase 
  
  
  
  
  
  
  
  
  function void connect_phase (uvm_phase phase);
  
  
    super.connect_phase(phase);
	 
	 
	 `uvm_info(get_type_name(),"Inside connect phase of Monitor Class",UVM_LOW)
	
  
  
  endfunction :connect_phase
  
  
  
  
  
  
  
  task  run_phase(uvm_phase phase);
  
  
    super.run_phase(phase);
  
  
	 `uvm_info(get_type_name(),"Inside run phase of Monitor Class",UVM_LOW)
  
    
	 item = RISCV_seq_item::type_id::create("item");
  
    
	 
	 forever begin 
	 
	 
	   item = RISCV_seq_item::type_id::create("item");
		
	   
           wait(!intf.reset);
           
            item.reset = intf.reset ;
            item.I_Req = intf.I_Req ;
            item.inst_data = intf.inst_data ; 
       
           @(posedge intf.CLK);    
         
          
          
   
	  monitor_port.write(item);
		


	 end
	 
	 
 
 
  endtask :run_phase
  
  
  
  
  
endclass :Monitor