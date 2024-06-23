#if !defined(__MP4_H__)
#define __MP4_H__

#include <stdint.h>

// Given a set of four swimmers' lane preferences (encoded as a 2-bit bit vector), print
// a plan for two to four trials to the screeen.
extern void plan_swim_meet (int32_t pref_A, int32_t pref_B, int32_t pref_C, int32_t pref_D);

#endif /* __MP4_H__ */
