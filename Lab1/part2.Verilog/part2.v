// Reset with SW[0]. Clock counter and memory with KEY[0]. Clock
// each instuction into the processor with KEY[1]. SW[9] is the Run input.
// Use KEY[0] to advance the memory as needed before each processor KEY[1]
// clock cycle.
module part2 (KEY, SW, LEDR);
	input [1:0] KEY;
	input [9:0] SW;
	output [9:0] LEDR;	

	wire Done, Resetn, PClock, MClock, Run;
	wire [8:0] DIN, Bus;
	wire [4:0] pc;

	assign Resetn = SW[0];
	assign MClock = KEY[0];
	assign PClock = KEY[1];
	assign Run = SW[9];

	// module proc(DIN, Resetn, Clock, Run, Done, BusWires);
	proc U1 (DIN, Resetn, PClock, Run, Done, Bus);
	assign LEDR[8:0] = Bus;
	assign LEDR[9] = Done;

	// you have to generate the inst_mem.v file by using the Quartus software
	inst_mem U2 (pc, MClock, DIN);
	count5 U3 (Resetn, MClock, pc);

endmodule

module count5 (Resetn, Clock, Q);
	input Resetn, Clock;
	output reg [4:0] Q;

	always @ (posedge Clock, negedge Resetn)
		if (Resetn == 0)
			Q <= 5'b00000;
		else
			Q <= Q + 1'b1;
 endmodule
