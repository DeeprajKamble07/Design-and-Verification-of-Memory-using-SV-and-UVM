module memory(clk,rst,wen,wdata,addr,rdata);
  parameter width=8;
  parameter depth=8;
  parameter addr_width=$clog2(depth);
  
  input clk,rst,wen;
  input [width-1:0] wdata;
  input [addr_width-1:0] addr;
  output reg [width-1:0] rdata;
  
  reg [width-1:0] mem[0:depth-1];
  
  always@(posedge clk)
    begin
    if(rst)
      begin
        rdata<=0;
        for(int i=0;i<depth;i++) 
          mem[i]<=0;
    end
    end
  
  always@(posedge clk)
    begin
      if(wen)
        mem[addr]<=wdata;
      else
        rdata<=mem[addr];
    end
endmodule
