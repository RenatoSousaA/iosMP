//
//  VoiceAuthenticationAPI.h
//  Voice
//
//  Created by Jose Consuegra on 3/12/15.
//  Copyright © 2015 Jose Consuegra. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "TransactionInfo.h"
#import "VoiceRegistrationViewProperties.h"
#import "VoiceTransactionViewProperties.h"

#pragma mark - Voice Response Delegate
@protocol VoiceRegistrationServerResponseDelegate <NSObject>

@required
- (void) onVoiceRegistrationServerResponse:(NSString*) response;
@end

#pragma mark - Voice Response Delegate
@protocol VoiceTransactionServerResponseDelegate <NSObject>

@required
- (void) onVoiceTransactionServerResponse:(NSString*) response;

@end

#pragma mark - Voice Registration Delegate
@protocol VoiceRegistrationOpenDelegate <NSObject>

@required
- (void) onVoiceRegistrationOpen;

@end

#pragma mark - Voice Authentication Delegate
@protocol VoiceTransactionOpenDelegate <NSObject>

@required
- (void) onVoiceTransactionOpen:(TransactionInfo*) transaction;

@end


@interface Voice_Authentication_API : NSObject



#pragma mark - Voice Authentication API Delegates
@property (strong, nonatomic) id<VoiceRegistrationServerResponseDelegate> voiceRegistrationServerResponseDelegate;

@property(strong,nonatomic) id<VoiceTransactionServerResponseDelegate> voiceTransactionServerResponseDelegate;

@property (strong, nonatomic) id<VoiceRegistrationOpenDelegate> voiceRegistrationOpenDelegate;

@property (strong, nonatomic) id<VoiceTransactionOpenDelegate> voiceTransactionOpenDelegate;

+ (id)instance;

#pragma mark - Server Actions

-(BOOL)sendVoiceRegistrationAction;


#pragma mark - Voice Actions

-(BOOL) startVoiceRegistrationRecording;

-(BOOL) stopVoiceRegistrationRecording;

-(BOOL) startVoiceTransactionRecording;

-(BOOL) stopVoiceTransactionRecording;

-(void) clearRegistrationVoiceSamples;

-(void) clearTransactionVoiceSample;

-(int) getStoredRegistrationVoiceSamplesCount;

-(NSMutableArray *) getVoiceInfoForRegistration;

-(NSString*) getVoiceInfoForAuthentication;

- (void) setVoiceAuthenticationResponseAdditionalInfo:(NSDictionary*) data;


#pragma mark - Native Dialog Configuration

-(void) setVoiceRegistrationViewProperties:(VoiceRegistrationViewProperties *) properties;


- (void) setVoiceTransactionViewProperties:(VoiceTransactionViewProperties *)properties;



/**
 Enables or disables the display of the Dialog for retreive the voice registration. This value is enabled by default.
 @param enable A boolean value to set the alerts' display.
 */
- (void)enableVoiceRegistrationDefaultDialog:(BOOL)enable;

/**
 Enables or disables the display of the Dialog for retreive the voice registrations. This value is enabled by default.
 @param enable A boolean value to set the alerts' display.
 */
- (void)enableVoiceTransactionDefaultDialog:(BOOL)enable;

#pragma mark - DIDPushObject Configuration

-(BOOL)sendVoiceTransactionAction:(TransactionInfo*) transaction;

#pragma mark - Enable Response Alerts

/**
 Enables or disables the display of the Server Alert Views after a Voice Registration Attempt. This value is enabled by default.
 @param enable A boolean value to set the alerts' display.
 */
- (void)enableVoiceRegistrationServerResponseAlerts:(BOOL)enable;

/**
 Enables or disables the display of the Server Alert Views after a Voice Authentication Attempt. This value is enabled by default.
 @param enable A boolean value to set the alerts' display.
 */
- (void)enableVoiceTransactionServerResponseAlerts:(BOOL)enable;

@end
