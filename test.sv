class test extends uvm_test;
  `uvm_component_utils(test)
  enivornment env;
  wr_seq wrseq;
  rd_seq rdseq;
  function new(string name="test",uvm_component parent=null);
    super.new(name,parent);
    `uvm_info("test class","inside constructor",UVM_HIGH);
  endfunction
  
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    `uvm_info("test class","inside build phase",UVM_HIGH);
    env=enivornment::type_id::create("env",this);
  endfunction
  
  function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
    `uvm_info("test class","inside connect phase",UVM_HIGH);
  endfunction
  
  task run_phase(uvm_phase phase);
    super.run_phase(phase);
    `uvm_info("test class","inside run phase",UVM_HIGH);
    phase.raise_objection(this);
    repeat(32)
      begin
    wrseq=wr_seq::type_id::create("wrseq");
    wrseq.start(env.agen.sqnr);
      end
    #10;
    repeat(32)
      begin
    rdseq=rd_seq::type_id::create("rdseq");
    rdseq.start(env.agen.sqnr);
      end
    phase.drop_objection(this);
  endtask
endclass
