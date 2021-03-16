//
//  AuthenticationInfo.h
//  didm_auth_sdk_iOS
//
//  Created by Gerardo Tarazona on 12/5/18.
//  Copyright © 2018 Easy Solutions, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface FaceAuthenticationInfo : NSObject
@property (nonatomic, readwrite) double similarity;
@property (nonatomic, readwrite) BOOL match;
@end

NS_ASSUME_NONNULL_END
