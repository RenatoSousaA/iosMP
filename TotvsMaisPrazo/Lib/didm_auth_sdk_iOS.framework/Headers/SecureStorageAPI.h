//
//  SecureStorageAPI.h
//  didm_auth_sdk_iOS
//
//  Created by Wiliam Santiesteban on 5/22/17.
//  Copyright © 2017 Easy Solutions, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SecureStore.h"


@interface SecureStorageAPI : NSObject
    //This method returns a DID SecureStorage object, with the given name and is encrypted with with the machineid and the provided salt
    
    
    /**
     This method returns a DID SecureStorage object, if the storage does not exist it creates it.
     @param NSString  storageName representing the name of storage.
     @param NSString saltKey representing the salt for encrypted the value with the machineid.
     */
-(SecureStore*)getSecureStore:(NSString*) storageName salt:(NSString*) saltKey;
    /** This method remove the securestorare by name
     @param NSString  storageName representing the name of storage to remove.
     */
-(void) removeSecureStore:(NSString*) storageName;
    
    @end

