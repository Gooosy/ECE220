#if !defined(MP6_H)
#define MP6_H

#include <stdint.h>

// Extract one watermark from a file of watermarks (take the specified bit and
// convert each pixel to 0 or 255 in the output).  Assume bit is 0 to 7.
extern void extract_watermark
    (int32_t width, int32_t height, const uint8_t* data, int32_t bit, uint8_t* output);

// Add a watermark to an image (copy bit 0 of resized watermark to bit 0 of red channel)
extern void add_watermark
    (int32_t width, int32_t height, const uint8_t* data, 
     int32_t markwidth, int32_t markheight, const uint8_t* watermark, uint8_t* output);

// Reconstruct a watermark from an image (average bit 0 of red channel into watermark image 0/255)
extern void reconstruct_watermark 
    (int32_t width, int32_t height, const uint8_t* data, 
     int32_t markwidth, int32_t markheight, uint8_t* output);

#endif // MP6_H
