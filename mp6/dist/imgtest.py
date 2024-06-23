'''
    Opencv based mp debugger
    Aimed to find pixel different in two images.
    by Yuanzhe Liu
    Mar 2024
'''

import cv2
import numpy as np

# some names

outpng = "Examples/test.png"
goldpng = "Examples/maclean-campus-reformatted-3-watermarks.png"
writepng = 'diff.png'

# somd image data
# your output image
imgo = cv2.imread(outpng)
# correct image
imgg = cv2.imread(goldpng)
# data to be written
imgw = np.array(imgo)

# difference counter
count = 0
# default y if in out8.png
y = 100
# go through all pixels
for x in range(imgg.shape[1]):
    # if you are looking at out8.png, please comment the following line to avoid too much outputs
    for y in range(imgg.shape[0]):
        dif = False
        # check three channels in the pixel
        for c in range(3):
            if imgo[y][x][c] != imgg[y][x][c]:
                dif = True
                count += 1
        if dif:
            print('In pixel (' + str(x) +', '+ str(y) + ')' + '\toutputColor(B,G,R)='+str(imgo[y][x]) + '\t \tgoldColor(B,G,R)='+str(imgg[y][x]))
            # generate pixel in diff.png
            if imgo[y][x][0] == imgo[y][x][1] == imgo[y][x][2] == 0:
                imgw[y][x][0] = 255
                imgw[y][x][1] = 0
                imgw[y][x][2] = 0
            elif imgg[y][x][0] == imgg[y][x][1] == imgg[y][x][2] == 0:
                imgw[y][x][0] = 0
                imgw[y][x][1] = 0
                imgw[y][x][2] = 255

# print results and write out image
print(str(count) + " different pixels")
if(count != 0):
    cv2.imwrite(writepng, imgw)
    print("Difference written in " + writepng + '. Red=yourFalsePixel, Blue=correctAnswer')