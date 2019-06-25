module Ula(
        input [31:0] _op1,_op2,  // ULA 32-bits operandos 
        input [3:0] _opcao,// ULA operador
        input _clock,  // clock
        // output _CarryOut, (ideia)
        output reg [31:0] _result //ULA result
    );


    always @(posedge _clock)
    begin
        case(_opcao)

            4'b0001: // Divisão
                _result = _op1 / _op2; 

            4'b0010: // Multiplicação
                _result = _op1 * _op2; 
                    
            4'b0100: // Subtração
                _result = _op1 - _op2; 
                    
            4'b1000: // Adição
                _result = _op1 + _op2; 

        endcase
    end

endmodule
