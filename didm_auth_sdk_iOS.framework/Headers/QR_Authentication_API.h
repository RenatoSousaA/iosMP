//
//  didm_qr_sdk_1_0_iOS_6.h
//  didm_qr_sdk_1.0_iOS_6
//
//  Created by Javier Silva on 9/17/14.
//  Copyright (c) 2014 Easy Solutions Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "Account.h"
#import "QRCodeTransactionViewProperties.h"
#import "TransactionInfo.h"

#pragma mark - QR Transaction Delegate

@protocol QRCodeScanTransactionDelegate <NSObject>

@required
- (void)onQRCodeScanTransaction:(TransactionInfo *)transaction;

@end

@protocol QRCodeTransactionActionDelegate <NSObject>

@required
- (void)onConfirmQRCodeTransaction:(TransactionInfo *)transaction;
@required
- (void)onDeclineQRCodeTransaction:(TransactionInfo *)transaction;

@end

@protocol QRCodeTransactionServerResponseDelegate  <NSObject>

@required
- (void)onQRCodeTransactionServerResponse:(NSString *)response;

@end

@interface QR_Authentication_API : NSObject

#pragma mark - QR Authentication API Delegate
@property (strong, nonatomic) id<QRCodeScanTransactionDelegate> QRCodeScanTransactionDelegate;
@property (strong, nonatomic) id<QRCodeTransactionServerResponseDelegate>QRCodeTransactionServerResponseDelegate;
@property (strong, nonatomic) id<QRCodeTransactionActionDelegate> QRCodeTransactionActionDelegate;

+ (id)instance;

#pragma mark - QR Code Actions

/**
 Starts the QR Transaction Code scanning process, taking as parameter the Account related to said code. This method will add a camera-enabled subview in top of your current view. The subview can be removed by swiping the screen down. As soon as the code is scanned and analyzed, the SDK will display a native alert dialog containing the Transaction Information. Please refer to the @c setCustomQRTransactionViewController method for ways to customize this process.
 @param _currentView The currently activated View Controller. It is recommended to pass @c self on this parameter.
 @param account The Account for which the QR code will be authenticated.
 */
- (void)scanQRTransactionCode:(UIViewController *)_currentView forAccount:(Account *)account;


#pragma mark - QR Code Configuration
/**
 Customizes the text for the Transaction Native Alert’s buttons
 @param properties View properties for QR code default view
 */
- (void)setQRCodeTransactionViewProperties:(QRCodeTransactionViewProperties *)properties;

#pragma mark - Native Dialog Configuration

- (void)enableQRCodeTransactionDefaultDialog:(BOOL)enable;

#pragma mark - Custom View Controller

/**
 Sets a custom QR Transaction View Controller, which will be shown and will display the Transaction Information as soon as the QR code is read and analyzed by the SDK. For this to work, the Controller will have to extend to the public class @c AuthenticationCustomViewController, and will also have to connect the respective Interface items for the title, message, offline code and buttons on the storyboard. This method MUST be called before calling the @c scanQRTransactionCode method for the customization to take effect. Please refer to the integration manual for detailed information about this process.
 @param controller The custom View Controller to be used for the QR Transaction display.
 */

#pragma mark - Server Actions

/**
 Confirms the current QR Transaction process. This method can be called as an action at any point of the custom transaction view.
 */
- (void)confirmQRCodeTransactionAction:(TransactionInfo *)transaction;

/**
 Declines the current QR Transaction process. This method can be called as an action at any point of the custom transaction view.
 */
- (void)declineQRCodeTransactionAction:(TransactionInfo *)transaction;

- (void)setQRAuthenticationResponseAdditionalInfo:(NSDictionary *)data;

#pragma mark - Enable Response Alerts

/**
 Enables or disables the display of the Server Transaction Response Alerts. This value is enabled by default.
 @param enable A boolean value to set the alerts' display.
 */
- (void)enableQRCodeTransactionServerResponseAlerts:(BOOL)enable;

@end
