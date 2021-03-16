//
//  Face_Authentication_API.h
//  didm_auth_sdk_iOS
//
//  Created by Daniel Ayala on 2/29/16.
//  Copyright © 2016 Easy Solutions, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TransactionInfo.h"
#import "FaceTransactionViewProperties.h"
#import "FaceRegistrationViewProperties.h"
#import "FaceRegistrationServerResponseDelegate.h"
#import "FaceRegistrationOpenDelegate.h"
#import "FaceTransactionServerResponseDelegate.h"
#import "FaceTransactionOpenDelegate.h"
#import "FaceRecognitionViewProperties.h"
#import "FaceNotFoundDelegate.h"

@interface Face_Authentication_API : NSObject

#pragma mark - Face Authentication API Delegates
@property (weak, nonatomic) id<FaceRegistrationServerResponseDelegate> faceRegistrationServerResponseDelegate;
@property (weak, nonatomic) id<FaceTransactionServerResponseDelegate> faceTransactionServerResponseDelegate;
@property (weak, nonatomic) id<FaceRegistrationOpenDelegate> faceRegistrationOpenDelegate;
@property (weak, nonatomic) id<FaceTransactionOpenDelegate> faceTransactionOpenDelegate;
@property (weak, nonatomic) id<FaceNotFoundDelegate> faceNotFoundDelegate;

+ (id)instance;

#pragma mark - Enable Response Alerts

- (void)enableFaceRegistrationServerResponseAlerts:(BOOL)enable;

- (void)setFaceAuthenticationResponseAdditionalInfo:(NSDictionary *)data;

- (void)enableFaceTransactionServerResponseAlerts:(BOOL)enable;

- (void)setFaceTransactionViewProperties:(FaceTransactionViewProperties *)properties;

- (void)setFaceRegistrationViewProperties:(FaceRegistrationViewProperties *)properties;

- (void)setFaceRecognitionViewProperties:(FaceRecognitionViewProperties *)properties;

@end
