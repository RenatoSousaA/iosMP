//
//  TipViewProperties.h
//  didm_auth_sdk_iOS
//
//  Created by Gerardo Tarazona on 10/15/18.
//  Copyright © 2018 Easy Solutions, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TipViewProperties : NSObject
@property (nonatomic)           BOOL isDefaultEnabled;
@property (nonatomic, strong)   NSString *xibName;
@property (nonatomic)           double time;

@end
