//
//  SecureStorageAPI.h
//  didm_auth_sdk_iOS
//
//  Created by Wiliam Santiesteban on 5/22/17.
//  Copyright © 2017 Easy Solutions, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SecureStore.h"

#define DEPRECATED_MESSAGE "This property is no longer supported, it will be removed in the next major release"

@interface SecureStorageAPI: NSObject

- (SecureStore *)getSecureStore:(NSString *)storageName salt:(NSString *)saltKey DEPRECATED_MSG_ATTRIBUTE(DEPRECATED_MESSAGE);

- (void)removeSecureStore:(NSString *)storageName DEPRECATED_MSG_ATTRIBUTE(DEPRECATED_MESSAGE);
    
@end

