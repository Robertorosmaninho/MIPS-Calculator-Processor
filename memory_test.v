module memory_test()
 
    wire Op2En,Op2RW;
    wire[31:0] ReadPC,ReadWriteAddr,DataWrite;

 output reg[31:0] Data,Instruction;

    //instanciating 
    memory_test(
         .Op2En(Op2En);
         .Op2Rw(Op2RW);
         .ReadPC(ReadPC);
         .ReadWriteAddr(ReadWriteAddr);
         .Data(Data)
         .Instruction(Instruction));

//setting the clock
always
begin
    clk = 1; #10;
    clk = 0; #10;
end

//initial test
initial
   begin
      $readmemb("memory.txt", memory);
       ReadWriteAddr = 5'b00000; ReadPC = 5'b00000; Op2En = 1; Op2RW = 0; #20;
       ReadWriteAddr = 5'b00000; ReadPC = 5'b00000; Op2En = 0; Op2RW = 1; #20;

       ReadWriteAddr = 5'b00001; ReadPC = 5'b00001; Op2En = 1; Op2RW = 0; #20;
       ReadWriteAddr = 5'b00001; ReadPC = 5'b00001; Op2En = 0; Op2RW = 1; #20;

       ReadWriteAddr = 5'b00010; ReadPC = 5'b00010; Op2En = 1; Op2RW = 0; #20;
       ReadWriteAddr = 5'b00010; ReadPC = 5'b00010; Op2En = 0; Op2RW = 1; #20;

$stop;
//end of tests
end
endmodule
