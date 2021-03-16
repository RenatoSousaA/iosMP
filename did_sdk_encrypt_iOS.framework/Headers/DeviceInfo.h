//
//  InformationDevice.h
//  did_sdk_tokens_ios
//
//  Created by Gerardo Tarazona on 11/20/18.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface DeviceInfo : NSObject
    
+ (NSString *)getMachineId;

+ (void)resetMachineId;
    
@end

NS_ASSUME_NONNULL_END
