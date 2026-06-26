`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06/24/2026 12:24:52 AM
// Design Name: 
// Module Name: sync_fifo
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


module sync_fifo #(parameter depth=8, width=16)
    (input clk, rstn, we, re, 
     input [width-1:0] din,
     output reg [width-1:0] dout,
     output empty, full
    );
    
    reg [$clog2(depth)-1:0] wptr;
    reg [$clog2(depth)-1:0] rptr;
    
    reg[width-1:0] fifo[0:depth-1];
    
    always @(posedge clk) begin
        if(!rstn)
            wptr <= 0;
        else begin
            if(we & !full) begin
                fifo[wptr] <= din;
                wptr <= wptr+1;
            end
        end
    end
    
    initial begin
        $monitor("[%0t] [FIFO] we=%0b din=0x%0h re=%0b dout=0x%0h empty=%0b full=%0b",
                $time, we, din, re, dout, empty, full);
    end
    
    always @(posedge clk) begin
        if(!rstn) begin
            rptr <= 0;
            dout <= 0;
        end
        else begin
            if(re & !empty) begin
                dout <= fifo[rptr];
                rptr <= rptr+1;
            end
        end
    end
    
    assign full = (wptr==width);
    assign empty = (wptr==0);
    
endmodule