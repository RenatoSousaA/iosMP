//
//  VoiceTransactionViewProperties.h
//  didm_auth_sdk_iOS
//
//  Created by Mauricio Vivas on 10/20/16.
//  Copyright © 2016 Easy Solutions, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface VoiceTransactionViewProperties : NSObject

@property (nonatomic) int MAX_RECORDING_TIME;
@property (nonatomic) NSString *TITLE;
@property (nonatomic) NSString *MESSAGE;
@property (nonatomic) NSString *START;
@property (nonatomic) NSString *STOP;
@property (nonatomic) NSString *START_TEXT_COLOR;
@property (nonatomic) NSString *STOP_TEXT_COLOR;
@property (nonatomic) NSString *START_BUTTON_COLOR;
@property (nonatomic) NSString *STOP_BUTTON_COLOR;

@property (nonatomic) NSString *SERVER_RESPONSE_DIALOG_TITLE;
@property (nonatomic) NSString *SERVER_RESPONSE_DIALOG_RETRY;
@property (nonatomic) NSString *SERVER_RESPONSE_DIALOG_OK;
@property (nonatomic) NSString *SERVER_RESPONSE_DIALOG_CANCEL;

@property (nonatomic) NSString *SERVER_RESPONSE_CODE_98;
@property (nonatomic) NSString *SERVER_RESPONSE_CODE_99;
@property (nonatomic) NSString *SERVER_RESPONSE_CODE_1002;
@property (nonatomic) NSString *SERVER_RESPONSE_CODE_1010;
@property (nonatomic) NSString *SERVER_RESPONSE_CODE_1011;
@property (nonatomic) NSString *SERVER_RESPONSE_CODE_1012;
@property (nonatomic) NSString *SERVER_RESPONSE_CODE_1020;
@property (nonatomic) NSString *SERVER_RESPONSE_CODE_1021;
@property (nonatomic) NSString *SERVER_RESPONSE_CODE_1022;
@property (nonatomic) NSString *SERVER_RESPONSE_CODE_1040;
@property (nonatomic) NSString *SERVER_RESPONSE_CODE_1041;
@property (nonatomic) NSString *SERVER_RESPONSE_CODE_1043;

@end
