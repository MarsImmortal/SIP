`timescale 1ns/1ps

module BinaryToPNG (
    input wire clk,
    input wire rst,
    input wire [7:0] binary_pixel,  
    output reg [7:0] png_pixel,    
    output reg png_valid           
);
    reg [7:0] png_buffer [0:2]; 
    reg [2:0] png_state;         
    wire is_first_pixel = (png_state == 0);

    always @(posedge clk or negedge rst) begin
        if (!rst) begin
            png_state <= 0;
        end else if (is_first_pixel) begin
            png_buffer[0] <= binary_pixel;
            png_state <= 1;
        end else if (png_state == 1) begin
            png_buffer[1] <= binary_pixel;
            png_state <= 2;
        end else if (png_state == 2) begin
            png_buffer[2] <= binary_pixel;
            png_state <= 0;
        end
    end


    always @(*) begin
        if (is_first_pixel) begin
            png_pixel = binary_pixel;  
            png_valid = 1'b1;          
        end else begin
            png_pixel = 8'h00;         
            png_valid = 1'b0;          
        end
    end

    
endmodule
