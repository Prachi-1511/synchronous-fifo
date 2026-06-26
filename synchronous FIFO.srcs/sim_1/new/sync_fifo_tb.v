`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06/26/2026 12:17:42 AM
// Design Name: 
// Module Name: sync_fifo_tb
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module sync_fifo_tb;

  reg 	 		clk;
  reg 			rstn;
  reg [15:0]    din;
  reg 			re;
  reg 			we;
  wire			empty;
  wire 			full;
  wire [15:0] 	dout;
  reg           stop;
  
  integer i;
  
  
  sync_fifo dut ( .rstn(rstn),
                         .we(we),
                         .re(re),
                         .clk(clk),
                         .din(din),
                         .dout(dout),
                         .empty(empty),
                         .full(full)
                        );

  always #10 clk = ~clk;

  initial begin
    clk 	<= 0;
    rstn 	<= 0;
    we 	    <= 0;
    re 	    <= 0;
    stop    <= 0;

    #50 rstn <= 1;
  end

  initial begin 
    @(posedge rstn);  
    @(posedge clk);
    
    for (i = 0; i < 20; i = i+1) begin
        while (full === 1'b1) begin
            $display("[%0t] FIFO is full, wait for reads to happen", $time);
            @(posedge clk);
        end;
        
        we    <= $random;
        din 	<= $random;
        $display("[%0t] clk i=%0d we=%0d din=0x%0h ", $time, i, we, din);

        @(posedge clk);
    end
    stop = 1;
  end
    
  initial begin 
    @(posedge rstn); 
    @(posedge clk);

    while (!stop) begin
      while (empty === 1'b1) begin
        re <= 0;
        $display("[%0t] FIFO is empty, wait for writes to happen", $time);
        @(posedge clk);
      end

      re <= $random;
      $display("[%0t] clk re=%0d rdata=0x%0h ", $time, re, dout);
      @(posedge clk);
    end

    #500 $finish;
  end
endmodule
