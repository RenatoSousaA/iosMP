//
//  InitParams.h
//  didm_auth_sdk_iOS
//
//  Created by Juan Pablo Combariza on 4/26/18.
//  Copyright © 2018 Easy Solutions, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SdkSupportVersionResposeDelegate.h"

@interface InitParams: NSObject

@property (readonly)NSString *didUrl;
@property (readonly, weak, nonatomic) id<SdkSupportVersionResposeDelegate> sdkSupportVersionResposeDelegate;

@end

@interface InitParamsBuilder : NSObject
@property (nonatomic,strong)InitParams *params;
@property (nonatomic,strong)NSString *didUrlBuilder;
@property (weak, nonatomic)id<SdkSupportVersionResposeDelegate> sdkSupportVersionResposeDelegateBuilder;

- (instancetype)init;
- (InitParamsBuilder *)buildDidUrl:(NSString *)url;
- (InitParamsBuilder *)buildSdkSupportedDelegate:(id<SdkSupportVersionResposeDelegate>)supportDelagate;
- (InitParams *)buildParams;

@end
