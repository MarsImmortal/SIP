`timescale 1ns/1ns

module BinaryToPNG_tb;

  reg clk;
  reg rst;
  reg [7:0] binary_image_pixel;
  wire [7:0] png_pixel_r;
  wire [7:0] png_pixel_g;
  wire [7:0] png_pixel_b;
  wire png_pixel_valid;

  reg [31:0] file_handle;

  // Instantiate the module
  BinaryToPNG uut (
    .clk(clk),
    .rst(rst),
    .binary_image_pixel(binary_image_pixel),
    .png_pixel_r(png_pixel_r),
    .png_pixel_g(png_pixel_g),
    .png_pixel_b(png_pixel_b),
    .png_pixel_valid(png_pixel_valid)
  );

  // Clock generation
  initial begin
    clk = 0;
    forever #5 clk = ~clk;
  end

  // Reset generation
  initial begin
    rst = 1;
    #10 rst = 0; // Release reset after 10 time units
  end

  // Test scenarios
  initial begin
    // Wait for some time to stabilize
    #20;

    // Open the output file for writing with a delay
 	#10 file_handle = $fopen("/home/runner/output_image.txt", "w");

    // Test Case 1
    binary_image_pixel = 8'b11001100;
    #10 $display("Time=%t, Test Case 1: PNG Pixel R=%h, G=%h, B=%h, Valid=%b",
                $time, png_pixel_r, png_pixel_g, png_pixel_b, png_pixel_valid);
    // Save data to the output file
    $fdisplay(file_handle, "%t %h %h %h %b", $time, png_pixel_r, png_pixel_g, png_pixel_b, png_pixel_valid);

    // Test Case 2
    binary_image_pixel = 8'b10101010;
    #10 $display("Time=%t, Test Case 2: PNG Pixel R=%h, G=%h, B=%h, Valid=%b",
                $time, png_pixel_r, png_pixel_g, png_pixel_b, png_pixel_valid);
    // Save data to the output file
    $fdisplay(file_handle, "%t %h %h %h %b", $time, png_pixel_r, png_pixel_g, png_pixel_b, png_pixel_valid);

    // Test Case 3
    binary_image_pixel = 8'b00110011;
    #10 $display("Time=%t, Test Case 3: PNG Pixel R=%h, G=%h, B=%h, Valid=%b",
                $time, png_pixel_r, png_pixel_g, png_pixel_b, png_pixel_valid);
    // Save data to the output file
    $fdisplay(file_handle, "%t %h %h %h %b", $time, png_pixel_r, png_pixel_g, png_pixel_b, png_pixel_valid);

    // Close the output file
    $fclose(file_handle);

    // Stop simulation after some time
    #50 $stop;

  end

endmodule
