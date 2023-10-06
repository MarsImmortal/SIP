`timescale 1ns/1ns

module BinaryToPNG (
  input wire clk,
  input wire rst,
  input wire [7:0] binary_image_pixel,
  output wire [7:0] png_pixel_r,
  output wire [7:0] png_pixel_g,
  output wire [7:0] png_pixel_b,
  output wire png_pixel_valid
);

  reg [7:0] image_buffer [0:255][0:255];
  reg [7:0] current_pixel_r;
  reg [7:0] current_pixel_g;
  reg [7:0] current_pixel_b;
  reg [7:0] row_counter;
  reg [7:0] col_counter;
  reg pixel_valid;

  always @(posedge clk or posedge rst) begin
    if (rst) begin
      row_counter <= 8'b0;
      col_counter <= 8'b0;
      current_pixel_r <= 8'b0;
      current_pixel_g <= 8'b0;
      current_pixel_b <= 8'b0;
      pixel_valid <= 0;
    end else begin
      if (row_counter < 256 && col_counter < 256) begin
        image_buffer[row_counter][col_counter] <= binary_image_pixel;
        current_pixel_r <= binary_image_pixel;
        current_pixel_g <= binary_image_pixel;
        current_pixel_b <= binary_image_pixel;
        pixel_valid <= 1;
      end else begin
        pixel_valid <= 0;
      end;

       if (col_counter < 255) begin
        col_counter <= col_counter + 1;
      end else if (row_counter < 255) begin
        col_counter <= 0;
        row_counter <= row_counter + 1;
      end;
    end;
  end

  assign png_pixel_r = current_pixel_r;
  assign png_pixel_g = current_pixel_g;
  assign png_pixel_b = current_pixel_b;
  assign png_pixel_valid = pixel_valid;

endmodule