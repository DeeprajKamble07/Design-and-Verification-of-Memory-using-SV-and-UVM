class driver extends uvm_driver #(seq_item);
  `uvm_component_utils(driver)
  virtual intf vif;
  seq_item item;
  function new(string name="driver",uvm_component parent=null);
    super.new(name,parent);
    `uvm_info("driver class","inside constructor",UVM_HIGH);
  endfunction
  
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    `uvm_info("driver class","inside build phase",UVM_HIGH);
    if(!(uvm_config_db #(virtual intf)::get(this,"*","vif",vif)))
      begin
        `uvm_info("drv","failed to get vif from congif db",UVM_HIGH);
      end
  endfunction
  
  function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
    `uvm_info("driver class","inside connect phase",UVM_HIGH);
  endfunction
  
   task run_phase(uvm_phase phase);
    super.run_phase(phase);
    `uvm_info("driver class","inside run phase",UVM_HIGH);
    forever  begin
    item=seq_item::type_id::create("item");
      seq_item_port.get_next_item(item);
      drive(item);
      seq_item_port.item_done();
    end
  endtask
      
      task drive(seq_item item);
        #40;
        vif.wen<=item.wen;
        vif.wdata<=item.wdata;
        vif.addr<=item.addr;
      endtask
        
endclass
