//
//  FaceResponse.h
//  didm_auth_sdk_iOS
//
//  Created by Gerardo Tarazona on 12/5/18.
//  Copyright © 2018 Easy Solutions, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface FaceResponse : NSObject
@property (nonatomic, readwrite) int code;
@property (nonatomic, strong, readwrite) NSString *responseDescription;

- (instancetype)initWithCode:(int)code responseDescription:(NSString *)responseDesc;
- (instancetype)initWithResponse:(NSDictionary *)response;

@end

NS_ASSUME_NONNULL_END
