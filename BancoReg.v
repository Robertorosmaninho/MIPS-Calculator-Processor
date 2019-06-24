module BancoReg(Clock,IdReg, Fonte1, Fonte2, Escrita, Dado, DadoLido1, DadoLido2); 

  //Clock
  input Clock;

  //Portas I/O
  input [1:0] IdReg, Fonte1, Fonte2;
  input Escrita;
  input [31:0] Dado; 
  output reg [31:0] DadoLido1, DadoLido2;

  //Declaração dos Registradores
  reg [31:0] RegFonteA; //Registrador de 32Bits - Registrador 0
  reg [31:0] RegFonteB; //Registrador de 32Bits - Registrador 1
  reg [31:0] RegAcumulador; //Registrador de 32Bits - Registrador 2


  //Borda de Decida
  always@(negedge Clock) begin

    //Corpo - Escrita
    if(Escrita == 1) begin
      case(IdReg) 
        2'b00: //Escreve no Registrador 0
          RegFonteA = Dado; 
        2'b01: //Escreve no Registrador 1
          RegFonteB= Dado;
        2'b10: //Escreve no Registrador 2
          RegAcumulador = Dado; 
      endcase
    end
  end

  //Borda de Subida
  always@(posedge Clock) begin

    //Corpo - Leitura
      if(Escrita == 0) begin
        case(Fonte1) //A partiri dessa parte funciona
          2'b00: //Lê Registrador 0
            DadoLido1 = RegFonteA;
          2'b01: //Lê Registrador 1
            DadoLido1 = RegFonteB;
          2'b10: //Lê Registrador 2
            DadoLido1 = RegAcumulador;
        endcase

        case(Fonte2)
          2'b00: //Lê Registrador 0
            DadoLido2 = RegFonteA;
          2'b01: //Lê Registrador 1
            DadoLido2 = RegFonteB;
          2'b10: //Lê Registrador 2
            DadoLido2 = RegAcumulador;
        endcase

      end
  end
endmodule
