import numpy as np
import matplotlib.pyplot as plt

# Initialize a 256x256 black image
image = np.zeros((256, 256, 3), dtype=np.uint8)

# Open the output_image.txt file for reading
with open('output_image.txt', 'r') as file:
    lines = file.readlines()

# Parse each line and set the pixel values in the image
for line in lines:
    tokens = line.split()
    if len(tokens) != 4:
        continue

    try:
        time = int(tokens[0])
        r = int(tokens[1], 16)
        g = int(tokens[2], 16)
        b = int(tokens[3], 16)
    except ValueError as e:
        print("Error:", e, "in line:", line)
        continue

    # Calculate pixel coordinates from the time value
    x = time % 256
    y = time // 256

    # Set the RGB value in the image
    image[y, x, 0] = r
    image[y, x, 1] = g
    image[y, x, 2] = b

# Display the image
plt.imshow(image)
plt.axis('off')  # Turn off axis labels and ticks
plt.show()



