//
//  FaceResponseWithAttempts.h
//  didm_auth_sdk_iOS
//
//  Created by Gerardo Tarazona on 12/5/18.
//  Copyright © 2018 Easy Solutions, Inc. All rights reserved.
//

#import "FaceResponse.h"
#import <Foundation/Foundation.h>
NS_ASSUME_NONNULL_BEGIN

@interface FaceResponseWithAttempts : FaceResponse

@property (nonatomic, readwrite) int remainingAttempts;

@end

NS_ASSUME_NONNULL_END
