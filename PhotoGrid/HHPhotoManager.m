//
//  LDPhotoManager.m
//  PhotoGrid
//
//  Created by Hong on 15/10/15.
//  Copyright © 2015年 Hong. All rights reserved.
//

#import "HHPhotoManager.h"
#import "HHPhotoLibrary.h"
#import "HHPhotoLibraryFactory.h"

@interface HHPhotoManager ()

@property (nonatomic, strong)HHPhotoLibrary *library;
@end

@implementation HHPhotoManager

+ (instancetype)shareManager
{
    static HHPhotoManager *manager;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[HHPhotoManager alloc] init];
    });
    return manager;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        _library = [HHPhotoLibraryFactory createPhotoLibrary];
    }
    return self;
}

///获取所有相册
+ (void)getGroupListSuccessBlock:(void (^)(NSArray *))successBlock failureBlock:(void (^)(NSError *))failureBlock;
{
    [[[HHPhotoManager shareManager] library] getGroupListSuccessBlock:successBlock failureBlock:failureBlock];
}

///获取某相册中所有图片
+ (void)getPhotoListFromGroup:(id)photoGroupUrl selectedImageList:(NSArray *)selectedImageList successBlock:(void (^)(NSArray *))successBlock failureBlock:(void (^)(NSError *))failureBlock
{
//    [[[LDPhotoManager shareManager] library] getPhotoListFromGroup:photoGroupUrl successBlock:successBlock failureBlock:failureBlock];
    [[[HHPhotoManager shareManager] library] getPhotoListFromGroup:photoGroupUrl selectedImageList:selectedImageList successBlock:successBlock failureBlock:failureBlock];
}

///获取某路径的缩略图片
+ (void)getThumbnialFromUrl:(id)url successBlock:(void (^)(UIImage *))successBlock failureBlock:(void (^)(NSError *))failureBlock
{
    [[[HHPhotoManager shareManager] library] getThumbnialFromUrl:url successBlock:successBlock failureBlock:failureBlock];
}

///获取某路径的全屏图片
+ (void)getFullScreenImageFromUrl:(id)url successBlock:(void (^)(UIImage *))successBlock failureBlock:(void (^)(NSError *))failureBlock
{
    [[[HHPhotoManager shareManager] library] getFullScreenImageFromUrl:url successBlock:successBlock failureBlock:failureBlock];
}

@end
