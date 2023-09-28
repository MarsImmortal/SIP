`timescale 1ns/1ns

module BinaryToPNG_tb;

  reg clk;
  reg rst;
  reg [7:0] binary_image_pixel;
  wire [7:0] png_pixel_r;
  wire [7:0] png_pixel_g;
  wire [7:0] png_pixel_b;
  wire png_pixel_valid;

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

    // Test Case 1
    binary_image_pixel = 8'b11001100;
    #10 $display("Time=%t, Test Case 1: PNG Pixel R=%h, G=%h, B=%h, Valid=%b",
                $time, png_pixel_r, png_pixel_g, png_pixel_b, png_pixel_valid);

    // Test Case 2
    binary_image_pixel = 8'b10101010;
    #10 $display("Time=%t, Test Case 2: PNG Pixel R=%h, G=%h, B=%h, Valid=%b",
                $time, png_pixel_r, png_pixel_g, png_pixel_b, png_pixel_valid);

    // Test Case 3
    binary_image_pixel = 8'b00110011;
    #10 $display("Time=%t, Test Case 3: PNG Pixel R=%h, G=%h, B=%h, Valid=%b",
                $time, png_pixel_r, png_pixel_g, png_pixel_b, png_pixel_valid);

    // Test Case 4
    binary_image_pixel = 8'b01010101;
    #10 $display("Time=%t, Test Case 4: PNG Pixel R=%h, G=%h, B=%h, Valid=%b",
                $time, png_pixel_r, png_pixel_g, png_pixel_b, png_pixel_valid);

    // Test Case 5
    binary_image_pixel = 8'b11110000;
    #10 $display("Time=%t, Test Case 5: PNG Pixel R=%h, G=%h, B=%h, Valid=%b",
                $time, png_pixel_r, png_pixel_g, png_pixel_b, png_pixel_valid);

    // Test Case 6
    binary_image_pixel = 8'b11000011;
    #10 $display("Time=%t, Test Case 6: PNG Pixel R=%h, G=%h, B=%h, Valid=%b",
                $time, png_pixel_r, png_pixel_g, png_pixel_b, png_pixel_valid);

    // Test Case 7
    binary_image_pixel = 8'b00111100;
    #10 $display("Time=%t, Test Case 7: PNG Pixel R=%h, G=%h, B=%h, Valid=%b",
                $time, png_pixel_r, png_pixel_g, png_pixel_b, png_pixel_valid);

    // Test Case 8
    binary_image_pixel = 8'b00000000;
    #10 $display("Time=%t, Test Case 8: PNG Pixel R=%h, G=%h, B=%h, Valid=%b",
                $time, png_pixel_r, png_pixel_g, png_pixel_b, png_pixel_valid);

    // Test Case 9
    binary_image_pixel = 8'b11111111;
    #10 $display("Time=%t, Test Case 9: PNG Pixel R=%h, G=%h, B=%h, Valid=%b",
                $time, png_pixel_r, png_pixel_g, png_pixel_b, png_pixel_valid);

    // Test Case 10
    binary_image_pixel = 8'b01001001;
    #10 $display("Time=%t, Test Case 10: PNG Pixel R=%h, G=%h, B=%h, Valid=%b",
                $time, png_pixel_r, png_pixel_g, png_pixel_b, png_pixel_valid);

    // Print image buffer content
    #10 $display("Image Buffer Content:");
    for (int i = 0; i < 256; i = i + 1) begin
      for (int j = 0; j < 256; j = j + 1) begin
        $display("%h ", uut.image_buffer[i][j]);
      end
      $display("");
    end

    // End simulation after some time
    #100 $finish;
  end

endmodule
