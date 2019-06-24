`include "ula.v"
`include "Memoria.v"
`include "controle.v"
`include "BancoRegistradores.v"

module DATAPATH(
    input wire _clock,
)

reg [31:0] PC;

initial begin
    PC = 32'b11111111111111111111111111111111;
end

always @( posedge _clock ) begin
    PC = PC + 1;
end

//Modulos da instrucao
wire [31:0] instrucao;
wire [2:0] opcode;
wire [1:0] fonteA;
wire [1:0] dest;
wire [24:0] imediato;

//Modulos do Controle
wire reg_dest;
wire mem_op;
wire mem_control;
wire [3:0] ula_op;

//Registradores
wire[31:0] ula_result;
wire[31:0] regA;
wire[31:0] regB;
wire[31:0] loadReg;
reg[31:0] Imediato;

Memoria memoria(_clock, PC ,ula_result, regA, mem_control, mem_op, instrucao, loadReg);
CONTROLE controle(_clock,opcode,ula_op,mem_op,mem_control,reg_dest);

//fazer todos os caminhos possíveis e chamar as funções necessárias
//por exemplo, uma função MR vai precisar chamar a memória dnovo;

if(precisar ir pra memoria) -> 
    Memoria memoria(_clock, PC ,ula_result, regA, mem_control, mem_op, instrucao, loadReg);
else{
BancoRegistradores registradores(_clock,dest,reg_dest,ula_result,fonteA,fonteA,regA,regB);
ULA Ula(_clock,regA,Imediato,ula_op,ula_result);
}

//HCT
always @(*) begin
    if(opcode == 3'b101) begin
        $finish;
    end
end


endmodule