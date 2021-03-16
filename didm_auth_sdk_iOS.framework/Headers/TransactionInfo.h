//
//  DIDPushItem.h
//  didm_auth_sdk_iOS
//
//  Created by Daniel Ayala on 3/29/16.
//  Copyright © 2016 Easy Solutions, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Account.h"
#import "Channel.h"
#import "Gestures.h"
typedef NS_ENUM(NSInteger,TransactionType){
    NONE_TYPE = 0,
    PUSH_AUTHENTICATION = 1,
    PUSH_ALERT = 2,
    BIOMETRIC_AUTHENTICATION = 3,
};

typedef NS_ENUM(NSInteger,BiometricTransactionType){
    NONE_BIOMETRIC = 0,
    VOICE_AUTHENTICATION = 1,
    FACE_AUTHENTICATION = 2,
    FACE_AUTHENTICATION_LIVENESS = 3,
    VOICE_ENROLLMENT = 4,
    FACE_ENROLLMENT = 5
};


typedef NS_ENUM(NSInteger,TransactionStatus){
    NONE_STATUS = 0,
    PUSH_ALERT_SEEN = 2013,
    PUSH_ALERT_SENT = 2010,
    PUSH_ALERT_ARRIVED = 2012,
    PUSH_ALERT_APPROVED = 2014,
    PUSH_ALERT_NOT_SENT = 2011,
    PUSH_AUTHENTICATION_CONFIRMED = 1010,
    PUSH_AUTHENTICATION_DECLINED = 1012,
    PUSH_AUTHENTICATION_PENDING = 1011,
    PUSH_AUTHENTICATION_EXPIRED = 1013,
    PUSH_AUTHENTICATION_MAX_ATTEMPS = 1014,
    PUSH_AUTHENTICATION_FAILED = 1015,
    BIOMETRIC_AUTHENTICATION_PROCESS_EXPIRED = 1021,
    BIOMETRIC_AUTHENTICATION_SUCCESS = 1028,
    BIOMETRIC_AUTHENTICATION_PENDING = 1020,
    BIOMETRIC_AUTHENTICATION_NOT_SENT = 1027,
};

@interface TransactionInfo : NSObject

@property (nonatomic) NSString *transactionID;
@property (nonatomic) NSString *subject;
@property (nonatomic) NSString *message;
@property (nonatomic) NSString *subjectNotification;
@property (nonatomic) NSString *messageNotification;
@property (nonatomic) NSString *urlToResponse;
@property (nonatomic) NSString *urlToConfigFaceID;
@property (nonatomic) TransactionType type;
@property (nonatomic) BiometricTransactionType biometricType;
@property (nonatomic) long long timeStamp;
@property (nonatomic) TransactionStatus status;
@property (nonatomic) Account* account;
@property (nonatomic) NSString *transactionOfflineCode;
@property (nonatomic) Gestures *gestures;
@property (nonatomic) Channel *channel;

@end
