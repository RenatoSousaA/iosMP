//
//  TouchIDRegistrationViewProperties.h
//  didm_auth_sdk_iOS
//
//  Created by Mauricio Vivas on 10/18/16.
//  Copyright © 2016 Easy Solutions, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FingerprintRegistrationViewProperties : NSObject
@property (nonatomic) NSString *TITLE;
@property (nonatomic) NSString *MESSAGE;
@property (nonatomic) NSString *SETTINGS DEPRECATED_MSG_ATTRIBUTE("This property is no longer supported, it will be removed in the next major realese");
@property (nonatomic) NSString *CANCEL;

@end
