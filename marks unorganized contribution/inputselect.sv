module inputselect (	input logic clk,
							input logic next,
							input logic prev,
							output logic [1:0] sel);
							
	typedef enum logic [1:0] {A, B, C} estate;
	estate currentState, nextState;
	
	always_ff@(posedge clk)
		currentState = nextState;
	
	always_comb
		case(currentState)
			A:	if (next)		nextState = B;
				else if (prev)	nextState = C;
				else				nextState = A;
			
			B:	if (next)		nextState = C;
				else if (prev) nextState = A;
				else				nextState = B;
			
			C: if (next)		nextState = A;
				else if (prev)	nextState = B;
				else				nextState = C;
			
			default:				nextState = A;
		endcase
		
	assign sel = currentState;
		
endmodule