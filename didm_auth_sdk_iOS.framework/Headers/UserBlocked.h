//
//  UserBlocked.h
//  didm_auth_sdk_iOS
//
//  Created by Gerardo Tarazona on 12/5/18.
//  Copyright © 2018 Easy Solutions, Inc. All rights reserved.
//

#import "FaceMatchingResponse.h"
#import "FaceResponseWithGlobalLock.h"
NS_ASSUME_NONNULL_BEGIN

@interface UserBlocked : FaceMatchingResponse

@property (nonatomic, strong, readwrite) FaceResponseWithGlobalLock *faceResponse;

@end

NS_ASSUME_NONNULL_END
