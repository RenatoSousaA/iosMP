//
//  FaceTransactionServerResponseDelegate.h
//  didm_auth_sdk_iOS
//
//  Created by Juan Pablo Combariza on 2/14/18.
//  Copyright © 2018 Easy Solutions, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FaceMatchingResponse.h"

@protocol FaceTransactionServerResponseDelegate <NSObject>

- (void)onFaceTransactionServerResponse:(NSString *)response;
- (void)onFaceAuthenticationServerResponse:(FaceMatchingResponse *)response;

@end
