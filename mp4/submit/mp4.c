#include <stdint.h>
#include <stdio.h>

#include "mp4.h"
/*
 *Function:plan_swim_meet
 *Description:calculate the minimal trials needed in order to suit the need of every competitors
 *Parameters:the preference of each competitors 
 *           1 means the first lane 
 *           2 means the second lane 
 *           3 means both is ok
 * Return value:NONE directly print out the trials orangement
 * 
 */

void 
plan_swim_meet (int32_t pref_A, int32_t pref_B, int32_t pref_C, int32_t pref_D)
{ 
    if((pref_A | pref_B | pref_C | pref_D) != 3){
        // calculate the situation where we must take four trials
        printf("A/B/C/D\n");
    }else if((pref_A | pref_B | pref_C ) !=  3 ){
        //calculate the situation where we must take three trials
        //three trial situation meet the requirement that 
        //"A%d/%d/%d" that is A must conbine with another character
        //we need to calculate which character (the one different from the other)
        printf("AD/B/C\n");
    }else if((pref_A | pref_B | pref_D) != 3){
        printf("AC/B/D\n");
    }else if((pref_A | pref_C | pref_D) != 3 || (pref_B | pref_C | pref_D)!= 3 ){
        printf("AB/C/D\n");
    }else if((pref_A | pref_B) ==3 && (pref_C | pref_D) == 3){
        //here the bit wise operation | equals to pref_A + pref_B == 3 || pref_A ==3 || pref_B ==3
        //calculate the situation where we must take two trials
        //because A will always be the first and D will always be the last in this situation
        //we only need to determine whether it is AB/CD or it is AC/BD
        //because all the situation enter this else if statements only need two trials
        //we only need to calculate if A B compatible and if A C compatible
        //if A B compatible while C D don't 
        //it means there must be pref = 3 in AB and thus, we should leave one of them for the CD pair
        //for example if A = 3, then we combine A with C
        //how do we know B and D must be compatible in this case?
        //because I have already ruled out the situation where three of them are equal
        //which means that at least 2 of them are different
        //as CD is equal in based on our compatible test
        //A B must both be different from C and D
        //which means that A B are both compatible with C and D
        printf("AB/CD\n");
    }else{
        printf("AC/BD\n");
    }
    }      
