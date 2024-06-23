#include <stdint.h>
#include <stdio.h>
#include <string.h>

#include "mp6.h"

//
// extract_watermark -- Given a file containing eight watermark images, 
//                      extract the image corresponding to a given bit (0 to 7)
//                      and write it into the output image using only values 0/255.
// INPUTS: width -- width of both input and output channels
//         height -- height of both input and output channels
//         data -- watermark image red channel
//         bit -- bit to extract from input (0 to 7)
// OUTPUT: output -- output image red channel (copied by calling code to green 
//                   and blue to make a black and white image)
// NOTES: bit 0 means value 1, bit 1 means value 2, and so forth.  Extract the bit
//        from the input array using a bitwise AND.  Write only 0/255 into each
//        output pixel, depending on whether the bit is clear/set, respectively,
//        in the data.
//
void 
extract_watermark (int32_t width, int32_t height, const uint8_t* data, int32_t bit, uint8_t* output)
{
	uint8_t bitmask = 1;
	bitmask = bitmask << bit; // calculate the corresponding bit mask for the bit
	for (int32_t i = 0; i <  height ; i++){
		for (int32_t j = 0 ; j < width ; j++){
			//interate throught the whole watermark array
			output[i * width + j]  = (data [i * width + j] & bitmask) != 0 ? 255 : 0; //write the 255/0 to the ouput image
		}
	}
}

//
// add_watermark -- Given the red channel for an image and a watermark image, scale
//                  the watermark and then apply it to each pixel in the image 
//                  (replace bit 0 in each pixel, and set those outside the scaled
//                  watermark to 0).
// INPUTS: width -- width of input channel
//         height -- height of input channel
//         data -- image red channel to which watermark should be applied
//         markwidth -- width of watermark
//         markheight -- height of watermark
//         watermark -- watermark image data
// OUTPUT: output -- output image red channel (image green and blue channels remain untouched)
// NOTES: the watermark data are produced by calling extract_watermark, so be sure that your
//        implementation of that function is correct before trying to debug this function
//
void 
add_watermark (int32_t width, int32_t height, const uint8_t* data, 
	       int32_t markwidth, int32_t markheight, const uint8_t* watermark, uint8_t* output)
{
	int32_t w_scale = width / markwidth;
	int32_t h_scale = height / markheight;
	for (int32_t i = 0; i < height ; i++){
		for (int32_t j = 0; j < width ; j++){
			int32_t y = i / h_scale;
			int32_t x = j / w_scale;
			if (y >= markheight || x >= markwidth){
				//check out of range pixel
				output[i * width + j] = data[i * width + j] & 0xFE; //set the bit0 to 0
			}else{
				/*conditional structure
				*set the bit0 to 1 if watermark pixel is 255 (non-zero/True)
				*set the bit0 to 0 if watermark pixel is 0(False)
				*/
				output[i * width + j] = watermark[x + y * markwidth ] ? (data[i * width + j] | 0x01) : (data[i * width + j] & 0xFE);
			}
		}
	}

}

//
// reconstruct_watermark -- Reconstruct a watermark from an image.  First, compute the scale
//                          factors for the watermark (based on the image sizes), then
//                          count the number of 1s in bit 0 of pixels in each rectangular
//                          region corresponding to a watermark pixel.  If the count is at
//                          least half the number of pixels in the rectangle, set the 
//                          watermark pixel to 255.  If not, set it to 0.
// INPUTS: width -- width of input channel
//         height -- height of input channel
//         data -- image red channel from which watermark should be reconstructed
//         markwidth -- width of watermark
//         markheight -- height of watermark
// OUTPUT: output -- output watermark image red channel (copied by calling code to green 
//                   and blue to make a black and white image)
// NOTES: the watermark image passed into the main code is used only to size the watermark; the
//        data in that file are not provided to this function
void 
reconstruct_watermark (int32_t width, int32_t height, const uint8_t* data, 
	       	       int32_t markwidth, int32_t markheight, uint8_t* output)
{
	int32_t w_scale = width / markwidth;
	int32_t h_scale = height / markheight;
	for (int32_t i = 0; i < markheight; i++){
		for(int32_t j = 0; j < markwidth ; j++){
			int32_t num = 0; //counter for the pixel whose bit0 is 1
			for (int32_t y = i * h_scale ; y < i * h_scale + h_scale ; y++){
				for(int32_t x = j * w_scale ; x < j * w_scale + w_scale ; x++){
					num += data[ x + y * width ] & 1;
				}
			}
			//calculate the proportion of 1s in bit0
			//if the proportion is larger than 1/2 than deduce the watermark pixel is 255
			//otherwise is 0
			output[i * markwidth + j] = (num * 2) >= (w_scale * h_scale) ? 255 : 0; 
		}
	}	
}
