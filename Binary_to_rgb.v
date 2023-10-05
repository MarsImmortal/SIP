`timescale 1ns/1ns

module BinaryToRGB (
  input wire clk,
  input wire rst,
  input wire [7:0] binary_image_pixel,
  output wire [7:0] rgb_pixel_r,
  output wire [7:0] rgb_pixel_g,
  output wire [7:0] rgb_pixel_b,
  output wire rgb_pixel_valid
);

  localparam WIDTH = 256;
  localparam HEIGHT = 256;

  // Declare image buffer as reg [7:0] type
  reg [7:0] image_buffer [0:WIDTH-1][0:HEIGHT-1];

  // Declare registers for the current pixel and counters
  reg [7:0] current_pixel_r;
  reg [7:0] current_pixel_g;
  reg [7:0] current_pixel_b;
  reg [15:0] row_counter;
  reg [15:0] col_counter;
  reg pixel_valid;

  always @(posedge clk or posedge rst) begin
    if (rst) begin
      // Reset all registers and counters
      current_pixel_r <= 8'b0;
      current_pixel_g <= 8'b0;
      current_pixel_b <= 8'b0;
      row_counter <= 16'b0;
      col_counter <= 16'b0;
      pixel_valid <= 0;
    end else begin
      if (row_counter < WIDTH && col_counter < HEIGHT) begin
        // Store binary_image_pixel in image_buffer
        image_buffer[row_counter][col_counter] <= binary_image_pixel;
        // Set RGB components from binary_image_pixel
        current_pixel_r <= binary_image_pixel;
        current_pixel_g <= binary_image_pixel;
        current_pixel_b <= binary_image_pixel;
        pixel_valid <= 1;
      end else begin
        // Set pixel_valid to 0 when image processing is complete
        pixel_valid <= 0;
      end;

      if (col_counter < HEIGHT - 1) begin
        col_counter <= col_counter + 1;
      end else if (row_counter < WIDTH - 1) begin
        col_counter <= 16'b0;
        row_counter <= row_counter + 1;
      end;
    end;
  end

  // Output assignments for RGB components and valid flag
  assign rgb_pixel_r = current_pixel_r;
  assign rgb_pixel_g = current_pixel_g;
  assign rgb_pixel_b = current_pixel_b;
  assign rgb_pixel_valid = pixel_valid;

endmodule
