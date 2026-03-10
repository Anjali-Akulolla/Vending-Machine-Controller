`timescale 1ns/1ps

module vending_machine_tb;

reg clk;
reg reset;
reg coin5;
reg coin10;
reg [2:0] select;

wire [4:0] dispense;
wire change;

vending_machine vm(
    clk,
    reset,
    coin5,
    coin10,
    select,
    dispense,
    change
);


// clock

initial
begin
clk = 0;
forever #5 clk = ~clk;
end


initial
begin

reset = 1;
coin5 = 0;
coin10 = 0;
select = 0;

#10 reset = 0;


// buy item1 (₹5)

#10 coin5 = 1;
#10 coin5 = 0;
select = 3'b001;


// buy item3 (₹15)

#20 coin10 = 1;
#10 coin10 = 0;

#10 coin5 = 1;
#10 coin5 = 0;

select = 3'b011;


// buy item5 (₹25)

#20 coin10 = 1;
#10 coin10 = 0;

#10 coin10 = 1;
#10 coin10 = 0;

#10 coin5 = 1;
#10 coin5 = 0;

select = 3'b101;


#100 $finish;

end


initial
begin
$dumpfile("vending.vcd");
$dumpvars(0,vending_machine_tb);
end

endmodule
