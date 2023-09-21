module testbench;

  reg clk;
  reg rst;
  reg [7:0] binary_pixel;
  wire [7:0] png_pixel;
  wire png_valid;

  BinaryToPNG uut (
    .clk(clk),
    .rst(rst),
    .binary_pixel(binary_pixel),
    .png_pixel(png_pixel),
    .png_valid(png_valid)
  );

  always begin
    #5 clk = ~clk;
  end

  initial begin
    clk = 0;
    rst = 1;
    binary_pixel = 8'hFF;
    #10 rst = 0;
  end

  initial begin
    binary_pixel = 8'hFF;
    #100;
    if (png_valid) begin
      $display("Test Case 1: Valid PNG Pixel: %h", png_pixel);
    end else begin
      $display("Test Case 1: No valid PNG pixel data");
    end
  end

  initial begin
    binary_pixel = 8'hAA;
    #100;
    if (png_valid) begin
      $display("Test Case 2: Valid PNG Pixel: %h", png_pixel);
    end else begin
      $display("Test Case 2: No valid PNG pixel data");
    end
  end

  initial begin
    binary_pixel = 8'h55;
    #100;
    if (png_valid) begin
      $display("Test Case 3: Valid PNG Pixel: %h", png_pixel);
    end else begin
      $display("Test Case 3: No valid PNG pixel data");
    end

    $finish;
  end

endmodule
