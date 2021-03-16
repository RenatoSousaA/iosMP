//
//  didm_push_sdk_1_0_iOS_6.h
//  didm_push_sdk_1.0_iOS_6
//
//  Created by Jonathan Alonso on 12/12/13.
//  Copyright (c) 2013 Easy Solutions. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <UserNotifications/UserNotifications.h>
#import <UserNotificationsUI/UserNotificationsUI.h>
#import "TransactionInfo.h"
#import "PushTransactionViewProperties.h"
#import "PushAlertViewProperties.h"

#pragma mark - Push Transaction Delegates
@protocol PushTransactionOpenDelegate <NSObject>

@required
- (void)onPushTransactionOpen:(TransactionInfo *)transaction;

@end

@protocol PushTransactionActionDelegate <NSObject>

@required
- (void)onConfirmPushTransaction:(TransactionInfo *)transaction;
@required
- (void)onDeclinePushTransaction:(TransactionInfo *)transaction;

@end

@protocol PushTransactionServerResponseDelegate <NSObject>

@required
- (void)onPushTransactionServerResponse:(NSString *)response;

@end

#pragma mark - Push Alert Delegates
@protocol PushAlertOpenDelegate <NSObject>

@required
- (void)onPushAlertOpen:(TransactionInfo *)transaction;

@end

@interface Push_Authentication_API : NSObject

#pragma mark - Push Authentication API Delegates

@property (strong, nonatomic) id<PushTransactionOpenDelegate> pushTransactionOpenDelegate;
@property (strong, nonatomic) id<PushTransactionActionDelegate> pushTransactionActionDelegate;
@property (strong, nonatomic) id<PushTransactionServerResponseDelegate> pushTransactionServerResponseDelegate;

@property (strong, nonatomic) id<PushAlertOpenDelegate> pushAlertOpenDelegate;


+ (id)instance;

#pragma mark - Remote Notification Configuration


/**
 Performs a Notification Action whenever the user presses one of the Quick Action buttons. The Action is determined by the button's identifier. The Action won't be performed if the Notification fails to pass Server validation. This method should be called at the @c handleActionWithIdentifier:forRemoteNotification:completionHandler method of the Application's Delegate.
 @code
 - (void)application:(UIApplication *)application handleActionWithIdentifier:(NSString *)identifier forRemoteNotification:(NSDictionary *)userInfo completionHandler:(void (^)())completionHandler{
 
 [[[DetectID sdk] Push_API] handleActionWithIdentifier:identifier forNotification:userInfo];
 
 completionHandler();
 }
 @endcode
 @param identifier The String that identifies the selected Action.
 @param userInfo The Notification's info.
 */

- (NSString *)getAccountDataForPushInfo:(NSDictionary *)userInfo;

- (NSDictionary *)getLastPushPayloadReceived;

#pragma mark - Native Dialog Configuration

- (void)enablePushTransactionDefaultDialog:(BOOL)enable;

- (void)enablePushAlertDefaultDialog:(BOOL)enable;

/**
 Customizes the Transaction View
 @param viewProperties Object for customize push transaction view
 */
- (void)setPushTransactionViewProperties:(PushTransactionViewProperties *)viewProperties;

- (void)setPushAlertViewProperties:(PushAlertViewProperties *)viewProperties;

#pragma mark - Custom View Controller

/**
 Confirms the current Push Transaction process. This method can be called as an action at any point of the custom transaction view.
 */
- (void)confirmPushTransactionAction:(TransactionInfo *)transaction;

/**
 Declines the current Push Transaction process. This method can be called as an action at any point of the custom transaction view.
 */
- (void)declinePushTransactionAction:(TransactionInfo *)transaction;

/**
 Approves the current Push Alert. This method can be called as an action at any point of the custom transaction view.
 */
- (void)approvePushAlertAction:(TransactionInfo *)transaction;

/**
 Approves the current Push Alert. This method can be called as an action at any point of the custom transaction view.
 */
- (void)setPushAuthenticationResponseAdditionalInfo:(NSDictionary *)data;


#pragma mark - Enable Response Alerts

/**
 Enables or disables the display of the Server Transaction Response Alerts. This value is enabled by default.
 @param enable A boolean value to set the alerts' display.
 */
- (void)enablePushTransactionServerResponseAlerts:(BOOL)enable;

@end

