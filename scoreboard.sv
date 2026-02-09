class scoreboard extends uvm_scoreboard;
  `uvm_component_utils(scoreboard)
  seq_item queue[$];
  bit [7:0] sc_mem [0:7];
  bit [7:0] rd_data;
  uvm_analysis_imp #(seq_item,scoreboard) scoreboard_port;
  function new(string name="scoreboard",uvm_component parent=null);
    super.new(name,parent);
    scoreboard_port=new("scoreboard_port",this);
    `uvm_info("scoreboard class","inside constructor",UVM_HIGH);
  endfunction
  
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    `uvm_info("scoreboard class","inside build phase",UVM_HIGH);
  endfunction
  
  function void write(seq_item item);
    queue.push_back(item);
  endfunction
  
  function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
    `uvm_info("scoreboard class","inside connect phase",UVM_HIGH);
  endfunction
  
  task run_phase(uvm_phase phase);
    super.run_phase(phase);
    `uvm_info("scoreboard class","inside run phase",UVM_HIGH);
    forever begin 
      seq_item ex_item;
      wait(queue.size()>0)
      ex_item=queue.pop_front();
      if(ex_item.wen==1)
        begin 
          sc_mem[ex_item.addr]=ex_item.wdata;
          `uvm_info("SCB", $sformatf("WRITE: Data=%0h Addr=%0h",ex_item.wdata, ex_item.addr), UVM_MEDIUM);
            end
          
      else
      begin 
        if(sc_mem[ex_item.addr]==ex_item.rdata)
          begin
            `uvm_info("SCB", $sformatf("READ: Data=%0h Addr=%0h",ex_item.rdata, ex_item.addr), UVM_MEDIUM);
            `uvm_info("SCB",$sformatf("PASS acual data:%0h expected data=%0h addr=%0h",sc_mem[ex_item.addr],ex_item.rdata,ex_item.addr),UVM_LOW);
          end
   
        else
          begin
            `uvm_info("SCB", $sformatf("READ: Data=%0h Addr=%0h",ex_item.rdata, ex_item.addr), UVM_MEDIUM);
            `uvm_error("SCB",$sformatf("FAIL acual data:%0h expected data=%0h addr=%0h",sc_mem[ex_item.addr],ex_item.rdata,ex_item.addr));
          end
      end
    end
  endtask
endclass
