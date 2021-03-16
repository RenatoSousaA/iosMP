//
//  AuthInfoProtocol.h
//  didm_auth_sdk_iOS
//
//  Created by Gerardo Tarazona on 12/5/18.
//  Copyright © 2018 Easy Solutions, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FaceAuthenticationInfo.h"
NS_ASSUME_NONNULL_BEGIN

@protocol AuthenticationInfoProtocol <NSObject>
- (FaceAuthenticationInfo *)getAuthInfo;
@end

NS_ASSUME_NONNULL_END
