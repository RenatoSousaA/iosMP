//
//  EncryptModule.h
//  did_sdk_tokens_ios
//
//  Created by Gerardo Tarazona on 11/20/18.
//

#import <Foundation/Foundation.h>

@interface EncryptAes : NSObject

+ (NSString *)getAESEncryptionKey;
+ (NSData *)aes128Encrypt:(NSData *)_data WithKey:(NSString *)_key;
+ (NSData *)aes128DecryptString:(NSString *)_data WithKey:(NSString *)_key;
+ (NSString *)decryptAESMessage:(NSString *)messageEncrypted withKey:(NSString*) key;
+ (NSDictionary *)decryptToken:(NSString *)encryptedToken key:(NSString *) key;
+ (NSString *)encryptToken:(NSDictionary *)tokenDic key:(NSString *) key;
@end


