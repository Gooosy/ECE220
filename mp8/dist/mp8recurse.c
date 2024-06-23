#include <stdlib.h>
#include <string.h>

#include "mp8.h"

/*
 * basicRecurse -- flood fill recursively from a point until reaching
 *                 white or the image border
 * INPUTS: width -- width of the input image
 *         height -- height of the input image
 *         inRed -- pointer to the input red channel (1-D array)
 *         inGreen -- pointer to the input green channel (1-D array)
 *         inBlue -- pointer to the input blue channel (1-D array)
 *         x -- current x position of the flood
 *         y -- current y position of the flood
 *         marking -- array used to mark seen positions (indexed
 *                    in the same way as the RGB input arrays)
 * OUTPUTS: marking -- marked with flooded pixels
 * RETURN VALUE: none
 * SIDE EFFECTS: none
 */
void 
basicRecurse (int32_t width, int32_t height,
	      const uint8_t* inRed, const uint8_t* inGreen, 
	      const uint8_t* inBlue, 
	      int32_t x, int32_t y, 
	      uint8_t* marking)
{
	int32_t position = x + y * width;
	if( x >= width || y >= height || x < 0 || y < 0 
		||(inRed[position] == 0xff && inGreen[position] == 0xff && inBlue[position] == 0xff)){
		//stop when reaching the border or white pixel
			return;
		}

	if(marking[position]){
		//this place have already been visited: marking[position] == 1
		//no need to be marked again
		return;
	}
	marking[position] = 1; //mark the pixel
	basicRecurse(width, height, inRed, inGreen, inBlue, x + 1, y, marking);//flood to the right
	basicRecurse(width, height, inRed, inGreen, inBlue, x - 1, y, marking);//flood to the left
	basicRecurse(width, height, inRed, inGreen, inBlue, x, y + 1, marking);//flood to the down
	basicRecurse(width, height, inRed, inGreen, inBlue, x, y - 1, marking);//flood to the up
}	


/*
 * greyRecurse -- flood fill recursively from a point until reaching
 *                near-white pixels or the image border
 * INPUTS: width -- width of the input image
 *         height -- height of the input image
 *         inRed -- pointer to the input red channel (1-D array)
 *         inGreen -- pointer to the input green channel (1-D array)
 *         inBlue -- pointer to the input blue channel (1-D array)
 *         x -- current x position of the flood
 *         y -- current y position of the flood
 *         distSq -- maximum distance squared between white and boundary
 *                   pixel color
 *         marking -- array used to mark seen positions (indexed
 *                    in the same way as the RGB input arrays)
 * OUTPUTS: marking -- marked with flooded pixels
 * RETURN VALUE: none
 * SIDE EFFECTS: none
 */
void 
greyRecurse (int32_t width, int32_t height,
	     const uint8_t* inRed, const uint8_t* inGreen, 
	     const uint8_t* inBlue, 
	     int32_t x, int32_t y, uint32_t distSq, 
	     uint8_t* marking)
{
	int32_t position = x + y * width;
	if( x >= width || y >= height || x < 0 || y < 0 
		||(colorsWithinDistSq(0xff,0xff,0xff,inRed[position],inGreen[position],inBlue[position],distSq))){
		//stop when reaching the border or near-white pixel
			return;
		}
		
	if(marking[position]){
		//this place have already been visited: marking[position] == 1
		//no need to be marked again
		return;
	}
	marking[position] = 1; //mark the pixel
	greyRecurse(width, height, inRed, inGreen, inBlue, x + 1, y, distSq, marking);//flood to the right
	greyRecurse(width, height, inRed, inGreen, inBlue, x - 1, y, distSq, marking);//flood to the left
	greyRecurse(width, height, inRed, inGreen, inBlue, x, y + 1, distSq, marking);//flood to the down
	greyRecurse(width, height, inRed, inGreen, inBlue, x, y - 1, distSq, marking);//flood to the up
}


/*
 * limitedRecurse -- flood fill recursively from a point until reaching
 *                   pixels too different (in RGB color) from the color at
 *                   the flood start point, too far away (> 35 pixels), or
 *                   beyond the image border
 * INPUTS: width -- width of the input image
 *         height -- height of the input image
 *         inRed -- pointer to the input red channel (1-D array)
 *         inGreen -- pointer to the input green channel (1-D array)
 *         inBlue -- pointer to the input blue channel (1-D array)
 *         origX -- starting x position of the flood
 *         origY -- starting y position of the flood
 *         x -- current x position of the flood
 *         y -- current y position of the flood
 *         distSq -- maximum distance squared between pixel at origin 
 *                   and boundary pixel color
 *         marking -- array used to mark seen positions (indexed
 *                    in the same way as the RGB input arrays)
 * OUTPUTS: marking -- marked with flooded pixels
 * RETURN VALUE: none
 * SIDE EFFECTS: none
 */
void 
limitedRecurse (int32_t width, int32_t height,
	        const uint8_t* inRed, const uint8_t* inGreen, 
	        const uint8_t* inBlue, 
	        int32_t origX, int32_t origY, int32_t x, int32_t y, 
		uint32_t distSq, uint8_t* marking)
{
	int32_t position = x + y * width;
	int32_t orig = origX + origY * width; //calculat the position of orignal point in 1-D array
	if((origX - x)*(origX - x) + (origY - y) * (origY - y) > 35 * 35){
		//stop when too far away
		return;
	}
	if( x >= width || y >= height || x < 0 || y < 0 ||
		(!colorsWithinDistSq(inRed[position],inGreen[position],inBlue[position],inRed[orig],inGreen[orig],inBlue[orig],distSq))){
		//stop when reaching the border or the color is too different
		//the logic here is opposite the colorwithindistsq function return 0 indicate it is too far away
		return;
		}
		
	if(marking[position]){
		//this place have already been visited: marking[position] == 1
		//no need to be marked again
		return;
	}
	marking[position] = 1; //mark the pixel
	limitedRecurse(width, height, inRed, inGreen, inBlue, origX, origY, x + 1, y, distSq, marking);//flood to the right
	limitedRecurse(width, height, inRed, inGreen, inBlue, origX, origY, x - 1, y, distSq, marking);//flood to the left
	limitedRecurse(width, height, inRed, inGreen, inBlue, origX, origY, x, y + 1, distSq, marking);//flood to the down
	limitedRecurse(width, height, inRed, inGreen, inBlue, origX, origY, x, y - 1, distSq, marking);//flood to the up
}

