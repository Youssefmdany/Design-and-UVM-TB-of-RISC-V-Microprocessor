

class Scoreboard  extends uvm_scoreboard;





  `uvm_component_utils(Scoreboard)
  
  
  
  uvm_analysis_imp #(SPI_seq_item,Scoreboard) Scoreboard_port;
  
  
  
  SPI_seq_item items_fifo[$];
  
  
  
  
  
  
  
  function new(string name = "Scoreboard" ,uvm_component parent);
  
  
    super.new(name,parent);
  
    `uvm_info(get_type_name(),"Inside constructor of Scoreboard Class",UVM_LOW)
   
    
    
  endfunction :new
  
  
  
  
  
  
  
  function void build_phase(uvm_phase phase);
  
  
    super.build_phase(phase);
    
	 
	 `uvm_info(get_type_name(),"Inside build phase of Scoreboard Class",UVM_LOW)

	 
	 Scoreboard_port=new("Scoreboard_port",this);
	 
  
  endfunction :build_phase 
  
  
  
  
  
  
  
  
  function void connect_phase (uvm_phase phase);
  
  
    super.connect_phase(phase);
	 
	 
	 `uvm_info(get_type_name(),"Inside connect phase of Scoreboard Class",UVM_LOW)
	 
  
  endfunction :connect_phase
  
  
  
  
  
  
  
  task  run_phase(uvm_phase phase);
  
  
    super.run_phase(phase);
  
  
	 `uvm_info(get_type_name(),"Inside run phase of Scoreboard Class",UVM_LOW)
  
    
	 forever begin 
	 
	 
	    SPI_seq_item curr_item;
		 
		 wait(items_fifo.size());
		 
		   
			curr_item = items_fifo.pop_front();
	 
	   //   compare(curr_item);
	 
	 
	 
	 end
  
  
  
 
  endtask :run_phase
  
  
  
  
  
  
  
  
  
  function void write (SPI_seq_item  item);

		  items_fifo.push_back(item);
	 

  endfunction: write
  
  
  
  
  
  
  
  
  
  task compare (SPI_seq_item  item);
  
      
 //      if(item.data_in != item.data_out)
		 
//		     `uvm_error(get_type_name(),$sformatf("the test failed as the sent data = %b while the received = %b",item.data_in,item.data_out))
  

				
  endtask: compare
  
  
  
  
  
  
  
  
  
  
  
endclass :Scoreboard