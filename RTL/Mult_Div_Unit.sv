`timescale 1ns / 1ns

//////////////////////////////////////////////////////////////////////////////////
// Company: 

// Engineer: Youssef Ahmed
// 
// Create Date:    13/08/2023

// Design Name:    Mult & Div Unit

// Module Name:    Mult_Div_Unit 

// Project Name:   RISC-V

// Target Devices: 

// Tool versions: 

// Description: 
//
//
//////////////////////////////////////////////////////////////////////////////////



module Mult_Div_Unit (

                        input logic[31:0] operand1,
                        input logic[31:0] operand2,
								        input [3:0] mul_div_op,
								        output logic[31:0] Result
                        
								
                                                      );
						
					
					
							
							
 parameter MAX_VALUE = 32'h8000_0000;
 parameter MIN_NEG_VALUE = -1;

							
							
							
logic [63:0] mul;
logic [31:0] div, rem;
						
						
						
						
							
always_comb begin 


  if(!mul_div_op[2] && !mul_div_op[3]) begin 
  
  
      if(!mul_div_op[1]) 
		
         mul = $signed(operand1) * $signed(operand2);
		
		else if(mul_div_op[1] && mul_div_op[0])
		   
			mul = $signed(operand1) * $unsigned(operand2);
		
		else 
		  
		   mul = $unsigned(operand1) * $unsigned(operand2);
		   
		

		
  
      if(mul_div_op==4'b0000)    //MUL
		
		  Result = mul[31:0];
		  
		else                      // MULH , MULHSU , MULHU
		
		   Result = mul[63:32];
  
  
  
  end
    
    
	 
	 
	 
  else if(mul_div_op[2] && !mul_div_op[3]) begin 
  
      
		
		if(operand2==0) begin  //division by zero
		   
			div = -1;
		   rem = operand1;
			
		end
		
		
		
	   else if(operand1 == MAX_VALUE && operand2 == MIN_NEG_VALUE && !mul_div_op[0]) begin 
		
		
			div = MAX_VALUE;
		   rem = 32'h0000_0000;
		    

		end
     
     
	  else if(!mul_div_op[0] && operand1!=0) begin 
	  
			div = $signed(operand1) / $signed(operand2);
		   rem = $signed(operand1) % $signed(operand2);
	          
	  
	  end
  
    else begin 
	 
	    	div = $unsigned(operand1) / $unsigned(operand2);
		   rem = $unsigned(operand1) % $unsigned(operand2);
 
	 
	 end
  
    
	  if(!mul_div_op[1]) 
	  
	     Result = div;
		  
	  else 
	  
	     Result = rem;
	  
	 
	 
  
  end
  
  
   else  Result = 32'bx;
  
  

end							
							
							
 							
							
							
							
							
							
endmodule 