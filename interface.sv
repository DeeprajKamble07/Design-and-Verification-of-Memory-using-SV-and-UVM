interface intf(input logic clk,rst);
  logic wen;
  logic [2:0] addr;
  logic [7:0] wdata,rdata;
  
  
  clocking drvcb @(posedge clk);
    output wen,addr,wdata;
    input rdata;
  endclocking
  
  clocking moncb @(posedge clk);
    input wen,addr,wdata,rdata;
  endclocking
  
  modport drvmod(clocking drvcb);
    modport monmod(clocking moncb);
  
endinterface
