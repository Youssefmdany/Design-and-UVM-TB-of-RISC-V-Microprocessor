`timescale 1ns / 1ns

//////////////////////////////////////////////////////////////////////////////////
// Company: 

// Engineer: Youssef Ahmed
// 
// Create Date:    13/08/2023

// Design Name:    Mult & Div Unit

// Module Name:    Mult_Div_Unit 

// Project Name:   RISC-V

// Target Devices: 

// Tool versions: 

// Description: 
//
//
//////////////////////////////////////////////////////////////////////////////////



module Mult_Div_Unit (
    input logic [31:0] operand1,
    input logic [31:0] operand2,
    input logic [3:0] mul_div_op,
    output logic [31:0] Result
);

    // Extract the first 3 bits from the right (func3)
    logic [2:0] func3;
    assign func3 = mul_div_op[2:0];

    // Intermediate variables for high part of multiplication results
    logic signed [63:0] mul_result_signed;
    logic [63:0] mul_result_unsigned;

    always_comb begin
      
      if(!mul_div_op[3])begin
        case (func3)
            3'b000: Result = operand1 * operand2; // mul: multiply
            3'b001: begin // mulh: multiply high signed signed
                mul_result_signed = $signed(operand1) * $signed(operand2);
                Result = mul_result_signed[63:32];
            end
            3'b010: begin // mulhsu: multiply high signed unsigned
                mul_result_signed = operand1 * $unsigned(operand2);
                Result = mul_result_signed[63:32];
            end
            3'b011: begin // mulhu: multiply high unsigned unsigned
                mul_result_unsigned = operand1 * operand2;
                Result = mul_result_unsigned[63:32];
            end
            3'b100: Result = $signed(operand1) / $signed(operand2); // div: divide signed
            3'b101: Result = operand1 / operand2; // divu: divide unsigned
            3'b110: Result = $signed(operand1) % $signed(operand2); // rem: remainder signed
            3'b111: Result = operand1 % operand2; // remu: remainder unsigned
          //  default: Result = 32'b0; // Default case
        endcase
       end
    end

endmodule

