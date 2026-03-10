`timescale 1ns/1ps

module vending_machine(
    input clk,
    input reset,
    input coin5,
    input coin10,
    input [2:0] select,     // item selection
    output reg [4:0] dispense,
    output reg change
);

reg [4:0] balance;
reg [4:0] price;

always @(posedge clk or posedge reset)
begin

if(reset)
begin
balance <= 0;
dispense <= 0;
change <= 0;
end

else
begin

// coin insertion

if(coin5)
balance <= balance + 5;

else if(coin10)
balance <= balance + 10;


// price selection

case(select)

3'b001: price = 5;
3'b010: price = 10;
3'b011: price = 15;
3'b100: price = 20;
3'b101: price = 25;

default: price = 0;

endcase


// vending logic

if(balance >= price && price != 0)
begin

case(select)

3'b001: dispense = 5'b00001;
3'b010: dispense = 5'b00010;
3'b011: dispense = 5'b00100;
3'b100: dispense = 5'b01000;
3'b101: dispense = 5'b10000;

default: dispense = 5'b00000;

endcase

if(balance > price)
change = 1;

balance <= 0;

end

else
begin
dispense <= 0;
change <= 0;
end

end

end

endmodule
