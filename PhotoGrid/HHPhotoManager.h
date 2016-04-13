//
//  LDPhotoManager.h
//  PhotoGrid
//
//  Created by Hong on 15/10/15.
//  Copyright © 2015年 Hong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class HHPhotoGroupModel;
@interface HHPhotoManager : NSObject

///获取所有相册
+ (void)getGroupListSuccessBlock:(void (^)(NSArray *))successBlock failureBlock:(void (^)(NSError *))failureBlock;

///获取某相册中所有图片
+ (void)getPhotoListFromGroup:(id)photoGroupUrl selectedImageList:(NSArray *)selectedImageList successBlock:(void (^)(NSArray *))successBlock failureBlock:(void (^)(NSError *))failureBlock;

///获取某路径的缩略图片
+ (void)getThumbnialFromUrl:(id)url successBlock:(void (^)(UIImage *))successBlock failureBlock:(void (^)(NSError *))failureBlock;

///获取某路径的全屏图片
+ (void)getFullScreenImageFromUrl:(id)url successBlock:(void (^)(UIImage *))successBlock failureBlock:(void (^)(NSError *))failureBlock;

@end
