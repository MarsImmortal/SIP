import matplotlib.pyplot as plt
import matplotlib.cm as cm

# Open the output_image.txt file for reading
with open('output_image.txt', 'r') as file:
    lines = file.readlines()

# Initialize x and y coordinates
x = 0
y = 0    

# Create an empty 256x256 array to hold the grayscale values
grayscale_data = [[0] * 256 for _ in range(256)]

# Parse each line and set the grayscale values
for line in lines:
    tokens = line.split()
    if len(tokens) != 4:
        continue

    time = int(tokens[0])
    gray_value = (int(tokens[1], 16) + int(tokens[2], 16) + int(tokens[3], 16)) // 3
   
    grayscale_data[y][x] = gray_value
   # Update x and y coordinates
    x += 1
    if x == 256:
        x = 0
        y += 1
# Create a heatmap using Matplotlib
plt.imshow(grayscale_data, cmap=cm.gray)
plt.colorbar()

# Save the heatmap image
plt.savefig('heatmap.png')

# Display the heatmap
plt.show()
