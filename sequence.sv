class wr_seq extends uvm_sequence;
  `uvm_object_utils(wr_seq)
  seq_item wr_item;
  function new(string name="wr_seq");
    super.new(name);
    `uvm_info("write seq class","inside constructor",UVM_HIGH);
  endfunction
  
  task body();
        wr_item=seq_item::type_id::create("wr_item");
    start_item(wr_item);
    wr_item.randomize() with {wen==1;};
    finish_item(wr_item);
  endtask
endclass



class rd_seq extends wr_seq;
  `uvm_object_utils(rd_seq)
  seq_item rd_item;
  function new(string name="rd_seq");
    super.new(name);
    `uvm_info("read seq class","inside constructor",UVM_HIGH);
  endfunction
  
  task body();
        rd_item=seq_item::type_id::create("rd_item");
    start_item(rd_item);
    rd_item.randomize() with {wen==0; wdata==0;};
    finish_item(rd_item);
  endtask
endclass
