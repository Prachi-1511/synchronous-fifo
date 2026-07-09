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
    reg [$clog2(depth):0]   count;
    
    reg [width-1:0] fifo[0:depth-1];
    
    integer i;
    initial begin
        for(i=0; i<depth; i=i+1)
            fifo[i] = {width{1'b0}};
    end    
    
    initial begin
        $monitor("[%0t] [FIFO] we=%0b din=0x%0h re=%0b dout=0x%0h empty=%0b full=%0b",
                $time, we, din, re, dout, empty, full);
    end
    
    always @(posedge clk) begin
        if(!rstn) begin
            wptr <= 0;
            dout <= 0;
            rptr <= 0;
            count <= 0;
        end
        else begin
            // write
            if(we & !full) begin
                fifo[wptr] <= din;
                wptr <= wptr+1;
            end
            // read
            if(re & !empty) begin
                dout <= fifo[rptr];
                rptr <= rptr+1;
            end
            
            case({we & !full, re & !empty})
                2'b10: count <= count + 1; // write only
                2'b01: count <= count - 1; // read only
                default: count <= count;
            endcase
        end
    end
    
    assign full = (count == 0);
    assign empty = (count == depth);
    
endmodule