//
//  TokenViewProperties.h
//  didm_auth_sdk_iOS
//
//  Created by Mauricio Vivas on 10/18/16.
//  Copyright © 2016 Easy Solutions, Inc. All rights reserved.
//


#import <Foundation/Foundation.h>

@interface TokenViewProperties : NSObject

/**
 A string representation of a Color as a hexadecimal value.
 */
@property (nonatomic) NSString *FONT_COLOR;
/**
 A string representation of a Color as a hexadecimal value.
 */
@property (nonatomic) NSString *PROGRESS_BAR_COLOR;
/**
 A string representation of a Color as a hexadecimal value.
 */
@property (nonatomic) NSString *PROGRESS_BAR_BACKGROUND_COLOR;

@property (nonatomic) NSString * PROGRESS_BAR_BORDER_COLOR;

@property (nonatomic) int PROGRESS_BAR_HEIGHT;
@property (nonatomic) BOOL PROGRESS_BAR_ROUND_CORNERS;


@end
