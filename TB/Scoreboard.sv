class Scoreboard extends uvm_scoreboard;


`uvm_component_utils(Scoreboard)

uvm_analysis_export #(RISCV_seq_item) SB_ex_port;

uvm_tlm_analysis_fifo  #(RISCV_seq_item) SB_TLM_port;


RISCV_seq_item item;

mem_ref_model mem_ref_model_h;

reg_ref_model reg_ref_model_h;



logic[31:0] IF,ID,IEXE,IMEM,IWB,temp_inst ;

logic[31:0] PC_t = 0;

logic[31:0] PC = 0,PT=0;

logic[31:0] PC_IF,PC_ID,PC_IEXE,PC_IMEM,PC_IWB,PT;

logic[31:0] reg31_IWB;

logic[31:0] Wdata_IMEM;

logic[31:0] Wdata2reg_1,Wdata2reg_2_EXE,Wdata2reg_2_MEM,Wdata2reg_2_WB;

bit x,y,forward;



function new(string name="Scoreboard",uvm_component parent);

    super.new(name,parent);

    `uvm_info(get_type_name(),"inside Scoreboard constructor",UVM_LOW)

endfunction:new




function void build_phase(uvm_phase phase);

   super.build_phase(phase);

   `uvm_info(get_type_name(),"inside Scoreboard's build phase",UVM_LOW)

    SB_ex_port= new("SB_ex_port",this);

    SB_TLM_port= new("SB_TLM_port",this);
    
    mem_ref_model_h = new("mem_ref_model_h");

    reg_ref_model_h = new("reg_ref_model_h");


    
    if(!(uvm_config_db #(mem_ref_model)::get(this,"","mem_ref_model_h",mem_ref_model_h)))
     
       `uvm_error(get_type_name(),"error in getting mem_ref_model")


    if(!(uvm_config_db #(reg_ref_model)::get(this,"","reg_ref_model_h",reg_ref_model_h)))
     
       `uvm_error(get_type_name(),"error in getting reg_ref_model")


  mem_ref_model_h.init_mem();

  reg_ref_model_h.init_reg();



endfunction:build_phase



function void connect_phase(uvm_phase phase);

   super.connect_phase(phase);

   SB_ex_port.connect(SB_TLM_port.analysis_export);


endfunction:connect_phase





task run_phase(uvm_phase phase);

   super.run_phase(phase); 

  `uvm_info(get_type_name(),"inside Scoreboard's run phase",UVM_LOW)

  item= RISCV_seq_item::type_id::create("item");


  forever begin


    SB_TLM_port.get(item);


 

       temp_inst = IWB;
       IWB = IMEM;
       IMEM = IEXE;
       IEXE = ID;
       ID = IF;
       IF = item.inst_data;
       reg31_IWB = item.reg31;

       

       PC_IWB = PC_IMEM;
       PC_IMEM = PC_IEXE;
       PC_IEXE = PC_ID;
       PC_ID = PC_IF;
       PC_IF = item.PC;

        
       Wdata2reg_2_WB = Wdata2reg_2_MEM ;
       Wdata2reg_2_MEM = Wdata2reg_2_EXE ;


      forward = ( (IMEM[11:7] == IEXE[19:15]) || (IMEM[11:7] == IEXE[24:20]) );
      x =(IMEM[6:0]==7'b0110011 || IMEM[6:0]==7'b0000011 || IMEM[6:0]==7'b0010111 || IMEM[6:0]==7'b0110111 || IMEM[6:0]==7'b0010011) ;
      y =(IWB[6:0]==7'b0110011 || IWB[6:0]==7'b0000011 || IWB[6:0]==7'b0010111 || IWB[6:0]==7'b0110111 || IWB[6:0]==7'b0010011) ;


      if(x && forward) 
                               reg_ref_model_h.write_reg(IMEM[11:7],Wdata2reg_2_MEM);                       
      

      if(y) begin
                          //`uvm_error(get_type_name(),$sformatf("invalid data ! the actual data = %h ,the expected data = %h   inst= %h ",reg31_IWB,Wdata2reg_2_WB,IWB))
                           reg_ref_model_h.write_reg(IWB[11:7],Wdata2reg_2_WB); 
                          if( Wdata2reg_2_WB != reg31_IWB )   
                                          `uvm_error(get_type_name(),$sformatf("invalid data ! the actual data = %h ,the expected data = %h   inst= %h ",reg31_IWB,Wdata2reg_2_WB,IWB))


      end


     



      if(IWB[6:0] == 7'b1101111 || IWB[6:0] == 7'b1100111) 
                      reg_ref_model_h.write_reg(IWB[11:7],Wdata2reg_1);




      if( (PC_IF != PC ) &&  ( IMEM[6:0] == 7'b1100111 || IMEM[6:0] == 7'b1101111))begin
                            `uvm_error(get_type_name(),$sformatf("invalid data ! the actual data = %h ,the expected data = %h    inst = %h   ",PC_IF,PC,IMEM))
                           //reg_ref_model_h.print_reg();
      end




      if( ( IWB[6:0] == 7'b1100111 || IWB[6:0] == 7'b1101111)  && (reg_ref_model_h.read_reg(IWB[11:7]) !=  reg31_IWB)  )begin
                             `uvm_error(get_type_name(),$sformatf("invalid data ! the actual data = %h ,the expected data = %h    inst = %h   ",reg31_IWB,reg_ref_model_h.read_reg(IWB[11:7]),IWB))
                          // reg_ref_model_h.print_reg();
      end




      if( (PC_IF != PC) && (IMEM[6:0] == 7'b1100011))begin
                            `uvm_error(get_type_name(),$sformatf("invalid data ! the actual data = %h ,the expected data = %h    inst = %h   ",PC_IF,PC,IMEM))
                             reg_ref_model_h.print_reg();
      end




/*$display("IF = %h",IF); 
$display("ID = %h",ID);
$display("IEXE = %h",IEXE);
$display("IMEM = %h",IMEM);
$display("IWB = %h",IWB); */




    if(IEXE[6:0]==7'b0110011 ) begin 
    
        logic[31:0] rs1,rs2,rd;
        rs1 = reg_ref_model_h.read_reg(IEXE[19:15]);
        rs2 = reg_ref_model_h.read_reg(IEXE[24:20]);

        if(IEXE[31:25]==7'b0000000) begin 
            
         case(IEXE[14:12])  

             3'b000: rd = rs1 + rs2;
             3'b001: rd =  rs1 <<  rs2;
             3'b010: rd = (rs1 <   rs2);
             3'b011: rd = (rs1 <   rs2);
             3'b100: rd =  rs1 ^ rs2;
             3'b101: rd =  rs1 >>  rs2;
             3'b110: rd =  rs1 |   rs2;
             3'b111: rd =  rs1 &   rs2;

 
           endcase

        end



       else if (IEXE[31:25]==7'b0100000) begin 

        logic[31:0] rs1,rs2,rd;
        rs1 = reg_ref_model_h.read_reg(IEXE[19:15]);
        rs2 = reg_ref_model_h.read_reg(IEXE[24:20]);

         case(IEXE[14:12])  

             3'b000: rd =  rs1 - rs2;
             3'b101: rd =  rs1 >>> rs2;

           endcase

       end



      else if (IEXE[31:25] == 7'b0000001) begin

       logic[63:0] temp;             

       case (IEXE[14:12])
             3'b000: temp = rs1 * rs2;                           // MUL: multiply (lower 32 bits)
             3'b001: temp = (rs1 * rs2) ;                  // MULH: multiply high signed signed (upper 32 bits)
             3'b010: temp = rs1 * $unsigned(rs2) ; // MULHSU: multiply high signed unsigned (upper 32 bits)
             3'b011: temp = $unsigned(rs1) * $unsigned(rs2) ; // MULHU: multiply high unsigned unsigned (upper 32 bits)
             3'b100: temp = $signed(rs1) / $signed(rs2);         // DIV: divide (signed)
             3'b101: temp = rs1 / rs2;                           // DIVU: divide (unsigned)
             3'b110: temp = $signed(rs1) % $signed(rs2);         // REM: remainder (signed)
             3'b111: temp = rs1 % rs2;                           // REMU: remainder (unsigned)
         endcase
        
        if( IEXE[14:12]==3'b010 || IEXE[14:12]==3'b011 || IEXE[14:12]==3'b001)
             rd = temp[63:32];
        else
             rd = temp;

    end


          Wdata2reg_2_EXE = rd;


  end

  






else if (IEXE[6:0] == 7'b0000011) begin
    logic[31:0] rs1, rs2, rd, address;
    logic[7:0] mem_byte;
    logic[15:0] mem_halfword;
    logic[31:0] mem_word;

    rs1 = reg_ref_model_h.read_reg(IEXE[19:15]);
    address = rs1 + {{20{IEXE[31]}}, IEXE[31:20]}; // Sign extension

    case (IEXE[14:12] && (address > -1))

        3'b000: begin // LB: Load Byte
            mem_byte = mem_ref_model_h.read_mem(address, 8);
            rd = {{24{mem_byte[7]}}, mem_byte}; // Sign extension
        end

        3'b001: begin // LH: Load Halfword
            mem_halfword = mem_ref_model_h.read_mem(address, 16);
            rd = {{16{mem_halfword[15]}}, mem_halfword}; // Sign extension
        end

        3'b010: begin // LW: Load Word
            mem_word = mem_ref_model_h.read_mem(address, 32);
            rd = mem_word;
        end

        3'b100: begin // LBU: Load Byte Unsigned
            mem_byte = mem_ref_model_h.read_mem(address, 8);
            rd = {24'b0, mem_byte}; // Zero extension
        end

        3'b101: begin // LHU: Load Halfword Unsigned
            mem_halfword = mem_ref_model_h.read_mem(address, 16);
            rd = {16'b0, mem_halfword}; // Zero extension
        end

    endcase

    if (address < 0)
        rd = 0;

    Wdata2reg_2_EXE = rd;
end





     else if (IEXE[6:0] == 7'b0010011 ) begin

        logic[31:0] rs1,rs2,rd;
        rs1 = reg_ref_model_h.read_reg(IEXE[19:15]);

        case (IEXE[14:12])
            3'b000: rd = rs1 + SignExt(IEXE[31:20]);              // ADDI
            3'b001: rd = rs1 << IEXE[24:20];                      // SLLI
            3'b010: rd = (rs1 < SignExt(IEXE[31:20]));            // SLTI
            3'b011: rd = (rs1 < $unsigned(SignExt(IEXE[31:20]))); // SLTIU
            3'b100: rd = rs1 ^ SignExt(IEXE[31:20]);              // XORI
            3'b101: begin
                if (IEXE[31:25] == 7'b0000000)
                    rd = rs1 >> IEXE[24:20];                      // SRLI
                else if (IEXE[31:25] == 7'b0100000)
                    rd = rs1 >>> IEXE[24:20];                     // SRAI
            end
            3'b110: rd = rs1 | SignExt(IEXE[31:20]);              // ORI
            3'b111: rd = rs1 & SignExt(IEXE[31:20]);              // ANDI
        endcase
 
          Wdata2reg_2_EXE = rd;


    end 


      else if (IEXE[6:0] == 7'b0010111 ) begin 
                   logic[31:0] rs1,rs2,rd;
                   rd = {IEXE[31:12], 12'b0} + PC_IEXE;                // AUIPC
                   reg_ref_model_h.write_reg(IEXE[11:7],rd);
  
          Wdata2reg_2_EXE = rd;


    end



    else if (IEXE[6:0] == 7'b0110111 ) begin
        logic[31:0] rd;
        rd = {IEXE[31:12], 12'b0};                     // LUI: Load Upper Immediate
        reg_ref_model_h.write_reg(IEXE[11:7],rd);

        Wdata2reg_2_EXE = rd;


    end

 

    // S-type instructions (Store operations)
     if (IMEM[6:0] == 7'b0100011) begin
        logic[31:0] rs1,rs2,rd,address;
        rs1 = reg_ref_model_h.read_reg(IMEM[19:15]);
        rs2 = reg_ref_model_h.read_reg(IMEM[24:20]);
        address = rs1 + SignExt({IMEM[31:25], IMEM[11:7]});

        case (IMEM[14:12])
            3'b000: begin 
                         mem_ref_model_h.write_mem(address,8,rs2[7:0]);   // SB: Store Byte
                         if(Wdata_IMEM[7:0] != rs2[7:0])
                                  `uvm_error(get_type_name(),$sformatf("invalid data ! the actual data = %h ,the expected data = %h   inst = %h",Wdata_IMEM[7:0],rs2[7:0],IMEM))

                    end


            3'b001: begin 
                        mem_ref_model_h.write_mem(address,16,rs2[15:0]); // SH: Store Halfword
                         if(Wdata_IMEM[15:0] != rs2[15:0])
                                  `uvm_error(get_type_name(),$sformatf("invalid data ! the actual data = %h ,the expected data = %h  inst = %h",Wdata_IMEM[15:0],rs2[15:0],IMEM))

                    end

            3'b010: begin 
                        mem_ref_model_h.write_mem(address,32,rs2);       // SW: Store Word
                         if(Wdata_IMEM != rs2)
                                  `uvm_error(get_type_name(),$sformatf("invalid data ! the actual data = %h ,the expected data = %h   inst = %h",Wdata_IMEM,rs2,IMEM))

                    end


        endcase




    end

 
    // B-type instructions (Branch operations)
     if (IEXE[6:0] == 7'b1100011) begin
        logic[31:0] rs1,rs2,rd,BTA;
        rs1 = reg_ref_model_h.read_reg(IEXE[19:15]);
        rs2 = reg_ref_model_h.read_reg(IEXE[24:20]);
        BTA = PC_IEXE + {{20{IEXE[31]}}, IEXE[7], IEXE[30:25], IEXE[11:8], 1'b0};

        case (IEXE[14:12])
            3'b000: if (rs1 == rs2) PC = BTA; else  PC=PC_IEXE+12;       // BEQ: Branch if Equal
            3'b001: if (rs1 != rs2) PC = BTA; else  PC=PC_IEXE+12;         // BNE: Branch if Not Equal
            3'b100: if ($signed(rs1) < $signed(rs2)) PC = BTA; else  PC=PC_IEXE+12; // BLT: Branch if Less Than
            3'b101: if ($signed(rs1) >= $signed(rs2)) PC = BTA; else  PC=PC_IEXE+12;// BGE: Branch if Greater or Equal
            3'b110: if ($unsigned(rs1) < $unsigned(rs2)) PC = BTA; else  PC=PC_IEXE+12;// BLTU: Branch if Less Than Unsigned
            3'b111: if ($unsigned(rs1) >= $unsigned(rs2)) PC = BTA; else  PC=PC_IEXE+12;// BGEU: Branch if Greater or Equal Unsigned
            
        endcase
   


                          
        if(PC == BTA)  begin 

          ID =32'bx;
          IF=32'bx;
          PT=1;

       end




end


    // I-type instruction (Jump and Link Register)
    else if (IEXE[6:0] == 7'b1100111) begin
        logic[31:0] rs1,rs2,rd;
        rs1 = reg_ref_model_h.read_reg(IEXE[19:15]);
        rd = PC_IEXE + 4;
        PC = rs1 + SignExt(IEXE[31:20]);               // JALR: Jump and Link Register
        Wdata2reg_1 = rd;
        ID =32'bx;
        IF=32'bx;
        PT=1;



        
    end

    // J-type instruction (Jump and Link)
    else if (IEXE[6:0] == 7'b1101111) begin
        logic[31:0] rs1,rs2,rd;
        rd = PC_IEXE + 4;
        PC = PC_IEXE + {{12{IEXE[31]}}, IEXE[19:12], IEXE[20], IEXE[30:21], 1'b0}; // JAL: Jump and Link
        Wdata2reg_1 = rd;
        ID =32'bx;
        IF=32'bx;
        PT=1;




  end



end
  


endtask:run_phase






// Function to Sign Extend
function [31:0] SignExt;
    input [11:0] imm;
    SignExt = {{20{imm[11]}}, imm};
endfunction




// Function to Zero Extend
function [31:0] ZeroExt;
    input [15:0] imm;
    ZeroExt = {16'b0, imm};
endfunction














endclass:Scoreboard 
