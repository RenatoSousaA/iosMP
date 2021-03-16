//
//  TouchIDViewProperties.h
//  didm_auth_sdk_iOS
//
//  Created by Mauricio Vivas on 10/18/16.
//  Copyright © 2016 Easy Solutions, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FingerprintTransactionViewProperties : NSObject
@property (nonatomic) BOOL ACTIVE_PUSH_TRANSACTION;
@property (nonatomic) BOOL ACTIVE_QR_CODE_TRANSACTION;
@property (nonatomic) BOOL FORCE_FINGERPRINT_REGISTRATION;
@property (nonatomic) BOOL ALLOW_SECOND_PASSWORD;
@property (nonatomic) NSString *MESSAGE;
@property (nonatomic) NSString *SUCCESS_TOUCH_STATE;
@property (nonatomic) NSString *NOT_RECOGNIZED_TOUCH_STATE;
@property (nonatomic) NSString *NOT_DETECTED_TOUCH_STATE;
@property (nonatomic) NSString *LOCKOUT_TOUCH_STATE;
@property (nonatomic) NSString *ASK_TOUCH_STATE;
@property (nonatomic) NSString *OPTIONAL_PASSCODE;
@property (nonatomic) NSString *TRANSACTION_NOT_AUTHORIZED_BY_FINGERPRINT;

@end
