module Controle(
        input wire _clock,
        input wire [31:0] _instrucao,
        output reg [3:0] _ula_op,
        output reg [2:0] _mem_control,
        output reg [1:0] _reg_dest,
        output reg [24:0] _imediato
);

always@(*) 
begin

//_imediato <= { 7'b0000000, _instrucao[24:0] };
_imediato = _instrucao[24:0];
_reg_dest = _instrucao[28:27]; //selecionado campo fonteA da instrucao
_mem_control = 3'b000; //Nos casos de ULA, setar em 0


case(_instrucao[31:29])
    
    3'b000: //Adição
        _ula_op =  4'b1000;

    3'b001: //Subtração
        _ula_op =  4'b0100;
        
    3'b010: //Divisão
        _ula_op =  4'b0001;
    
    3'b011: //MUultiplicação
        _ula_op =  4'b0010;

    3'b100: //Memory Clear
        _mem_control = _instrucao[31:29]; //selecionado opcde

    3'b110: //Memory Read
        _mem_control = _instrucao[31:29]; //selecionado opcde
    
    3'b111: //Memory Write
        _mem_control = _instrucao[31:29]; //selecionado opcde

endcase

case(_instrucao[31:29])

    3'b110: //Memory Read
        _reg_dest = _instrucao[26:25]; //selecionado campo dest da instrucao

endcase

end


endmodule