class seq_item extends uvm_sequence_item;
  `uvm_object_utils(seq_item)
  rand logic wen;
  rand logic [2:0] addr;
  rand logic [7:0] wdata;
  
  logic [7:0] rdata;
  
  constraint c1{unique{addr};}
  constraint c2{unique{wdata};}
  
  function new(string name="seq_item");
    super.new(name);
    `uvm_info("seq_item class","inside constructor",UVM_HIGH);
  endfunction
endclass
