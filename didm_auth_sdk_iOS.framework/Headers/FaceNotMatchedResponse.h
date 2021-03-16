//
//  FaceNotMatchedResponse.h
//  didm_auth_sdk_iOS
//
//  Created by Gerardo Tarazona on 12/5/18.
//  Copyright © 2018 Easy Solutions, Inc. All rights reserved.
//

#import "FaceMatchingResponse.h"
#import "FaceResponseWithAttempts.h"
#import "FaceAuthenticationInfo.h"
#import "AuthenticationInfoProtocol.h"
NS_ASSUME_NONNULL_BEGIN

@interface FaceNotMatchedResponse: FaceMatchingResponse <AuthenticationInfoProtocol>

@property (nonatomic, strong, readwrite) FaceResponseWithAttempts *faceResponse;
@property (nonatomic, strong, readwrite) FaceAuthenticationInfo *authInfo;

@end

NS_ASSUME_NONNULL_END
