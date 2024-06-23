#include <math.h>
#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>

#include "imageData.h"
#include "mp6.h"

int
main (int argc, const char* const argv[])
{
    char garbage[2];
    int command;
    int32_t bit;

    if (5 > argc ||
        1 != sscanf (argv[3], "%d%1s", &command, garbage) || 
	1 > command || 3 < command ||
	(3 > command && (1 != sscanf (argv[4], "%d%1s", &bit, garbage) || 0 > bit || 7 < bit)) ||
	(2 != command && 5 != argc) || (2 == command && 6 != argc)) {
        fprintf (stderr, "syntax: %s <input file> <output file> <command #> ...\n", argv[0]);
	fprintf (stderr, "\nCommand must be from 1 to 3.\n");
	fprintf (stderr, "  1 -- extract watermark <bit>\n");
	fprintf (stderr, "  2 -- add watermark <bit> <watermark file>\n");
	fprintf (stderr, "  3 -- reconstruct watermark <sample watermark file>\n");
	return 2;
    }

    Image* inputImage = decode (argv[1]);
    int height = inputImage->height;
    int width  = inputImage->width;
    printf ("Width: %d, height: %d\n", width, height);

    Image* watermarkImage = NULL;
    int markheight = 0;
    int markwidth  = 0;
    if (1 < command) {
	watermarkImage = decode (argv[2 == command ? 5 : 4]);
	markheight = watermarkImage->height;
	markwidth  = watermarkImage->width;
    }
    Image* outputImage = generateOutput (3 != command ? inputImage : watermarkImage);

    uint8_t* inRed    = inputImage->redChannel;
    uint8_t* inBlue   = inputImage->blueChannel;
    uint8_t* inGreen  = inputImage->greenChannel;
    uint8_t* inAlpha  = inputImage->alphaChannel;
    uint8_t* outRed   = outputImage->redChannel;
    uint8_t* outBlue  = outputImage->blueChannel;
    uint8_t* outGreen = outputImage->greenChannel;
    uint8_t* outAlpha = outputImage->alphaChannel;

    switch (command) {
        case 1:
	    memcpy (outAlpha, inAlpha, sizeof (*outAlpha) * height * width);
	    extract_watermark(width, height, inRed, bit, outRed);
	    memcpy (outGreen, outRed, sizeof (*outRed) * height * width);
	    memcpy (outBlue, outRed, sizeof (*outRed) * height * width);
	    break;
        case 2:
	    memcpy (outAlpha, inAlpha, sizeof (*outAlpha) * height * width);
	    // hack hack... should not change image, but too lazy to allocate something else
	    extract_watermark(markwidth, markheight, watermarkImage->redChannel, bit, watermarkImage->blueChannel);
	    add_watermark(width, height, inRed, markwidth, markheight, watermarkImage->blueChannel, outRed);
	    memcpy (outGreen, inGreen, sizeof (*inGreen) * height * width);
	    memcpy (outBlue, inBlue, sizeof (*inBlue) * height * width);
	    freeImage (watermarkImage);
	    break;
        case 3:
	    memcpy (outAlpha, watermarkImage->alphaChannel, 
	    	    sizeof (*watermarkImage->alphaChannel) * markheight * markwidth);
	    reconstruct_watermark(width, height, inRed, markwidth, markheight, outRed);
	    memcpy (outGreen, outRed, sizeof (*outRed) * markheight * markwidth);
	    memcpy (outBlue, outRed, sizeof (*outRed) * markheight * markwidth);
	    break;
    }
    encode (argv[2], outputImage);

    freeImage (inputImage);
    freeImage (outputImage);

    return 0;
}
