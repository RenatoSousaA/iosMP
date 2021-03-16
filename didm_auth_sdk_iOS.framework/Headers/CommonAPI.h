//
//  CommonAPI.h
//  didm_auth_sdk_1.0_iOS_6
//
//  Created by Javier Silva on 12/10/14.
//  Copyright (c) 2014 Easy Solutions Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "Account.h"
#import "RegistrationViewProperties.h"
#import "FingerprintTransactionViewProperties.h"
#import "FingerprintRegistrationViewProperties.h"
#import <UserNotifications/UserNotifications.h>
#import <UserNotificationsUI/UserNotificationsUI.h>
#import "SdkSupportVersionResposeDelegate.h"
#import "InitParams.h"

@protocol DeviceRegistrationServerResponseDelegate <NSObject>

@required
- (void)onRegistrationResponse:(NSString *)result;

@end

@interface CommonAPI : NSObject

@property (nonatomic, assign) id<DeviceRegistrationServerResponseDelegate>deviceRegistrationServerResponseDelegate;

+ (id)instance;

- (void)initWithDIDServer:(NSString *)_serverURL DEPRECATED_MSG_ATTRIBUTE("the method initWithDIDServer:(NSString *)_serverURL is no longer supported, please use instead initDIDServerWithParams:(InitParams *)initParams");

- (void)initDIDServerWithParams:(InitParams *)initParams;

- (BOOL)isSdkVersionSupported;

- (void)receivePushServiceId:(NSData *)_tokenId;

- (NSString *)getDeviceID;

- (NSString *)getSharedDeviceID;

- (void)displayDeviceRegistrationDialog;

- (void)deviceRegistrationByCode:(NSString *)_code;

- (void)deviceRegistrationByQRCode:(UIViewController *)_currentView;

- (void)setRegistrationViewProperties:(RegistrationViewProperties *)viewProperties;

- (NSArray *)getAccounts;

- (BOOL)existAccounts;

- (void)removeAccount:(Account *)account;

- (void)setAccountUsername:(NSString *)username forAccount:(Account *)account;

- (void)customLicenseAgreementPageTitle:(NSString *)title backButton:(NSString *)backButtonLabel backgroundBarColor:(UIColor *)colorBackground colorTitle:(UIColor *)colorTitle colorButton:(UIColor *)colorButton;

- (void)enableRegistrationServerResponseAlerts:(BOOL)enable;

- (void)configureSecurityCertificateConnection:(NSArray *)fileNames;

- (void)enableSecureCertificateValidationProtocol:(BOOL)enable;

- (void)setFingerprintRegistrationViewProperties:(FingerprintRegistrationViewProperties *)properties;

- (void)setFingerprintTransactionViewProperties:(FingerprintTransactionViewProperties *)properties;

- (void)subscribePayload:(NSDictionary *)notificationInfo;

- (BOOL)isValidPayload:(NSDictionary *)userInfo;

- (void)handleActionWithIdentifier:(NSString *)identifier forNotification:(NSDictionary *)userInfo;

- (void)subscribePayload:(UNNotification *)notification withCompletionHandler:(void (^)(UNNotificationPresentationOptions options))completionHandler;

- (void)handleActionWithIdentifier:(UNNotificationResponse *)response;

- (NSSet *)getNotificationActionCategoriesForNotifications;

- (NSSet *)getUNNotificationActionCategoriesForNotifications;

@end
