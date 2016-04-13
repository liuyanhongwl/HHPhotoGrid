//
//  LDPhotoLibraryPhoto.m
//  PhotoGrid
//
//  Created by Hong on 15/10/15.
//  Copyright © 2015年 Hong. All rights reserved.
//

#import "HHPhotoLibraryPhoto.h"
#import <Photos/Photos.h>
#import "HHPhotoGroupModel.h"
#import "HHImageModel.h"

@interface HHPhotoLibraryPhoto ()

@property (nonatomic, strong) PHCachingImageManager *imageManager;
@end

@implementation HHPhotoLibraryPhoto

#pragma mark - Setters & Getters

- (PHCachingImageManager *)imageManager
{
    if (!_imageManager) {
        _imageManager = [[PHCachingImageManager alloc] init];
    }
    return _imageManager;
}

#pragma mark - Public Method

- (void)getGroupListSuccessBlock:(void (^)(NSArray *))successBlock failureBlock:(void (^)(NSError *))failureBlock
{
    PHFetchResult *albumsResult = [PHAssetCollection fetchAssetCollectionsWithType:PHAssetCollectionTypeSmartAlbum subtype:PHAssetCollectionSubtypeAlbumRegular options:nil];
    PHImageRequestOptions *imageOptions = [[PHImageRequestOptions alloc] init];
    imageOptions.resizeMode = PHImageRequestOptionsResizeModeExact;
    CGSize imageSize = [self sizeForThumbnial];

    NSMutableArray *groups = [NSMutableArray array];
    __block int resultCount = 0;
    NSUInteger blockCount = albumsResult.count;
    for (PHCollection *colletion in albumsResult) {
        if (![colletion isKindOfClass:[PHAssetCollection class]]) {
            continue;
        }
        PHAssetCollection *assetCollection = (PHAssetCollection *)colletion;
        PHFetchResult *assetResult = [PHAsset fetchAssetsInAssetCollection:assetCollection options:nil];
        
        if (assetResult.count > 0) {
            HHPhotoGroupModel *photoGroup = [[HHPhotoGroupModel alloc] init];
            photoGroup.groupName = colletion.localizedTitle;
            photoGroup.numberOfPhotos = assetResult.count;
            photoGroup.groupUrl = colletion;
            [groups addObject:photoGroup];
            
            [self.imageManager requestImageForAsset:assetResult.lastObject targetSize:imageSize  contentMode:PHImageContentModeAspectFill options:imageOptions resultHandler:^(UIImage * _Nullable result, NSDictionary * _Nullable info) {
                BOOL donwloadFinished = ![[info objectForKey:PHImageCancelledKey] boolValue] && ![info objectForKey:PHImageErrorKey] && ![[info objectForKey:PHImageResultIsDegradedKey] boolValue];
                if (donwloadFinished) {
                    resultCount ++;
                    photoGroup.image = result;
                    if (resultCount == blockCount && successBlock) {
                        successBlock(groups);
                    }
                }
            }];

        }else{
            resultCount ++;
        }
    }
}

- (void)getPhotoListFromGroup:(id)photoGroupUrl selectedImageList:(NSArray *)selectedImageList successBlock:(void (^)(NSArray *))successBlock failureBlock:(void (^)(NSError *))failureBlock
{
    PHAssetCollection *assetCollection = (PHAssetCollection *)photoGroupUrl;
    PHFetchResult *assetResult = [PHAsset fetchAssetsInAssetCollection:assetCollection options:nil];
    NSMutableArray *photos = [[NSMutableArray alloc] init];
    NSArray *selectedAssetList = [selectedImageList valueForKeyPath:@"self.imageUrl"];
    for (PHAsset *asset in assetResult) {
        HHImageModel *imageModel = [[HHImageModel alloc] init];
        if ([selectedAssetList containsObject:asset]) {
            imageModel.isSelected = YES;
        }else{
            imageModel.isSelected = NO;
        }
        imageModel.imageUrl = asset;
        [photos addObject:imageModel];
    }
    if (successBlock) {
        successBlock(photos);
    }
}

- (void)getThumbnialFromUrl:(id)url successBlock:(void (^)(UIImage *))successBlock failureBlock:(void (^)(NSError *))failureBlock
{
    PHAsset *asset = (PHAsset *)url;
    CGSize imageSize = [self sizeForThumbnial];
    
    PHImageRequestOptions *imageOptions = [[PHImageRequestOptions alloc] init];
    imageOptions.resizeMode = PHImageRequestOptionsResizeModeExact;
    
    [self.imageManager requestImageForAsset:asset targetSize:imageSize contentMode:PHImageContentModeAspectFill options:imageOptions resultHandler:^(UIImage * _Nullable result, NSDictionary * _Nullable info) {
        BOOL donwloadFinished = ![[info objectForKey:PHImageCancelledKey] boolValue] && ![info objectForKey:PHImageErrorKey] && ![[info objectForKey:PHImageResultIsDegradedKey] boolValue];
        if (donwloadFinished && successBlock) {
            successBlock(result);
        }
    }];
}

- (void)getFullScreenImageFromUrl:(id)url successBlock:(void (^)(UIImage *))successBlock failureBlock:(void (^)(NSError *))failureBlock
{
    PHAsset *asset = (PHAsset *)url;
    CGSize imageSize = [self sizeForScreenImage];
    
    [self.imageManager requestImageForAsset:asset targetSize:imageSize contentMode:PHImageContentModeAspectFill options:nil resultHandler:^(UIImage * _Nullable result, NSDictionary * _Nullable info) {
        BOOL donwloadFinished = ![[info objectForKey:PHImageCancelledKey] boolValue] && ![info objectForKey:PHImageErrorKey] && ![[info objectForKey:PHImageResultIsDegradedKey] boolValue];
        if (donwloadFinished && successBlock) {
            successBlock(result);
        }
    }];
}

#pragma mark - Private Method

- (CGSize)sizeForThumbnial
{
    CGFloat imageWidth = [HHPhotoGroupModel sizeForPhotoGroupImage];
    CGFloat scale = [UIScreen mainScreen].scale;
    return CGSizeMake(imageWidth * scale, imageWidth * scale);
}

- (CGSize)sizeForScreenImage
{
    CGFloat imageWidth = CGRectGetWidth([UIScreen mainScreen].bounds);
    CGFloat imageHeight = CGRectGetHeight([UIScreen mainScreen].bounds);
    CGFloat scale = [UIScreen mainScreen].scale;
    return CGSizeMake(imageWidth * scale, imageHeight * scale);
}

@end
