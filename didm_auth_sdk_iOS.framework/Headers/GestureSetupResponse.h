//
//  GestureSetupResponse.h
//  didm_auth_sdk_iOS
//
//  Created by Juan Pablo Combariza on 2/13/18.
//  Copyright © 2018 Easy Solutions, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GenericDidResponse.h"
#import "ResponseCode.h"
#import "AppCompatibility.h"
#import "FaceServerGestures.h"

@interface GestureSetupResponse : GenericDidResponse

@property (nonatomic, strong) ResponseCode *response;
@property (nonatomic, strong) AppCompatibility *app;
@property (nonatomic, strong) FaceServerGestures *factors;

@end
