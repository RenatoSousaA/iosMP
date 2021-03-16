//
//  RSAController.h
//  did_sdk_tokens_ios
//
//  Created by Gerardo Tarazona on 11/20/18.
//

#import <Foundation/Foundation.h>
#import "Account.h"

NS_ASSUME_NONNULL_BEGIN

@interface EncryptRSA : NSObject

+ (NSString *)encryptString:(NSString *)info withAccount:(AccountToken *)account;
+ (NSString *)signData:(NSData *)data withAccount:(AccountToken *)account;
+ (NSString *)verifyData:(NSDictionary *)originalDic forAccount:(AccountToken *)account;
+ (NSData *)encryptData:(NSData *)data withAccount:(AccountToken *)account;
+ (NSData *)decryptData:(NSString *)info withAccount:(AccountToken *)account;
+ (NSString *)getStringFromData:(NSData*)data;
@end

NS_ASSUME_NONNULL_END
