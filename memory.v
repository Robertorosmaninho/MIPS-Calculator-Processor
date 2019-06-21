module Memoria(clk,ReadPC,ReadWriteAddr,Op2En,Op2RW,Instruction,Data);

input wire Op2En,Op2RW,clk;
input wire[31:0] ReadPC,ReadWriteAddr;


output reg[31:0]  Data,Instruction;
//reading memory content
initial $readmemh("memory.txt", memory);
integer i;
reg [31:0] memory[1023:0];
initial 
     begin

         $display("results: ");
         for(i=0;i<4;i=i+1)
         $display("%d:%h",i,memory[i]);
end     

always@(*)
begin
    if(Op2En == 1'b1) 
    begin
        if(Op2RW == 1'b0) 
        begin
            Data = memory[ReadWriteAddr];
        end
        
    end

    Instruction = memory[ReadPC];
end


endmodule