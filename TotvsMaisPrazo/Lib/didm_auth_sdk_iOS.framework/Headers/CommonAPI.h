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
-(void)onRegistrationResponse:(NSString *) result;
@end

@interface CommonAPI : NSObject


@property (nonatomic, assign) id<DeviceRegistrationServerResponseDelegate>deviceRegistrationServerResponseDelegate;

#pragma mark - DetectID SDK Initialization

+ (id)instance;

/**
 Initializes the instance of the DetectID Authenticator SDK, setting the Server URL. This will allow the invoking of each of the Authentication APIs as well as their common initialization methods.
 @param _serverURL The Server URL, which will be used to activate a new Account with its respective Code. If passed null, the SDK will expect the complete URL as the Account Activation Code.
 */
- (void)initWithDIDServer:(NSString *)_serverURL DEPRECATED_MSG_ATTRIBUTE("the method initWithDIDServer:(NSString *)_serverURL is no longer supported, please use instead initDIDServerWithParams:(InitParams *)initParams");

- (void)initDIDServerWithParams:(InitParams *)initParams;


/**
 this method returns the value about if the SDK is supporte, if it is not possible get a connection the default value is NO

 @return if the sdk version is supportes
 */
- (BOOL)isSdkVersionSupported;

/**
 Receives the Device Push Notifications ID which will be used for the Account Activation process.
 This function must be called at the Application's @c didRegisterForRemoteNotificationsWithDeviceToken method.
 @param _tokenId A NSData object representing the Push Notifications ID.
 */
- (void)receivePushServiceId:(NSData *)_tokenId;

-(NSString*) getDeviceID;

-(NSString*) getSharedDeviceID;

#pragma mark - Registration Actions

/**
 Displays an Alert Dialog that allows the user to activate a new Account.
 */
- (void)displayDeviceRegistrationDialog;

/**
 Attempts the Device Registration using the specified URL Code. It is useful when a custom Activation Interface is desired.
 @param code The URL Activation code. It can be a complete URL or a single Code, depending of the @c serverURL initialization parameter.
 */
- (void)deviceRegistrationByCode:(NSString *)_code;

/**
 Attempts the Device Registration by scanning a QR Activation Code. This method will add a camera-enabled subview on top of your current view. The subview can be removed by swiping the screen down.
 @param _currentView The Application's currently activated View Controller. It is recommended to pass @c self on this parameter.
 */
-(void)deviceRegistrationByQRCode:(UIViewController *)_currentView;

#pragma mark - Registration Dialog Configuration

/**
 Set the Registration Dialog Object for customize the alert view.
 @param RegistrationViewProperties A Object representation of alert view content
 */
- (void)setRegistrationViewProperties:(RegistrationViewProperties *) viewProperties;

#pragma mark - Accounts Actions

/**
 Returns the currently storaged Accounts on the device.
 @return A NSArray object containing the Accounts.
 */
- (NSArray *)getAccounts;


/**
 Checks whether there is any Account storaged on the device.
 @return A boolean value representing the existence of any Acocunt.
 */
- (BOOL)existAccounts;

/**
 Removes the specified account from the device. This method will delete any service related to said account.
 @param account The Account to be removed.
 */
- (void)removeAccount:(Account *)account;

/**
 Sets a desired Username for the specified Account. A Username represents a custom name to recognize Accounts when they share a common Organization Name.
 @param username The Username to be set.
 @param account The Account to which the Username will be set.
 */
- (void)setAccountUsername:(NSString *)username forAccount:(Account *)account;

#pragma mark - License Agreement Configuration

-(void)customLicenseAgreementPageTitle:(NSString*) title backButton:(NSString*) backButtonLabel backgroundBarColor: (UIColor*) colorBackground colorTitle:(UIColor*) colorTitle colorButton:(UIColor*) colorButton;

#pragma mark - Enable Response Alerts

/**
 Enables or disables the display of the Server Alert Views after a Registration Attempt. This value is enabled by default.
 @param enable A boolean value to set the alerts' display.
 */
- (void)enableRegistrationServerResponseAlerts:(BOOL)enable;

#pragma mark - Ceritificate Pinning

-(void)configureSecurityCertificateConnection:(NSArray*)fileNames;

-(void)enableSecureCertificateValidationProtocol:(BOOL) enable;

#pragma mark - TouchID API

-(void) setFingerprintRegistrationViewProperties:(FingerprintRegistrationViewProperties *) properties;

-(void) setFingerprintTransactionViewProperties:(FingerprintTransactionViewProperties *) properties;

/**
 Receives the Push Notification information. If it passes the server's validation, it will display a default Transaction Alert with said information. If not, it will display an "invalid notification" dialog. This method should be called at the @c didReceiveRemoteNotification method of the Application's Delegate.
 @param notificationInfo A NSDictionary-type data containing the Push Notification information.
 */
- (void) subscribePayload:(NSDictionary *)notificationInfo;

-(BOOL) isValidPayload:(NSDictionary *) userInfo;

- (void)handleActionWithIdentifier:(NSString *)identifier forNotification:(NSDictionary *)userInfo;


/**
 iOS 10 push notification API
 */
- (void)subscribePayload:(UNNotification *)notification withCompletionHandler:(void (^)(UNNotificationPresentationOptions options))completionHandler;

- (void)handleActionWithIdentifier:(UNNotificationResponse *)response;


/**
 Sets the Notification Quick Action Buttons' text and returns a collection of objects with their categories' settings.
 @param cancelText Text for the Cancel button
 @param acceptText Text for the Accept button
 @return A NSSet containing the actions' settings. This object should be passed as the @c categories parameter of the @c settingsForTypes:categories: method of your @c UIUserNotificationSettings object.
 @code
 UIUserNotificationSettings *settings =
 [UIUserNotificationSettings settingsForTypes:(UIUserNotificationTypeBadge | UIUserNotificationTypeAlert | UIUserNotificationTypeSound)
 categories:[[[DetectID sdk] Push_API] setNotificationActionCategoriesForCancelButton:@"cancelButtonText" acceptButton:@"acceptButtonText"]];
 @endcode
 */
- (NSSet *)getNotificationActionCategoriesForNotifications;

- (NSSet *)getUNNotificationActionCategoriesForNotifications;

@end
