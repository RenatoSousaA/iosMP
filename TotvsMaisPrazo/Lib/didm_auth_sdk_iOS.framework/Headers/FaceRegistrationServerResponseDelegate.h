//
//  FaceRegistrationServerResponseDelegate.h
//  didm_auth_sdk_iOS
//
//  Created by Juan Pablo Combariza on 2/14/18.
//  Copyright © 2018 Easy Solutions, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
@protocol FaceRegistrationServerResponseDelegate <NSObject>

@required
- (void) onFaceRegistrationServerResponse:(NSString*) response;

@end
