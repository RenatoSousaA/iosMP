//
//  PushAlertViewProperties.h
//  didm_auth_sdk_iOS
//
//  Created by Mauricio Vivas on 10/19/16.
//  Copyright © 2016 Easy Solutions, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#define DEPRECATED_MESSAGE "This property is no longer supported, it will be removed in the next major release"

@interface PushAlertViewProperties : NSObject

@property(nonatomic)NSString *APPROVE;
@property(nonatomic)NSString *SERVER_RESPONSE_CODE_96 DEPRECATED_MSG_ATTRIBUTE(DEPRECATED_MESSAGE);
@property(nonatomic)NSString *SERVER_RESPONSE_CODE_98 DEPRECATED_MSG_ATTRIBUTE(DEPRECATED_MESSAGE);
@property(nonatomic)NSString *SERVER_RESPONSE_CODE_99 DEPRECATED_MSG_ATTRIBUTE(DEPRECATED_MESSAGE);
@property(nonatomic)NSString *SERVER_RESPONSE_CODE_1020 DEPRECATED_MSG_ATTRIBUTE(DEPRECATED_MESSAGE);

@end
