module BancoReg_TestBench;

  //Variaveis necessárias para iniciar o banco de registrador
  reg  [1:0] _id, _f1, _f2;
  reg  _escrita;
  reg  [31:0] _dado;
  wire [31:0] _dl1, _dl2;
  reg clk;


 //Instanciando o Banco de Registrador
  BancoReg banco (.Clock(clk),
                  .IdReg(_id), .Fonte1(_f1), .Fonte2(_f2),
                  .Escrita(_escrita),
                  .Dado(_dado),
                  .DadoLido1(_dl1), .DadoLido2(_dl2));


//Gerando arquivo vara vizualição no GTKWave
  initial begin
    $dumpfile("BancoReg.vcd");
    $dumpvars(0, BancoReg_TestBench);
  end


  //Testamos a lógica aqui
  initial begin

    //Insere as variáveis
    _escrita = 1; #0;
    _id = 2'b00; #0;
    _dado = #0 32'b00000000000000000000011111100011; 

   //Escreve as variaveis na descida do clock
   clk = #5 1'b0;

   //Insirimos as variáveis
   clk = #0 1'b0;
   _escrita = 0; #5;
   _f1 = 2'b00; #5;

   //Lemos as variáveis na subida do clock
     clk = #0 1'b1;

  end
 
endmodule
