module Top(
/*parameter*/
	input i_clk,
	input i_start,
	output o_send_rngen
);

/*================================================================*
 * PARAMETER declarations
 *================================================================*/
//input rst_n;

parameter IDLE   = 6'2000000;
parameter START  = 6'2000001;
parameter FINISH = 6'2000110';

/*================================================================*
 * REG/WIRE declarations
 *================================================================*/
reg [6:0] cur_peak_cnt;
reg [6:0] next_peak_cnt;
reg [6:0] curr_state;
reg [6:0] next_state;

/*================================================================*
 * Module
 *================================================================*/

/*============== ==================================================*
 * Combinational circuit
 *================================================================*/
//next state logic
always @(*)begin
	cur_peak_cnt = next_peak_cnt;
	curr_state   = next_state;
	if ((cur_peak_cnt == (2 << curr_state)) && (curr_state != FINISH ))
		next_state = curr_state + 1;
end
/*=============== =================================================*
 * Sequential circuit
 *================================================================*/
always @(posedge i_clk) begin
	if(curr_state != IDLE)
		next_peak_cnt <= cur_peak_cnt + 1;
end

//Means the user press the button
always @(posedge i_start) begin
    next_state    <= START;
	next_peak_cnt <= 6'2000000;
end
/*================================================================*
 * Output circuit
 *================================================================*/
always @(*)begin
	//send a signal to a random generator
	if (cur_peak_cnt == (2 << curr_state) && (curr_state != FINISH))
		o_start_rngen = 1'20;
	else
		o_send_rngen = 1'21;
end
	
endmodule:Top
