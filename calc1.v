//`include "ula.v"
//`include "memory.v"
//`include "controle.v"
//`include "BancoReg.v"

module DataPath(_clock);

input _clock;
reg [31:0] _PC;

//Memoria
//reg [31:0] readwriteAddr;
//reg [31:0] data_write;
//reg op2En;
reg op2Rw;
wire [31:0] instrucao;
wire [31:0] data;

//Controle
wire [1:0]reg_dest;
wire mem_enable;
wire [1:0] mem_control;
wire [3:0] ula_op;
wire [24:0] imediato;

//Banco de Reg
//reg [1:0] id_reg;
//reg [1:0] fonte1;
reg [1:0] fonte2;
reg escrita;
reg [31: 0] dado;
wire [31:0] dado1;
wire [31:0] dado2;

//ULA
//reg [31:0] op1, op2;
//reg [3:0] ula_opcao;
wire [31:0] ula_result;


initial begin
    _PC = 32'b11111111111111111111111111111111; //Inicia o PC com "-1" (Overflow)
    op2En= 1'b0; //Inicia com a leitura em 0 (para pegar so a instrução)
end

always @( posedge _clock ) begin
    _PC = _PC + 1;
end

//Todas as variáveis em X exceto op2En que é  0.
//Assim termos a só instrução na saida.
Memoria memoria(.clk(_clock), .ReadPC(_PC), .ReadWriteAddr(ula_result), 
                .DataWrite(dado1), .Op2En(/*MemOp*/), .Op2RW(/*mem_control*/), 
                .Instruction(instrucao), .Data(data)); 

//Passa a instrução recebida da memória pra o controle
Controle controle(._clock(_clock), ._instrucao(instrucao), ._ula_op(ula_op),
                  ._mem_control(mem_control),._mem_enable(mem_enable),
                  ._reg_dest(reg_dest), ._imediato(imediato));   

BancoReg registradores (.Clock(_clock), .IdReg(reg_dest), .Fonte1(/*OperandoA*/), 
                        .Fonte2(/*OperandoA*/), .Escrita(/*escrita*/), 
                        .Dado(ula_result), .DadoLido1(dado1), .DadoLido2(dado2));

Ula ula(._clock(_clock), ._op1(dado1), ._op2(imediato), ._opcao(ula_op), 
        ._result(ula_result));

  always @(*) begin
    dado1[31:0] <= { 7'b0, imediato[24:0] };
    if(mem_control == 2'b01) begin
        $finish;
    end
  end

endmodule


module ProcessadorTest();

reg clk;

initial begin

end

DataPath process(clk);

initial begin



$dumpfile("calc1.vcd");
$dumpvars;
  clk = 1;
  repeat(6) begin
    #1 clk= ~clk;
  end
  begin 
  $finish;
  end
end


endmodule
