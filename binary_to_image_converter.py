from PIL import Image

# Create a blank image with dimensions 256x256
image = Image.new('RGB', (256, 256))

# Open the output_image.txt file for reading
with open('output_image.txt', 'r') as file:
    lines = file.readlines()

# Initialize x and y coordinates
x = 0
y = 0

# Iterate through each line and set the pixel values in the image
for line in lines:
    tokens = line.split()
    if len(tokens) != 4:
        print("Error: Incorrect number of tokens in line:", line)
        continue

    try:
        time = int(tokens[0])
        r = int(tokens[1], 16)
        g = int(tokens[2], 16)
        b = int(tokens[3], 16)
    except ValueError as e:
        print("Error:", e, "in line:", line)
        continue

    # Normalize RGB values from 0-255
    r = r & 0xFF
    g = g & 0xFF
    b = b & 0xFF

    print(f"Time={time}, R={r}, G={g}, B={b}")  # Debug print

    # Set the RGB value in the image
    image.putpixel((x, y), (r, g, b))

    # Update x and y coordinates
    x += 1
    if x == 256:
        x = 0
        y += 1

# Save the image to a file
image.save('output_image.png')

# Display the image
image.show()
