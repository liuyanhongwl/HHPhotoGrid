//
//  LDPhotoLibrary.h
//  PhotoGrid
//
//  Created by Hong on 15/10/15.
//  Copyright © 2015年 Hong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface HHPhotoLibrary : NSObject

- (void)getGroupListSuccessBlock:(void (^)(NSArray *))successBlock failureBlock:(void (^)(NSError *))failureBlock;

//photoGroupUrl:    ALAssetLibrary是groupUrl,PhotosKit是PHAssetCollection
- (void)getPhotoListFromGroup:(id)photoGroupUrl selectedImageList:(NSArray *)selectedImageList successBlock:(void (^)(NSArray *))successBlock failureBlock:(void (^)(NSError *))failureBlock;

//url:  ALAssetLibrary是AssetUrl, PhotosKit是PHAsset
- (void)getThumbnialFromUrl:(id)url successBlock:(void (^)(UIImage *))successBlock failureBlock:(void (^)(NSError *))failureBlock;

//url:  ALAssetLibrary是AssetUrl, PhotosKit是PHAsset
- (void)getFullScreenImageFromUrl:(id)url successBlock:(void (^)(UIImage *))successBlock failureBlock:(void (^)(NSError *))failureBlock;


@end
