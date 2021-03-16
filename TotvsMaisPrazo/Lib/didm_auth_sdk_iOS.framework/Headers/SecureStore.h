//
//  SecureStore.h
//  didm_auth_sdk_iOS
//
//  Created by Wiliam Santiesteban on 5/22/17.
//  Copyright © 2017 Easy Solutions, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SecureStore : NSObject
    
    @property (strong, nonatomic,readonly) NSString* storageName;
    
- (instancetype)initWithStorageName:(NSString*) storageName andSalt:(NSString*) salt;
    
#pragma mark - NSString
    //this method set value string by key
- (void) put:(NSString*)tagName withValue:(NSString*)value;
    //this method get value string by key
- (NSString*) get:(NSString*)tagName;
    //this method remove value string by key
- (void) remove:(NSString*)tagName;
    
    @end

