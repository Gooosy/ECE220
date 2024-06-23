#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>

#include "mp4.h"

int 
main (int argc, const char* const argv[]) 
{
    int32_t pref_A;	// swimmer A's preferences, a bit vector: 1 is lane 1, 2 is lane 2 (3 means both)
    int32_t pref_B;
    int32_t pref_C;
    int32_t pref_D;

    // Check argments.
    if (5 > argc ||
	1 != sscanf (argv[1], "%d", &pref_A) || 1 > pref_A || 3 < pref_A ||
	1 != sscanf (argv[2], "%d", &pref_B) || 1 > pref_B || 3 < pref_B ||
	1 != sscanf (argv[3], "%d", &pref_C) || 1 > pref_C || 3 < pref_C ||
	1 != sscanf (argv[4], "%d", &pref_D) || 1 > pref_D || 3 < pref_D) {
        fprintf (stderr, "Syntax: %s <A's prefs> <B's prefs> <C's prefs> <D's prefs>\n", argv[0]);
        fprintf (stderr, "        (each swimmers preferences should be 1, 2, or 3)\n");
	return 2;
    }

    // Call the student function to plan the trials for these four swimmers.
    plan_swim_meet (pref_A, pref_B, pref_C, pref_D);

    // Success!
    return 0;
}

