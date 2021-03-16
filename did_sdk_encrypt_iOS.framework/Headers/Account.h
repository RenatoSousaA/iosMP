//
//  Account.h
//  didm_authenticator_sdk_1.0_iOS_6
//
//  Created by Javier Silva on 3/3/15.
//  Copyright (c) 2015 Easy Solutions Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AccountToken : NSObject {
    NSString *username;
    NSString *organizationName;
    BOOL activeOTPAuth;
    BOOL activePushAuth;
    BOOL activeQRAuth;
    BOOL activePushAlert;
    BOOL activeVoiceAuth;
    BOOL activeFaceAuth;
    NSString *registrationDate;
    BOOL isLegacy;
    int registrationMethod;
}

@property (nonatomic) NSString *username;
@property (nonatomic) NSString *organizationName;
@property (nonatomic) BOOL activeOTPAuth;
@property (nonatomic) BOOL activePushAuth;
@property (nonatomic) BOOL activeQRAuth;
@property (nonatomic) BOOL activePushAlert;
@property (nonatomic) BOOL activeVoiceAuth;
@property (nonatomic) BOOL activeFaceAuth;
@property (nonatomic) NSString *registrationDate;
@property (nonatomic) NSString *activationURL;
@property (nonatomic) BOOL isLegacy;
@property (nonatomic) int registrationMethod;

-(id)initWithName:(NSString *)username_
    message:(NSString *)organizationName_
    activeOTPAuth:(BOOL)activeOTPAuth_
    activePushAuth:(BOOL)activePushAuth_
    activeQRAuth:(BOOL)activeQRAuth_
    activePushAlert:(BOOL)activePushAlert_
    activeVoiceAuth:(BOOL)activeVoiceAuth_
    activeFaceAuth:(BOOL)activeFaceAuth_
    registrationDate:(NSString *)registrationDate_
    activationURL:(NSString *)activationURL_
    isLegacy:(BOOL)isLegacy_
    registrationMethod:(int)registrationMethod_;

@end
