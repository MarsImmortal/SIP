`timescale 1ns/1ns

module BinaryToRGB (
  input wire clk,
  input wire rst,
  input wire [7:0] binary_image_pixel,
  output wire [7:0] rgb_pixel_r,
  output wire [7:0] rgb_pixel_g,
  output wire [7:0] rgb_pixel_b,
  output wire rgb_pixel_valid,
  output reg [7:0] rgb_pixel_array [0:WIDTH-1][0:HEIGHT-1]
);

  localparam WIDTH = 10;
  localparam HEIGHT = 10;


  reg [7:0] image_buffer [0:WIDTH-1][0:HEIGHT-1];

  reg [7:0] current_pixel_r;
  reg [7:0] current_pixel_g;
  reg [7:0] current_pixel_b;
  reg [15:0] row_counter;
  reg [15:0] col_counter;
  reg pixel_valid;

  always @(posedge clk or posedge rst) begin
    if (rst) begin
      current_pixel_r <= 8'b0;
      current_pixel_g <= 8'b0;
      current_pixel_b <= 8'b0;
      row_counter <= 16'b0;
      col_counter <= 16'b0;
      pixel_valid <= 0;
    end else begin
      if (row_counter < WIDTH && col_counter < HEIGHT) begin

        image_buffer[row_counter][col_counter] <= binary_image_pixel;

        current_pixel_r <= binary_image_pixel;
        current_pixel_g <= binary_image_pixel;
        current_pixel_b <= binary_image_pixel;
        pixel_valid <= 1;
        

        rgb_pixel_array[row_counter][col_counter] <= {current_pixel_r, current_pixel_g, current_pixel_b};
      end else begin

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


  assign rgb_pixel_r = current_pixel_r;
  assign rgb_pixel_g = current_pixel_g;
  assign rgb_pixel_b = current_pixel_b;
  assign rgb_pixel_valid = pixel_valid;


endmodule


