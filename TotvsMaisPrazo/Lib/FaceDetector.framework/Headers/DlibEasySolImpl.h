//
//  DlibWrapper.h
//  DisplayLiveSamples
//
//  Created by Luis Reisewitz on 16.05.16.
//  Copyright © 2016 ZweiGraf. All rights reserved.
//
#import <Foundation/Foundation.h>
#import <CoreMedia/CoreMedia.h>


@interface DlibEasySolImpl : NSObject

/*!
 @brief Create an intance of DlibEasySolImpl class, this class allows to use dlib library in order to retrieve face detecttion information
 @param faceModelFileName The input value representing the face detection model needed by dlib
 @param netModelFileName The input value representing the neuronal net model needed by dlib
 @param bundlePath if there is a bundle that contains the faceModelFileName and netModelFileName, the input value is the name. If this parammeter is setted nil, then the main Bundle is used instead.
 @return instancetype The instance of DlibEasySolImpl
 */
- (instancetype) initWithFaceModelFileName:(NSString *) faceModelFileName withNetModelFileName: (NSString *) netModelFileName withBundlePath:(NSString *) bundlePath;

/*!
 @brief It converts temperature degrees from Fahrenheit to Celsius scale.
 @discussion This method throw DataDetectionExceptionHandler when something is grong configurated.
 @param  imageFileNamePath The input value representing the image path to analyze
 @return NSString The vector data related with the image that contains at less one face.
 */
- (NSString*) getVectorDataWithImageFilePath:(NSString *) imageFileNamePath ;

@end

