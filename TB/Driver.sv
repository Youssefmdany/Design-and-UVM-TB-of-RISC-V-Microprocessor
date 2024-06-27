
class Driver  extends uvm_driver #(RISCV_seq_item);



  `uvm_component_utils(Driver)
  
  
  virtual Interface intf;
  
  
  RISCV_seq_item item;
  
  
  
  
  
  
  
  function new(string name = "Driver" ,uvm_component parent);
  
  
    super.new(name,parent);
  
    `uvm_info(get_type_name(),"Inside constructor of Driver Class",UVM_LOW)
  
  
  endfunction :new
  
  
  
  
  
  
  
  function void build_phase(uvm_phase phase);
  
  
    super.build_phase(phase);
    
	 
	 `uvm_info(get_type_name(),"Inside build phase of Driver Class",UVM_LOW)
   
   
   if(!(uvm_config_db #(virtual Interface)::get(this,"*","intf",intf)))
	 
	     `uvm_error(get_type_name(),"failed to get virtual interface inside Driver class")
  


  
  endfunction :build_phase 
  
  
  
  
  
  
  
  
  function void connect_phase (uvm_phase phase);
  
  
    super.connect_phase(phase);
	 
	 
	 `uvm_info(get_type_name(),"Inside connect phase of Driver Class",UVM_LOW)
	 
  
  endfunction :connect_phase
  
  
  
  
  
  
  
  task run_phase(uvm_phase phase);
  
  
    super.run_phase(phase);
  
  
	 `uvm_info(get_type_name(),"Inside run phase of Driver Class",UVM_LOW)
    
	 
	 
	 
	 forever begin 
	 
	 
	 
	  item = RISCV_seq_item::type_id::create("item");

	 
	  seq_item_port.get_next_item(item);
	  
	  
	  drive(item);
	  
	  
	  
	  seq_item_port.item_done();
	  
	  
	 
	 end
	 
 
 
 
  endtask :run_phase
  
  
  
  
  
  
  
  
  task  drive (RISCV_seq_item item);
 
    if(!item.reset)  @(posedge intf.CLK); 
       
    intf.reset = item.reset ;
    intf.I_Req = item.I_Req ;
    intf.inst_data = item.inst_data ; 
  

  
  endtask: drive

  
  
  
 
  
  
  
endclass :Driver
