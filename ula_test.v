`timescale 1ns / 1ps  

module ula_test();

//Inputs
 reg[31:0] A,B;
 reg[3:0] ULA_Sel;

//Outputs
 wire [31:0] ULA_Out;
 //wire CarryOut;

 // Verilog code for ULA
 integer i;
 
 ULA ula(
            ._op1(A),
            ._op2(B),
            ._opcao(ULA_Sel),// ULA Selection
            ._result(ULA_Out) // ULA 8-bit Output
            //CarryOut - Carry Out Flag
     );

    initial begin
        $dumpfile("ula.vcd");
        $dumpvars(0,ula);
    end
    
    initial begin
    // hold reset state for 100 ns.
      A = 8'h0A;
      B = 8'h02;
      ULA_Sel = 4'h0;
      
      for (i=0;i<=15;i=i+1)
      begin
          ULA_Sel = ULA_Sel + 8'h01;
          #10;
      end;
      
      //$display("%d",ULA_Out);
      //$monitor("Resultado = %h (%0d)", ULA_Out, ULA_Out");

      A = 8'hF6;
      B = 8'h0A;
      
    end
endmodule