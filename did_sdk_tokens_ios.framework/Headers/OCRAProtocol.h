//
//  OCRAProtocol.h
//  did_sdk_tokens_ios
//
//  Created by Gerardo Tarazona on 2/14/19.
//

#import <Foundation/Foundation.h>

/**
 * Error codes that can occur when generating an OCRA string
 */
enum {
    OCRANumberOfDigitsTooLargeError = 100
};

@interface OCRAProtocol : NSObject

+ (NSString *)generateOCRAForSuite:(NSString *)ocraSuite
                               key:(NSString *)key
                           counter:(NSString *)counter
                          question:(NSString *)question
                          password:(NSString *)password
                sessionInformation:(NSString *)sessionInformation
                         timestamp:(NSString *)timeStamp
                             error:(NSError **)error;

@end
