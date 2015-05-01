import matplotlib.pyplot as plt
from skimage.feature import hog
from skimage import color, exposure
import skimage
im = skimage.io.imread('gray-tabby-cat-with-green-eyes-close-up.jpg')
image = color.rgb2gray(im)
fig, (ax1, ax2) = plt.subplots(1, 2, figsize=(8, 4))
ax1.axis('off')
ax1.imshow(image, cmap=plt.cm.gray)
ax1.set_title('Input image')
fd, hog_image = hog(image, orientations=8, pixels_per_cell=(52, 52),
                    cells_per_block=(1, 1), visualise=True)
# Rescale histogram for better display
hog_image_rescaled = exposure.rescale_intensity(hog_image, in_range=(0, 0.02))
ax2.axis('off')
ax2.imshow(hog_image_rescaled, cmap=plt.cm.gray)
ax2.set_title('Histogram of Oriented Gradients')
#fd, hog_image = hog(image, orientations=8, pixels_per_cell=(16, 16),
                    #cells_per_block=(1, 1), visualise=True)
#fd, hog_image = hog(image, orientations=8, pixels_per_cell=(32, 32),
                    #cells_per_block=(1, 1), visualise=True)
#fd, hog_image = hog(image, orientations=8, pixels_per_cell=(62, 62),
                    #cells_per_block=(1, 1), visualise=True)
plt.savefig('cat_hog.pdf')
