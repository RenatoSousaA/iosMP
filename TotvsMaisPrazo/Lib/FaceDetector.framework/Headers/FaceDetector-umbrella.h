#ifdef __OBJC__
#import <UIKit/UIKit.h>
//#import "DAP.h"
#else
#ifndef FOUNDATION_EXPORT
#if defined(__cplusplus)
#define FOUNDATION_EXPORT extern "C"
#else
#define FOUNDATION_EXPORT extern
#endif
#endif
#endif

#import "dlibios.h"
FOUNDATION_EXPORT double FaceDetectorVersionNumber;
FOUNDATION_EXPORT const unsigned char FaceDetectorVersionString[];

