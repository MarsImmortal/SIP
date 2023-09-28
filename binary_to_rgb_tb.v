`timescale 1ns/1ns

module BinaryToPNG_tb;

  reg clk;
  reg rst;
  reg [7:0] binary_image_pixel;
  wire [7:0] png_pixel_r;
  wire [7:0] png_pixel_g;
  wire [7:0] png_pixel_b;
  wire png_pixel_valid;

  BinaryToPNG uut (
    .clk(clk),
    .rst(rst),
    .binary_image_pixel(binary_image_pixel),
    .png_pixel_r(png_pixel_r),
    .png_pixel_g(png_pixel_g),
    .png_pixel_b(png_pixel_b),
    .png_pixel_valid(png_pixel_valid)
  );

  reg [31:0] file_handle;

  initial begin
    clk = 0;
    forever #5 clk = ~clk;
  end

  initial begin
    rst = 1;
    #10 rst = 0;
  end

  initial begin
    #30;
    file_handle = $fopen("output_image.txt", "w");

    repeat (20) begin
      #50;
      binary_image_pixel = $random;

      #10 $display("Time=%t, Test Case: PNG Pixel R=%h, G=%h, B=%h, Valid=%b",
                $time, png_pixel_r, png_pixel_g, png_pixel_b, png_pixel_valid);

      $fdisplay(file_handle, "%t %h %h %h %b", $time, png_pixel_r, png_pixel_g, png_pixel_b, png_pixel_valid);
    end

    $fclose(file_handle);
    #100 $finish;
  end

endmodule
