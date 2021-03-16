//
//  DataDetectionExceptionHandler.h
//  DisplayLiveSamples
//
//  Created by Mauricio Vivas on 11/27/17.
//  Copyright © 2017 ZweiGraf. All rights reserved.
//


#import <Foundation/Foundation.h>

@interface DataDetectionExceptionHandler : NSObject

+ (BOOL)catchException:(void(^)())tryBlock error:(__autoreleasing NSError **)error;

@end
