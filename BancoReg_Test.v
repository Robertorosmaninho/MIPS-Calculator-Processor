module BancoReg_TestBench;
  
  //Variaveis necessárias para iniciar o banco de registrador
  wire [1:0] _id, _f1, _f2;
  wire _escrita;
  wire [31:0] _dado;
  reg  [31:0] _dl1, _dl2;

  //Instanciando o Banco de Registrador
  BancoReg banco (.IdReg(_id), .Fonte1(_f1), .Fonte2(_f2), 
                  .Escrita(_escrita),
                  .Dado(_dado), 
                  .DadoLido1(_dl1), .DadoLido2(_dl2));

  //Gerando arquivo vara vizualição no GTKWave
  initial begin
    $dumpfile("BancoReg.vcd");
    $dumpvars;
  end

  //Inicialiazando o Clock
  initial begin
    clk = 1'b0;
    rst = 1'b1;
    repeat(4) #10 clk = ~clk;
    rst = 1'b0;
    forever #10 clk = ~clk; // Gera clock
  end

  //Testamos a lógica aqui
  initial begin
     //Escrevemos
    _escrita = 1'b1;
    _id = 2'b00;
    _dado = 32'b00000000000000000000011111100011;
    @(negedge rst);
    
    //Lemos
    _escrita = 1'b0;
    _f1 = 2'b00;
    @(posedge rst);
    
    $display(_dl1);
  end

endmodule
