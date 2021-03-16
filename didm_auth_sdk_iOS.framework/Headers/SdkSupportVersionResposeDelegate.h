//
//  SdkSupportVersionResposeDelegate.h
//  didm_auth_sdk_iOS
//
//  Created by Juan Pablo Combariza on 4/26/18.
//  Copyright © 2018 Easy Solutions, Inc. All rights reserved.
//
#import <Foundation/Foundation.h>
@protocol SdkSupportVersionResposeDelegate <NSObject>

@required

- (void)onSuccessResponse:(BOOL)supported;
- (void)onFailedResponse;

@end
