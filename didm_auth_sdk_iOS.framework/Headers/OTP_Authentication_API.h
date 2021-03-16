//
//  SDK_DID.h
//  SDK DetectID
//
//  Created by Jonathan Alonso on 6/09/13.
//  Copyright (c) 2013 Easy Solutions, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "Account.h"
#import "TokenViewProperties.h"

@import did_sdk_tokens_ios;

@interface OTP_Authentication_API : NSObject

@property (weak, nonatomic) id<OnClientArgumentsErrors> onClientArgumentsDelegate;
@property (weak, nonatomic) id<OnServerParametersErrors> onServerParametersErrorsDelegate;

#pragma mark - OTP Actions

/**
 Returns the Token as a UIView object for the specified Account. The returned view can be added as a subview, resizes itself depending on the type of device used, and its location on the screen can be customized. For example:
 @code
 UIView *subLayer = [otpSDK getTokenView:@"Client"];
 subLayer.frame = CGRectMake(100, 100, subLayer.frame.size.width, subLayer.frame.size.height);
 [self.view addSubview:subLayer];
 @endcode
 @param account The Account associated to the Token.
 @return A UIView object containing the visual representation of the Token.
 */
- (UIView *)getTokenView:(Account *)account;

/**
 Returns the Token value as a string for the specified Account.
 @param account The Account associated to the Token.
 @return A NSString object containing the Token value.
 */
- (NSString *)getTokenValue:(Account *)account;

/**
 Returns the Progress value as a Int for the specified Account.
 @param account The Account associated to the Token.
 @return A int object containing the Progress value between 0 to 100.
 */
- (int)getTokenTimeStepValue:(Account *)account;

#pragma mark - OTP Configuration

/**
 Sets the Token properties object to customize the OTP view like  progress ,Font, TextColor.
 @param TokenViewProperties A Object representation of a Toke view properties.
 */
- (void)setTokenViewProperties:(TokenViewProperties *)properties;

- (void)updateTokenTimeStepValue:(Account *)account;

- (NSString *)getOtpTokenFromAlphaNumericQuestionWithSeed:(Account *)account answer:(NSString *)answer;

- (NSString *)getOtpTokenFromNumericQuestionWithSeed:(Account *)account answer:(NSString *)answer;

- (long)getInterval:(Account *)account;

@end


