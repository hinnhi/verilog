/*
Conway's Game of Life is a two-dimensional cellular automaton.

The "game" is played on a two-dimensional grid of cells, where each cell is either 1 (alive) or 0 (dead). 
At each time step, each cell changes state depending on how many neighbours it has:

- 0-1 neighbour: Cell becomes 0.
- 2 neighbours: Cell state does not change.
- 3 neighbours: Cell becomes 1.
- 4+ neighbours: Cell becomes 0.

The game is formulated for an infinite grid. In this circuit, we will use a 16x16 grid. 
To make things more interesting, we will use a 16x16 toroid, where the sides wrap around to the other side of the grid. 
For example, the corner cell (0,0) has 8 neighbours: (15,1), (15,0), (15,15), (0,1), (0,15), (1,1), (1,0), and (1,15). 
The 16x16 grid is represented by a length 256 vector, where each row of 16 cells is represented by a sub-vector: q[15:0] 
is row 0, q[31:16] is row 1, etc. (This tool accepts SystemVerilog, so you may use 2D vectors if you wish.)

- load: Loads data into q at the next clock edge, for loading initial state.
- q: The 16x16 current state of the game, updated every clock cycle.

The game state should advance by one timestep every clock cycle.
*/

module rule (
    input [7:0] neigh,
    input current,
    output next );

    wire [2:0] pop;
    assign pop = {2'b00, neigh[0]} +
                 {2'b00, neigh[1]} +
                 {2'b00, neigh[2]} +
                 {2'b00, neigh[3]} +
                 {2'b00, neigh[4]} +
                 {2'b00, neigh[5]} +
                 {2'b00, neigh[6]} +
                 {2'b00, neigh[7]}; 
    
    reg tmp;
    assign next = tmp;

    always @(*) begin
        case (pop)
            2: tmp = current;
            3: tmp = 1;
            default: tmp = 0;
        endcase
    end
endmodule

module top_module(
    input clk,
    input load,
    input [255:0] data,
    output [255:0] q ); 
	
    wire [255:0] next;
    
    genvar x, y;
    generate
        for (x=0; x<=15; x=x+1) begin : gen_x
            for (y=0; y<=15; y=y+1) begin : gen_y
                rule fate (
                    .neigh({q[(x==0 ? 15 : x-1) + (y==0 ? 15 : y-1)*16],
                            q[(x==0 ? 15 : x-1) + y                *16],
                            q[(x==0 ? 15 : x-1) + (y==15 ? 0 : y+1)*16],
                            q[x                 + (y==0 ? 15 : y-1)*16],
                            q[x                 + (y==15 ? 0 : y+1)*16],
                            q[(x==15 ? 0 : x+1) + (y==0 ? 15 : y-1)*16],
                            q[(x==15 ? 0 : x+1) + y                *16],
                            q[(x==15 ? 0 : x+1) + (y==15 ? 0 : y+1)*16]}),
                    .current(q[(x + y*16)]),
                    .next(next[(x + y*16)])
                );
            end
        end
    endgenerate
    
    always @(posedge clk) begin
        if (load) begin
            q <= data;
        end else begin
            q <= next;
        end
    end
endmodule
