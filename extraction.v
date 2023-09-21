// Verilog code to interface with an SD card using SPI

module spi_sd_interface (
  input wire clk,            // System clock
  input wire rst,            // Reset signal
  output wire sd_cs,         // SD card chip select
  output wire spi_sclk,      // SPI clock
  inout wire spi_mosi,       // SPI master out, slave in
  inout wire spi_miso,       // SPI master in, slave out
  input wire file_ready,     // Signal indicating file is ready to transfer
  output wire[7:0] file_data // Data to/from the file
);

// Define state machine states
parameter IDLE = 2'b00;
parameter READ_DATA = 2'b01;

reg [1:0] state, next_state;
reg [7:0] data_out, data_in;
reg read_enable;

always @(posedge clk or posedge rst) begin
  if (rst) begin
    state <= IDLE;
    sd_cs <= 1'b1;  // De-assert SD card chip select
    spi_sclk <= 1'b0;  // Initialize SPI clock
    spi_mosi <= 1'b0;  // Initialize MOSI
    read_enable <= 1'b0;  // Disable read initially
  end else begin
    state <= next_state;
  end
end

always @(posedge clk) begin
  // Default assignments
  next_state = state;
  spi_sclk <= 1'b0;
  spi_mosi <= 1'b0;

  case (state)
    IDLE: begin
      // Wait for the file_ready signal to be asserted
      if (file_ready) begin
        next_state = READ_DATA;
        sd_cs <= 1'b0; // Assert SD card chip select
        read_enable <= 1'b1; // Enable read
      end
    end
    READ_DATA: begin
      // Read data from the SD card
      spi_sclk <= 1'b1; // Generate SPI clock
      spi_mosi <= read_enable ? 1'b1 : 1'b0; // Send command for data read
      if (spi_miso) begin
        data_in <= data_in << 1 | spi_miso; // Shift in received data
      end
      if (read_enable && (spi_miso == 1'b0)) begin
        read_enable <= 1'b0; // Disable read when done
        next_state = IDLE;
      end
    end
  endcase
end

assign file_data = data_in;

endmodule