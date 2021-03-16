//
//  FaceNotFoundDelegate.h
//  didm_auth_sdk_iOS
//
//  Created by Katerin Vasquez on 12/5/18.
//  Copyright © 2018 Easy Solutions, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol FaceNotFoundDelegate <NSObject>

@required
- (void)onFaceNotFound:(TransactionInfo *)transaction;

@end

