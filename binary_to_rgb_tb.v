`timescale 1ns/1ns

module BinaryToRGB_tb;

  reg clk;
  reg rst;
  reg [7:0] binary_image_pixel;
  wire [7:0] rgb_pixel_r;
  wire [7:0] rgb_pixel_g;
  wire [7:0] rgb_pixel_b;
  wire rgb_pixel_valid;
  reg [7:0] rgb_pixel_array [0:9][0:9]; 

  BinaryToRGB uut (
    .clk(clk),
    .rst(rst),
    .binary_image_pixel(binary_image_pixel),
    .rgb_pixel_r(rgb_pixel_r),
    .rgb_pixel_g(rgb_pixel_g),
    .rgb_pixel_b(rgb_pixel_b),
    .rgb_pixel_valid(rgb_pixel_valid),
    .rgb_pixel_array(rgb_pixel_array)
  );


  localparam WIDTH = 10;
  localparam HEIGHT = 10;


  integer row;
  integer col;

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


    row = 0;
    col = 0;


    while (row < WIDTH) begin
      while (col < HEIGHT) begin

        binary_image_pixel = $random;


        #5;


        if (rgb_pixel_valid) begin

          rgb_pixel_array[row][col] = {rgb_pixel_r, rgb_pixel_g, rgb_pixel_b};
          

          col = col + 1;
        end

      end
      col = 0;
      row = row + 1;
    end
    

    for (row = 0; row < WIDTH; row = row + 1) begin
      for (col = 0; col < HEIGHT; col = col + 1) begin
        $display("Pixel at row=%d, col=%d: R=%h, G=%h, B=%h", row, col, rgb_pixel_array[row][col][0], rgb_pixel_array[row][col][1], rgb_pixel_array[row][col][2]);
      end
    end
    

    $display("Image data display complete");
    

    $finish;
  end

endmodule
