//
//  QRCodeTransactionViewProperties.h
//  didm_auth_sdk_iOS
//
//  Created by Mauricio Vivas on 10/20/16.
//  Copyright © 2016 Easy Solutions, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface QRCodeTransactionViewProperties : NSObject

@property (nonatomic) NSString *CONFIRM;
@property (nonatomic) NSString *DECLINE;
@property (nonatomic) NSString *OFFLINE_CODE;
@property (nonatomic) BOOL ENABLE_OFFLINE_CODE;
@property (nonatomic) NSString *SERVER_RESPONSE_CODE_96;
@property (nonatomic) NSString *SERVER_RESPONSE_CODE_98;
@property (nonatomic) NSString *SERVER_RESPONSE_CODE_99;
@property (nonatomic) NSString *SERVER_RESPONSE_CODE_1001;
@property (nonatomic) NSString *SERVER_RESPONSE_CODE_1002;
@property (nonatomic) NSString *SERVER_RESPONSE_CODE_1012;
@property (nonatomic) NSString *SERVER_RESPONSE_CODE_1020;
@property (nonatomic) NSString *SERVER_RESPONSE_CODE_1021;
@property (nonatomic) NSString *SERVER_RESPONSE_CODE_1022;

@end
