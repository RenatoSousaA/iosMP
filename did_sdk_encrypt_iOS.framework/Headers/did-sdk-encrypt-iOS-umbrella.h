#ifdef __OBJC__
#import <UIKit/UIKit.h>
#else
#ifndef FOUNDATION_EXPORT
#if defined(__cplusplus)
#define FOUNDATION_EXPORT extern "C"
#else
#define FOUNDATION_EXPORT extern
#endif
#endif
#endif

#import "DeviceInfo.h"
#import "EncryptAes.h"
#import "EncryptRSA.h"

FOUNDATION_EXPORT double did_sdk_encrypt_iOSVersionNumber;
FOUNDATION_EXPORT const unsigned char did_sdk_encrypt_iOSVersionString[];

