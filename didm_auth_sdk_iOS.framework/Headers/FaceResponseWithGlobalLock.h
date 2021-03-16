//
//  FaceResponseWithGlobalLock.h
//  didm_auth_sdk_iOS
//
//  Created by Gerardo Tarazona on 12/5/18.
//  Copyright © 2018 Easy Solutions, Inc. All rights reserved.
//

#import "FaceResponse.h"
#import "GlobalLock.h"
NS_ASSUME_NONNULL_BEGIN

@interface FaceResponseWithGlobalLock : FaceResponse

@property (nonatomic, strong, readwrite) GlobalLock *globalLock;

@end

NS_ASSUME_NONNULL_END
