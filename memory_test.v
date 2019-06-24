module memory_test();
    
 wire Op2En,Op2RW;
 reg [31:0] ReadPC,ReadWriteAddr,DataWrite;

 wire [31:0] Data,Instruction;
 reg [31:0] _memory[1023:0];

reg _clk;
    //instanciating 
Memoria memory(.clk(_clk),
         .Op2En(Op2En),
         .Op2RW(Op2RW),
         .ReadPC(ReadPC),
         .ReadWriteAddr(ReadWriteAddr),
         .Data(Data),
         .Instruction(Instruction));

//setting the clock
always
begin
    _clk = 1; #10;
    _clk = 0; #10;
end

initial begin
  $dumpfile("Memory.vcd");
  $dumpvars(0, memory_test);
end

//initial test
initial
   begin
      $readmemh("memory.txt", _memory);
       ReadWriteAddr[31:0] <= 5'b0;
      // Op2En <= 1'b1; Op2RW <=1'b0;
       #20;
       ReadWriteAddr[31:0] <= 5'b0;
      //Op2En <= 1'b0; Op2RW <= 1'b1;
        #20;

      // ReadWriteAddr = 5'b1; Op2En = 1; Op2RW = 0; #20;
      // ReadWriteAddr = 5'b1; Op2En = 0; Op2RW = 1; #20;

       //ReadWriteAddr = 5'b10; Op2En = 1; Op2RW = 0; #20;
       //ReadWriteAddr = 5'b10; Op2En = 0; Op2RW = 1; #20;
$stop;
//end of tests
end
endmodule
