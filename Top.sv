module Top(
	input i_clk,
	input i_start,
	input [17:0] i_sw,
	output [6:0] o_random_out
);

	reg sw = 0;
	parameter SHOW_NUM = 15;
	integer run_num = 0, randn = 1234;
	reg[31:0] rdm, counter_total = 0, counter = 0, delay;
	
	always @(negedge i_start) begin
		sw <= ~sw;
	end

	always @(*) begin
		if (sw == 1) begin
			if (run_num == SHOW_NUM && i_sw[17])
				o_random_out = i_sw[16:10];
			else
				if (i_sw == 0)
					o_random_out = rdm % 99 + 1;
				else
					o_random_out = (rdm % i_sw[6:0]) + 1;
		end
		else begin
			o_random_out = 0;
		end
	end
	
	always @(posedge i_clk) begin
		if (sw == 1) begin
			if (run_num < SHOW_NUM) begin
				if (counter < delay) begin
					counter <= counter + 1;
					counter_total <= counter_total + 1;
				end
				else begin
					//rdm <= {rdm[4]^rdm[3],rdm[5]+1,rdm[2]+1,rdm[2:0]^rdm[2]+1,rdm[0],rdm[3]} + run_num;
					rdm <= (22695477 * counter_total + 1) % '1;
					run_num <= run_num + 1;
					counter <= 0;
				end
			end

			if (run_num<5) begin
				delay <= 37000000 - 8 * 9 * 9 * 50000;
			end
			else if(run_num<9) begin
				delay <= 37000000 - 7 * 7 * 8 * 50000;
			end
			else if(run_num<12) begin
				delay <= 37000000 - 6 * 6 * 7 * 50000;
			end
			else if(run_num<14) begin
				delay <= 37000000 - 5 * 5 * 6 * 50000;
			end
			else begin
				delay <= 35000000;
			end
		end
		else begin
			run_num <= 0;
			counter <= 0;
		end
	end
endmodule
