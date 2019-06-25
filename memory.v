module Memoria(clk,ReadPC,ReadWriteAddr,DataWrite,Op2En,Op2RW,Instruction,Data);

  input  Op2En,Op2RW,clk;
  input [31:0] ReadPC,ReadWriteAddr,DataWrite;

  output reg[31:0]  Data,Instruction;

  //reading memory content
  initial $readmemh("memory.txt", memory);
    integer i;
    reg [31:0] memory[1023:0];

  initial begin
    $display("results: ");
    for(i=0;i<4;i=i+1)
      $display("%d:%h",i,memory[i]);
    end     

  always@(*) begin
    //if a second operation is to be operated in memory at high level
    if(Op2En == 1'b1) begin
      //a read of memory at low level
      if(Op2RW == 1'b0) begin
        Data = memory[ReadWriteAddr+100];
      end 
      else begin
      //a write at high level
        memory[ReadWriteAddr+100] = DataWrite;
       end
    end
    Instruction = memory[ReadPC];
  end

endmodule
