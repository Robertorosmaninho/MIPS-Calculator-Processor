module Memoria(clk,ReadPC,ReadWriteAddr,DataWrite,Op2En,Op2RW,Instruction,Data);

  input Op2En,clk;
  input [1:0] Op2RW;
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
      if(Op2RW == 2'b10) begin
        Data = memory[ReadWriteAddr+100];
      end 
      else if(Op2RW == 2'b11) begin
      //a write at high level
        memory[ReadWriteAddr+100] = DataWrite;
      end
      else if(Op2RW == 2'b00) begin //Memory Clear
        memory[ReadWriteAddr+100] = 32'b0000000000000000000000000000000;
      end
    end
    Instruction = memory[ReadPC];
  end

endmodule
