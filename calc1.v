`include "ula.v"
`include "Memoria.v"
`include "controle.v"
`include "BancoRegistradores.v"

module DATAPATH(
    input wire _clock,
)

reg [31:0] PC;

//Memoria
reg [31:0] readwriteAddr;
reg [31:0] data_write;
reg op2En;
reg op2Rw;
wire [31:0] instrucao;
wire [31:0] data;

//Controle
wire reg_dest;
wire mem_enable;
wire [1:0] mem_control;
wire [3:0] ula_op;
wire [24:0] imediato;

//Banco de Reg
reg [1:0] id_reg;
reg [1:0] fonte1;
reg [1:0] fonte2;
reg escrita;
wire [31:0] dado1;
wire [31,0] dado2;

//ULA
reg [31:0] op1, op2;
reg [3:0] ula_op;
wire [31:0] ula_result;


initial begin
    PC = 32'b11111111111111111111111111111111;
    op2En= 1'b0; //pro começo temos q setar leitura em 0 (para pegar so a instrução) e o PC em "-1";
end

always @( posedge _clock ) begin
    PC = PC + 1;
end

Memoria memoria(_clock, PC, readwriteAddr, data_write, op2En, op2Rw, instrucao, data); //op2En em 0 (resto n importa), só interessa instrução na saida
CONTROLE controle(_clock,instrucao,ula_op,mem_control,mem_enable,reg_dest,imediato);   //tentar passar instrução como entrada (n sei se declarado como wire vai dar pra passar assim)

always @(*) begin
    case(mem_enable)
        1'b0: begin //cases em tese só podem ter um comando, então tentei um begin p/ mais comandos
		BancoReg registradores(_clock,dest,reg_dest,ula_result,fonteA,fonteA,regA,regB); 	   //operacoes aritmeticas
		ULA Ula(_clock,regA,Imediato,ula_op,ula_result);					   //ler dado do acumulador e oq fonteA aponta, e fazer a operação
		BancoReg registradores(_clock,dest,reg_dest,ula_result,fonteA,fonteA,regA,regB); 	   //salvar no acumulador
	end

	1'b1: begin //operações de memória
		case(mem_control)
		    2'b01: begin
			$finish //HCT
		    end

		    2'b00:
			Memoria memoria(_clock, PC, readwriteAddr, data_write, op2En, op2Rw, instrucao, data); //zerar memória -> só passar 0 no dado;

		    2'b11: begin
			BancoReg registradores(_clock,dest,reg_dest,ula_result,fonteA,fonteA,regA,regB); //Memory Write
			Memoria memoria(_clock, PC ,ula_result, regA, mem_control, mem_op, instrucao, loadReg);
		    end

		    2'b10: begin
			Memoria memoria(_clock, PC ,ula_result, regA, mem_control, mem_op, instrucao, loadReg); //Memory Read
			BancoReg registradores(_clock,dest,reg_dest,ula_result,fonteA,fonteA,regA,regB);
    	            end
		endcase
	       end
    	endcase    
end


endmodule
