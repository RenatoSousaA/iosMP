//
//  GlobalLock.h
//  didm_auth_sdk_iOS
//
//  Created by Gerardo Tarazona on 12/5/18.
//  Copyright © 2018 Easy Solutions, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface GlobalLock : NSObject
@property (nonatomic, readwrite) long code;
@property (nonatomic, strong, readwrite) NSString *lockDescription;
@property (nonatomic, readwrite) long generationDate;

@end

NS_ASSUME_NONNULL_END
