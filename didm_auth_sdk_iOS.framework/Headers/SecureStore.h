//
//  SecureStore.h
//  didm_auth_sdk_iOS
//
//  Created by Wiliam Santiesteban on 5/22/17.
//  Copyright © 2017 Easy Solutions, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

#define DEPRECATED_MESSAGE "This property is no longer supported, it will be removed in the next major release"

@interface SecureStore : NSObject
    
@property (strong, nonatomic,readonly) NSString *storageName;
    
- (instancetype)initWithStorageName:(NSString *) storageName andSalt:(NSString *) salt DEPRECATED_MSG_ATTRIBUTE(DEPRECATED_MESSAGE);
    
- (void)put:(NSString *)tagName withValue:(NSString *)value DEPRECATED_MSG_ATTRIBUTE(DEPRECATED_MESSAGE);

- (NSString *)get:(NSString *)tagName DEPRECATED_MSG_ATTRIBUTE(DEPRECATED_MESSAGE);

- (void)remove:(NSString *)tagName DEPRECATED_MSG_ATTRIBUTE(DEPRECATED_MESSAGE);
    
@end

