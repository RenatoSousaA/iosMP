//
//  FaceTransactionViewProperties.h
//  didm_auth_sdk_iOS
//
//  Created by Wiliam Santiesteban on 6/20/17.
//  Copyright © 2017 Easy Solutions, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FaceTransactionViewProperties.h"
#import "FaceRegistrationViewProperties.h"
#import "TipViewProperties.h"

#define DEPRECATED_MESSAGE "This property is no longer supported, it will be removed in the next major release"

@interface FaceTransactionViewProperties : NSObject
#pragma mark - Dialog
/** Dialog **/
@property (nonatomic, strong) NSString * SERVER_RESPONSE_DIALOG_TITLE DEPRECATED_MSG_ATTRIBUTE(DEPRECATED_MESSAGE);
@property (nonatomic, strong) NSString * SERVER_RESPONSE_DIALOG_RETRY DEPRECATED_MSG_ATTRIBUTE(DEPRECATED_MESSAGE);
@property (nonatomic, strong) NSString * SERVER_RESPONSE_DIALOG_OK DEPRECATED_MSG_ATTRIBUTE(DEPRECATED_MESSAGE);
@property (nonatomic, strong) NSString * SERVER_RESPONSE_DIALOG_CANCEL DEPRECATED_MSG_ATTRIBUTE(DEPRECATED_MESSAGE);
#pragma mark - Responses
/** Responses **/
@property (nonatomic, strong) NSString *SERVER_RESPONSE_CODE_98;
@property (nonatomic, strong) NSString *SERVER_RESPONSE_CODE_99;
@property (nonatomic, strong) NSString *SERVER_RESPONSE_CODE_1002;
@property (nonatomic, strong) NSString *SERVER_RESPONSE_CODE_1010;
@property (nonatomic, strong) NSString *SERVER_RESPONSE_CODE_1011;
@property (nonatomic, strong) NSString *SERVER_RESPONSE_CODE_1012;
@property (nonatomic, strong) NSString *SERVER_RESPONSE_CODE_1020;
@property (nonatomic, strong) NSString *SERVER_RESPONSE_CODE_1021;
@property (nonatomic, strong) NSString *SERVER_RESPONSE_CODE_1022;
#pragma mark - Error
/** Error **/
@property (nonatomic, strong) NSString *FACE_CAMERA_PERMISSION_ERROR;
@property (nonatomic, strong) NSString *FACE_LIVENESS_UNSUCCESS;
#pragma mark - faceID view
/** faceID view **/
@property (nonatomic, strong) NSString *FACE_TIPS_TOO_CLOSE_MESSAGE_TEXT;
@property (nonatomic)        NSInteger FACE_TIPS_TOO_CLOSE_MESSAGE_TEXT_SIZE;
@property (nonatomic, strong) NSString *FACE_TIPS_EXIT_MESSAGE_TEXT;
@property (nonatomic)        NSInteger FACE_TIPS_EXIT_MESSAGE_TEXT_SIZE;
@property (nonatomic)        NSString *FACE_TIPS_EXIT_MESSAGE_TEXT_COLOR;
@property (nonatomic, strong) NSString *FACE_TIPS_MESSAGE_COLOR;
@property (nonatomic, strong) TipViewProperties  *TIP_VIEW_PROPERTIES;
#pragma mark - liveness gestures view
/** liveness gestures view **/
@property (nonatomic, strong) NSString   *GESTURE_SMILE_TEXT;
@property (nonatomic, strong) NSString   *GESTURE_SMILE_GIF;
@property (nonatomic, strong) NSString   *GESTURE_NEUTRAL_TEXT;
@property (nonatomic, strong) NSString   *GESTURE_NEUTRAL_GIF;
@property (nonatomic, strong) NSString   *GESTURE_SIDE_TO_SIDE_TEXT;
@property (nonatomic, strong) NSString   *GESTURE_SIDE_TO_SIDE_GIF;
@property (nonatomic, strong) NSString   *GESTURE_BLINK_TEXT;
@property (nonatomic, strong) NSString   *GESTURE_BLINK_GIF;
@property (nonatomic, strong) NSString   *GESTURE_COLOR;
@property (nonatomic)        NSInteger   GESTURE_TEXT_SIZE;
@property (nonatomic, strong) NSString   *GESTURE_PROGRESS_BAR_COLOR;
@property (nonatomic, strong) NSString   *TYPOGRAPHY;
@property (nonatomic)        BLUR_TYPE   TYPE_BLUR;

@end
