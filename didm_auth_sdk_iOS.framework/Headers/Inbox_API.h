//
//  INBOX API.h
//  didm_auth_sdk_iOS
//
//  Created by Mauricio Vivas on 10/20/16.
//  Copyright © 2016 Easy Solutions, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TransactionInfo.h"

@interface Inbox_API : NSObject

+ (id)instance;

#pragma mark - Enable Response Alerts

- (void)resetBadgeNumber;

- (void)automaticResetBadgeNumber:(BOOL)enable;

- (void)displayTransactionDialog:(TransactionInfo *)transaction;

- (void)setupTransactionInbox:(NSString *)urlPushAlert urlPushAuth:(NSString *)urlPushAuth urlPushBiometric:(NSString *)urlPushBiometric;

- (void)getAllTransactionsByType:(Account *)account type:(TransactionType)transactionType page:(int)pageTransaction onResponseSuccessfull:(void (^)(NSArray *, int, int))onResponseSuccessfull onResponseFail:(void (^)(NSString *))onResponseFail;

@end
