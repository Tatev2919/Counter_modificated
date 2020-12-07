module counter_tb;
	reg clk,rst,trig,we;
    reg [3:0] load;
    wire [3:0] out_or_load;
    wire out_pulse;
    wire [3:0] out;
  
    initial begin 
      $dumpfile("v.vcd");
      $dumpvars();
    end
    
    assign out_or_load = !we ? load: 4'bZ;
  
    counter #(4) c1 (
      .clk(clk),
      .rst(rst),
      .out_or_load(out_or_load),
      .out_pulse(out_pulse),
      .trig(trig),
      .we(we)
    );
    
	initial begin
    	clk = 1'b1;
        rst = 1'b1;
        trig = 1'b0;
        we = 1'b0;
        #25;
        rst = 1'b0;
        we  = 1'b0; 
        load = 4'd5;
        #15;
        load = 4'd4;
        #25;
        we = 1'b1;
        #25;
        trig = 1'b1;
        #27; 
        trig = 1'b0;
        load = 4'd11; 
        #300;
        trig = 1'b1;
        #27; 
        trig = 1'b0;
        #500;
        we = 1'b0;
        #250;
        $finish;
    end
  
    always begin 
    	#10 clk = ~clk; 
    end
  
endmodule