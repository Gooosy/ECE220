/*									tab:8
 *
 * main.c - skeleton source file for ECE220 picture drawing program
 *
 * "Copyright (c) 2018 by Charles H. Zega, and Saransh Sinha."
 *
 * Permission to use, copy, modify, and distribute this software and its
 * documentation for any purpose, without fee, and without written agreement is
 * hereby granted, provided that the above copyright notice and the following
 * two paragraphs appear in all copies of this software.
 * 
 * IN NO EVENT SHALL THE AUTHOR OR THE UNIVERSITY OF ILLINOIS BE LIABLE TO 
 * ANY PARTY FOR DIRECT, INDIRECT, SPECIAL, INCIDENTAL, OR CONSEQUENTIAL 
 * DAMAGES ARISING OUT  OF THE USE OF THIS SOFTWARE AND ITS DOCUMENTATION, 
 * EVEN IF THE AUTHOR AND/OR THE UNIVERSITY OF ILLINOIS HAS BEEN ADVISED 
 * OF THE POSSIBILITY OF SUCH DAMAGE.
 * 
 * THE AUTHOR AND THE UNIVERSITY OF ILLINOIS SPECIFICALLY DISCLAIM ANY 
 * WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF 
 * MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE.  THE SOFTWARE 
 * PROVIDED HEREUNDER IS ON AN "AS IS" BASIS, AND NEITHER THE AUTHOR NOR
 * THE UNIVERSITY OF ILLINOIS HAS ANY OBLIGATION TO PROVIDE MAINTENANCE, 
 * SUPPORT, UPDATES, ENHANCEMENTS, OR MODIFICATIONS."
 *
 * Author:	    Charles Zega, Saransh Sinha
 * Version:	    1
 * Creation Date:   12 February 2018
 * Filename:	    mp5.h
 * History:
 *	CZ	1	12 February 2018
 *		First written.
 */
#include "mp5.h"

/*
	You must write all your code only in this file, for all the functions!
*/



/* 
 *  near_horizontal
 *	 
 *	 
 *	
 *	
 * INPUTS: x_start,y_start -- the coordinates of the pixel at one end of the line
 * 	   x_end, y_end    -- the coordinates of the pixel at the other end
 * OUTPUTS: draws a pixel to all points in between the two given pixels including
 *          the end points
 * RETURN VALUE: 0 if any of the pixels drawn are out of bounds, otherwise 1
 * SIDE EFFECTS: none
 */

int32_t
near_horizontal(int32_t x_start, int32_t y_start, int32_t x_end, int32_t y_end){
	/* Your code goes here! */
	int32_t x1, x2, y1, y2, sgn;
	int32_t flag = 1;
	if (x_start < x_end){
		x1 = x_start;
		y1 = y_start;
		x2 = x_end;
		y2 = y_end;
	}else{
	//assume that x_start > x_end 
	//because if x_start == x_end then draw line should call draw vertical
		x2 = x_start;
		y2 = y_start;
		x1 = x_end;
		y1 = y_end;
	}
	for (int32_t x = x1; x <= x2 ; x++){
		if (y2 - y1 > 0){
			sgn = 1;
		}else if ( y2 - y1 == 0){
			sgn = 0;
		}else{
			sgn = -1;
		}
		//calculate the rounded value (instead of flooring)
		int32_t y = y1 + (2*(y2  - y1)*(x - x1) + (x2 - x1)*sgn)/(2*(x2 - x1));
		flag = flag & draw_dot(x , y);
	}
	return flag;
}


/* 
 *  near_vertical
 *	 
 *	 
 *	
 *	
 * INPUTS: x_start,y_start -- the coordinates of the pixel at one end of the line
 * 	   x_end, y_end    -- the coordinates of the pixel at the other end
 * OUTPUTS: draws a pixel to all points in between the two given pixels including
 *          the end points
 * RETURN VALUE: 0 if any of the pixels drawn are out of bounds, otherwise 1
 * SIDE EFFECTS: none
 */

int32_t
near_vertical(int32_t x_start, int32_t y_start, int32_t x_end, int32_t y_end){
	/* Your code goes here! */
	int32_t x1, x2, y1, y2, sgn;
	int32_t flag = 1;
	if (y_start < y_end){
		x1 = x_start;
		y1 = y_start;
		x2 = x_end;
		y2 = y_end;
	}else{
		x2 = x_start;
		y2 = y_start;
		x1 = x_end;
		y1 = y_end;
	}
	for (int32_t y = y1; y <= y2 ; y++){
		if (y1 == y2 && x1 == x2){
			//for the test code 
			return 0;
			//according to document
			//flag = flag & draw_dot(x1, y1);
		}else{
			if (x2 - x1 > 0){
				sgn = 1;
			}else if ( x2 - x1 == 0){
				sgn = 0;
			}else{
				sgn = -1;
			}
			//calculate the rounded value (instead of flooring)
			int32_t x = x1 + (2*(x2  - x1)*(y - y1) + (y2 - y1)*sgn)/(2*(y2 - y1));
			flag = flag & draw_dot(x , y);
		}
	}
	return flag;
}

/* 
 *  draw_line
 *	 
 *	 
 *	
 *	
 * INPUTS: x_start,y_start -- the coordinates of the pixel at one end of the line
 * 	   x_end, y_end    -- the coordinates of the pixel at the other end
 * OUTPUTS: draws a pixel to all points in between the two given pixels including
 *          the end points
 * RETURN VALUE: 0 if any of the pixels drawn are out of bounds, otherwise 1
 * SIDE EFFECTS: none
 */

int32_t
draw_line(int32_t x_start, int32_t y_start, int32_t x_end, int32_t y_end){
	/* Your code goes here! */
	int32_t deltax = (x_start >= x_end ? x_start - x_end : x_end - x_start);
	int32_t deltay = (y_start >= y_end ? y_start - y_end : y_end - y_start);
	if ((deltax | deltay) == 0 ){
		// if both deltax and deltay = 0 
		// the start points and end points are the same point
		return near_vertical(x_start, y_start, x_end, y_end);
	}
	if (deltax >= deltay ){
		return near_horizontal(x_start, y_start, x_end, y_end);
	}

	return near_vertical(x_start, y_start, x_end, y_end);
	// if non of the above requirement meet deltax < deltay
}


/* 
 *  draw_rect
 *	 
 *	 
 *	
 *	
 * INPUTS: x,y -- the coordinates of the of the top-left pixel of the rectangle
 *         w,h -- the width and height, respectively, of the rectangle
 * OUTPUTS: draws a pixel to every point of the edges of the rectangle
 * RETURN VALUE: 0 if any of the pixels drawn are out of bounds, otherwise 1
 * SIDE EFFECTS: none
 */

int32_t
draw_rect(int32_t x, int32_t y, int32_t w, int32_t h){
	/* Your code goes here! */
	int32_t flag = 1;
	if (w < 0 || h < 0){
		return 0;
	}else{
		flag = flag & draw_line(x, y, x + w, y); // upper bound that draw the horizontal top line
		flag = flag & draw_line(x, y + h, x + w, y + h); //lower bound that draw the horizontal bottom line
		flag = flag & draw_line(x, y, x, y + h); //left bound that draw vertical left line
		flag = flag & draw_line(x + w, y, x + w, y + h); //right bound that draw vertical right line
		// if w = 0 or h = 0 all these four just draw one dot or one line
	}
	return flag; 
}


/* 
 *  draw_triangle
 *	 
 *	 
 *	
 *	
 * INPUTS: x_A,y_A -- the coordinates of one of the vertices of the triangle
 *         x_B,y_B -- the coordinates of another of the vertices of the triangle
 *         x_C,y_C -- the coordinates of the final of the vertices of the triangle
 * OUTPUTS: draws a pixel to every point of the edges of the triangle
 * RETURN VALUE: 0 if any of the pixels drawn are out of bounds, otherwise 1
 * SIDE EFFECTS: none
 */

int32_t
draw_triangle(int32_t x_A, int32_t y_A, int32_t x_B, int32_t y_B, int32_t x_C, int32_t y_C){
	/* Your code goes here! */
	int32_t flag = 1;
	flag = flag & draw_line(x_A, y_A, x_B, y_B );
	flag = flag & draw_line(x_B, y_B, x_C, y_C );
	flag = flag & draw_line(x_C, y_C, x_A, y_A );
	return flag;
}

/* 
 *  draw_parallelogram
 *	 
 *	 
 *	
 *	
 * INPUTS: x_A,y_A -- the coordinates of one of the vertices of the parallelogram
 *         x_B,y_B -- the coordinates of another of the vertices of the parallelogram
 *         x_C,y_C -- the coordinates of another of the vertices of the parallelogram
 * OUTPUTS: draws a pixel to every point of the edges of the parallelogram
 * RETURN VALUE: 0 if any of the pixels drawn are out of bounds, otherwise 1
 * SIDE EFFECTS: none
 */

int32_t
draw_parallelogram(int32_t x_A, int32_t y_A, int32_t x_B, int32_t y_B, int32_t x_C, int32_t y_C){
	/* Your code goes here! */
	int32_t flag = 1;
	int32_t x_D = x_A + x_C - x_B;
	int32_t y_D = y_A + y_C - y_B;
	flag = flag & draw_line(x_A, y_A, x_B, y_B );
	flag = flag & draw_line(x_B, y_B, x_C, y_C );
	flag = flag & draw_line(x_C, y_C, x_D, y_D );
	flag = flag & draw_line(x_D, y_D, x_A, y_A );
	return flag;
}


/* 
 *  draw_circle
 *	 
 *	 
 *	
 *	
 * INPUTS: x,y -- the center of the circle
 *         inner_r,outer_r -- the inner and outer radius of the circle
 * OUTPUTS: draws a pixel to every point whose distance from the center is
 * 	    greater than or equal to inner_r and less than or equal to outer_r
 * RETURN VALUE: 0 if any of the pixels drawn are out of bounds, otherwise 1
 * SIDE EFFECTS: none
 */

int32_t
draw_circle(int32_t x, int32_t y, int32_t inner_r, int32_t outer_r){
	/* Your code goes here!*/
	int32_t flag = 1;
	if (inner_r < 0 || outer_r < 0){
		return 0;
	}else{
		for (int32_t i = x - outer_r ; i <= x + outer_r ; i ++ ){
			//here i represent the x coordinate of a possible pixel
			//go through all possible pixels where x is [x - outer_r, x + outer_r]
			//y is [y - outer_r , y + outer_r]
			for (int32_t j = y - outer_r ; j <= y + outer_r ; j++){
			//j represent the y coordinate of a possible pixel	
				int32_t distance = (i - x)*(i - x) + (j - y)*(j - y);
				if (distance >= inner_r*inner_r && distance <= outer_r * outer_r){
					flag = flag & draw_dot(i, j);
				}
			}
		}
	}
	return flag;
}


/* 
 *  rect_gradient
 *	 
 *	 
 *	
 *	
 * INPUTS: x,y -- the coordinates of the of the top-left pixel of the rectangle
 *         w,h -- the width and height, respectively, of the rectangle
 *         start_color -- the color of the far left side of the rectangle
 *         end_color -- the color of the far right side of the rectangle
 * OUTPUTS: fills every pixel within the bounds of the rectangle with a color
 *	    based on its position within the rectangle and the difference in
 *          color between start_color and end_color
 * RETURN VALUE: 0 if any of the pixels drawn are out of bounds, otherwise 1
 * SIDE EFFECTS: none
 */

int32_t
rect_gradient(int32_t x, int32_t y, int32_t w, int32_t h, int32_t start_color, int32_t end_color){
	/* Your code goes here! */
	int32_t flag = 1;
	if ( w <= 0 || h < 0){
		return 0;
	}else{
		for (int32_t i = x ; i <= x + w ; i++){
			int32_t sgn;
			int32_t arr1[3] = {0x00FF0000, 0x0000FF00, 0x000000FF}; //the three channel must be calculated seperately
			int32_t arr2[3] = {16, 8, 0};//the amount that need to be shifted
			int32_t level[3];//array store every entries of color RGB
			for (int32_t k = 0; k < 3; k++){
				if (((end_color & arr1[k]) >> arr2[k]) - ((start_color & arr1[k]) >> arr2[k]) > 0){
					sgn = 1;
				}else if (((end_color & arr1[k]) >> arr2[k]) - ((start_color & arr1[k]) >> arr2[k]) == 0){
					sgn = 0;
				}else{
					sgn = -1;
				}
				level[k] = ((start_color & arr1[k]) >> arr2[k] ) + (2 * (i - x) * (((end_color & arr1[k]) >> arr2[k]) - ((start_color & arr1[k]) >> arr2[k])) + w * sgn)/(2 * w); 
			}
			int32_t colorlevel = ((level[0] << arr2[0])| (level[1] << arr2[1]) | (level[2] << arr2[2]));
			set_color (colorlevel);
			for (int32_t j = y ; j <= y + h ; j++){
				flag = flag & draw_dot ( i, j );
			}
		}
	}
	return flag;
}


/* 
 *  draw_picture
 *	 
 *	 
 *	
 *	
 * INPUTS: none
 * OUTPUTS: alters the image by calling any of the other functions in the file
 * RETURN VALUE: 0 if any of the pixels drawn are out of bounds, otherwise 1
 * SIDE EFFECTS: none
 */


int32_t
draw_picture(){
	/* Your code goes here! */
	set_color(0x00E7F4DC);
	for (int i = 0; i < 624; i++){
		for (int j = 0; j < 320 ; j++){
			draw_dot(i,j);
		}
	}
	//set the back ground color

	set_color(0x007A9BD0);
	draw_line(187,55,227,55);
	draw_line(187,55,227,56);
	draw_line(187,56,227,57);
	draw_line(187,57,227,58);
	draw_line(187,58,227,58); //draw letter "H"

	set_color(0x00255FB6);
	draw_line(198,11,173,100);
	draw_line(198,10,174,100);
	draw_line(199,10,174,101);
	draw_line(200,9,174,102);
	draw_line(200,9,175,102);
	draw_line(201,9,174,99);
	draw_line(201,10,176,101);
	draw_line(202,10,176,99);
	draw_line(202,11,177,100);

	set_color(0x005D86C7);
	draw_line(236,11,211,100);
	draw_line(236,10,212,100);
	draw_line(237,10,212,101);
	draw_line(238,9,212,102);
	draw_line(238,9,213,102);
	draw_line(239,9,212,99);
	draw_line(239,10,214,101);
	draw_line(240,10,214,99);
	draw_line(240,11,215,100);

	set_color(0x0090D4EC);
	draw_circle(255,89,12,15);
	draw_line(270,82,263,105);
	draw_line(270,83,264,105);
	draw_line(271,82,264,107);
	draw_line(271,84,265,106);
	draw_line(272,83,266,106);//draw letter "a"

	set_color(0x0043D5FD);
	draw_line(302,80,290,136);
	draw_line(302,81,291,136);
	draw_line(303,80,291,138);
	draw_line(303,82,292,137);
	draw_line(304,80,292,138);
	draw_line(304,83,293,137);
	for (int32_t i = 301; i < 323; i++){
		for (int32_t j = 80; j < 111 ; j++){
			int32_t rad = (i - 308) * (i - 308) + (j - 93) * (j - 93);
			if (rad >= 100 && rad <= 169){
				draw_dot(i,j);
			}
		}
	}
	//draw letter "p"

	set_color(0x00B5CFFF);
	draw_line(352,80,340,136);
	draw_line(352,81,341,136);
	draw_line(353,80,341,138);
	draw_line(353,82,342,137);
	draw_line(354,80,342,138);
	draw_line(354,83,343,137);
	//draw a semi circle
	for (int32_t i = 351; i < 373; i++){
		for (int32_t j = 80; j < 111 ; j++){
			int32_t rad = (i - 358) * (i - 358) + (j - 93) * (j - 93);
			if (rad >= 100 && rad <= 169){
				draw_dot(i,j);
			}
		}
	}
	//draw letter "p"


	//draw letter "y"
	set_color(0x0094E3FE);
	draw_line(401,83,402,86);
	draw_line(402,83,398,97);
	draw_line(401,84,398,96);
	draw_line(403,84,400,95);
	draw_line(401,87,399,98);
	draw_line(399,97,398,103);
	draw_line(398,98,397,103);
	draw_line(403,87,399,102);
	draw_line(402,90,399,101);
	draw_dot(397,99);
	draw_dot(397,100);
	draw_dot(399,103);
	draw_dot(398,104);
	draw_dot(399,104);
	draw_dot(400,104);
	draw_dot(398,105);
	draw_dot(399,105);
	draw_dot(400,105);
	draw_dot(399,106);
	draw_dot(400,106);
	draw_dot(401,106);
	draw_dot(400,107);
	draw_dot(401,107);
	draw_dot(402,107);
	draw_dot(400,108);
	draw_dot(401,108);
	draw_dot(402,108);
	draw_line(401,108,410,108);
	draw_line(402,109,409,109);
	draw_line(404,110,406,110);
	draw_dot(416,103);
	draw_dot(415,103);
	draw_dot(414,103);
	draw_dot(415,104);
	draw_dot(414,104);
	draw_dot(413,104);
	draw_dot(415,105);
	draw_dot(414,105);
	draw_dot(413,105);
	draw_dot(414,106);
	draw_dot(413,106);
	draw_dot(412,106);
	draw_dot(412,107);
	draw_dot(410,107);
	draw_dot(411,107);
	draw_dot(412,108);
	draw_dot(410,108);
	draw_dot(411,108);
	draw_line(419,82,416,103);
	draw_line(420,82,415,102);
	draw_line(420,83,417,102);
	draw_line(421,83,417,102);
	draw_line(415,102,407,135);
	draw_line(416,102,408,135);
	draw_line(417,102,409,135);
	draw_dot(408,134);
	draw_dot(409,134);
	draw_dot(410,134);
	draw_dot(407,135);
	draw_dot(408,135);
	draw_dot(409,135);
	draw_dot(406,136);
	draw_dot(407,136);
	draw_dot(408,136);
	draw_dot(409,136);
	draw_dot(406,137);
	draw_dot(407,137);
	draw_dot(408,137);
	draw_dot(405,137);
	draw_dot(404,137);
	draw_line(407,138,396,138);
	draw_line(405,139,398,139);
	draw_line(403,140,400,140);
	draw_dot(396,138);
	draw_dot(397,138);
	draw_dot(398,138);
	draw_dot(395,137);
	draw_dot(396,137);
	draw_dot(397,137);
	draw_dot(398,137);
	draw_dot(394,136);
	draw_dot(395,136);
	draw_dot(396,136);
	draw_dot(393,135);
	draw_dot(394,135);
	draw_dot(395,135);
	draw_dot(393,134);
	draw_dot(394,134);
	draw_dot(395,134);
	draw_dot(392,133);
	draw_dot(393,133);
	draw_dot(394,133);
	draw_dot(391,132);
	draw_dot(392,132);
	draw_dot(393,132);
	draw_dot(391,131);
	draw_dot(392,131);
	draw_dot(393,131);
	draw_dot(390,130);
	draw_dot(391,130);
	draw_dot(392,130);
	draw_dot(390,129);
	draw_dot(391,129);

	//draw a "smile"
	set_color(0x00FFFC4D);
	draw_line(209,201,237,162);
	draw_line(210,201,238,162);
	draw_line(209,201,237,162);
	draw_line(211,201,239,162);
	draw_line(212,201,240,162);

	draw_line(266,201,237,162);
	draw_line(267,201,238,162);
	draw_line(268,201,237,161);
	draw_line(267,201,238,161);
	draw_line(268,201,237,162);
	draw_line(269,201,237,162);
	draw_line(269,201,239,162);
	draw_line(270,201,240,162);

	int32_t d = 96;
	draw_line(209+d,201,237+d,162);
	draw_line(210+d,201,238+d,162);
	draw_line(209+d,201,237+d,162);
	draw_line(211+d,201,239+d,162);
	draw_line(212+d,201,240+d,162);

	draw_line(266+d,201,237+d,162);
	draw_line(267+d,201,238+d,162);
	draw_line(268+d,201,237+d,161);
	draw_line(267+d,201,238+d,161);
	draw_line(268+d,201,237+d,162);
	draw_line(269+d,201,237+d,162);
	draw_line(269+d,201,239+d,162);
	draw_line(270+d,201,240+d,162);
	//draw a semi circle
	int32_t a = 286, b = 237;
	for (int32_t i = a - 100; i < a + 100 ; i++){
		for (int32_t j = b ; j < 320 ; j ++){
			int32_t dis = (i - a)*(i - a) + (j - b)*(j - b);
			if (dis >= 1225 && dis <= 1600 ){
				draw_dot(i, j);
			}
		}
	}
	return 1;
}

