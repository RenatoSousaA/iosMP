//
//  Gestures.h
//  didm_auth_sdk_iOS
//
//  Created by Gerardo Tarazona on 9/27/18.
//  Copyright © 2018 Easy Solutions, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NullObjectDelegate.h"
@interface Gestures : NSObject <NullObjectDelegate>

@property (nonatomic,strong) NSArray* faceGestures;

- (instancetype)initWithGestures: (NSArray *)gestures;

@end
