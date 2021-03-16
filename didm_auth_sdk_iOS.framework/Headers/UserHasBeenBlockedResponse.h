//
//  UserHasBeenBlockedResponse.h
//  didm_auth_sdk_iOS
//
//  Created by Gerardo Tarazona on 12/5/18.
//  Copyright © 2018 Easy Solutions, Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UserBlocked.h"
#import "AuthenticationInfoProtocol.h"
#import "FaceAuthenticationInfo.h"
NS_ASSUME_NONNULL_BEGIN

@interface UserHasBeenBlockedResponse : UserBlocked <AuthenticationInfoProtocol>
@property (nonatomic, strong, readwrite) FaceAuthenticationInfo *authInfo;

@end

NS_ASSUME_NONNULL_END
