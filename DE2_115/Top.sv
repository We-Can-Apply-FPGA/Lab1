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

parameter CNT_MAX = 6'b111111;
parameter IDLE    = 6'b000001;
parameter FINISH  = 6'b000110;


/*================================================================*
 * REG/WIRE declarations
 *================================================================*/
reg [5:0] cur_peak_cnt;
//reg [5:0] next_peak_cnt;
reg [5:0] cur_state;
reg [5:0] next_state;
reg active;
reg next_active;

/*================================================================*
 * Module
 *================================================================*/

/*============== ==================================================*
 * Combinational circuit
 *================================================================*/
//next state logic
always @(*)begin
	//cur_peak_cnt = next_peak_cnt;
	//cur_state   = next_state;
	//
	if (active == next_active)begin //non-active
		cur_state = IDLE;
	end else begin
		if (cur_state == FINISH)begin
			active = next_active;
			cur_state = IDLE;
		end else
			if (cur_peak_cnt == (2 << cur_state))begin
				cur_state = next_state;
			end
		end
	end
end
/*=============== =================================================*
 * Sequential circuit
 *================================================================*/
always @(posedge i_clk) begin
	//if (cur_state)
	if(active != next_active)begin //active
		cur_peak_cnt <= cur_peak_cnt + 1;
	end else //non-active
		cur_peak_cnt <= 6'b000001;
	end
end

//Means the user press the button
always @(posedge i_start) begin
    active <= ~next_active; //inverse to activate
end
/*================================================================*
 * Output circuit
 *================================================================*/
always @(*)begin
	//send a signal to a random generator
	if (cur_peak_cnt == (2 << cur_state) && (cur_state != FINISH))
		o_send_rngen = 1'b0;
	else
		o_send_rngen = 1'b1;
end
	
endmodule:Top
