//
//  DetectID.h
//  didm_auth_sdk_1.0_iOS_6
//
//  Created by Javier Silva on 12/10/14.
//  Copyright (c) 2014 Easy Solutions Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "QR_Authentication_API.h"
#import "Push_Authentication_API.h"
#import "OTP_Authentication_API.h"
#import "Voice_Authentication_API.h"
#import "Face_Authentication_API.h"
#import "Inbox_API.h"
#import "CommonAPI.h"
#import "SecureStorageAPI.h"

@interface DetectID: CommonAPI

@property (strong, nonatomic) Push_Authentication_API *PUSH_API;
@property (strong, nonatomic) OTP_Authentication_API *OTP_API;
@property (strong, nonatomic) QR_Authentication_API *QR_API;
@property (strong, nonatomic) Voice_Authentication_API *VOICE_API;
@property (strong, nonatomic) Face_Authentication_API *FACE_API;
@property (strong, nonatomic) Inbox_API *INBOX_API;
@property (strong, nonatomic) SecureStorageAPI *SECURE_STORAGE_API;

+ (id)sdk;

@end
