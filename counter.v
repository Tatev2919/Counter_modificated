module counter
  #(parameter N = 3)
  (
    input clk,rst,
    inout [N-1:0] out_or_load,
    input we,trig,
    output out_pulse
);
reg [N-1:0] out,load_r;
wire [N-1:0] load;
reg trig_r;

assign out_or_load = we ? out: 4'bZ;
assign load = !we ? out_or_load : load_r;
assign out_pulse = (out == 1);
  
always @(posedge clk or posedge rst)
begin 
	if(rst) begin
		out <= 0;
		trig_r <= 0;
        load_r <= 0;
	end
	else begin 
		trig_r <= trig;
        load_r <= load;
		if(trig) begin  
			if ( trig_r^trig ) begin
				out <= load;
			end
		end
        else begin 
        	if (we) begin
            	if (out!= 0) 
                	out <= out - 1;
        	end
        end
    end
end
  
endmodule
