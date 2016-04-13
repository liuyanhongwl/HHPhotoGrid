//
//  LDPhotoLibraryAsset.m
//  PhotoGrid
//
//  Created by Hong on 15/10/15.
//  Copyright © 2015年 Hong. All rights reserved.
//

#import "HHPhotoLibraryAsset.h"
#import <AssetsLibrary/AssetsLibrary.h>
#import <UIKit/UIKit.h>
#import "HHPhotoGroupModel.h"
#import "HHImageModel.h"

@interface HHPhotoLibraryAsset ()

@property (nonatomic, strong) ALAssetsLibrary *assetsLibrary;
@end

@implementation HHPhotoLibraryAsset

#pragma mark - setter & getter

- (ALAssetsLibrary *)assetsLibrary
{
    if (!_assetsLibrary) {
        _assetsLibrary = [[ALAssetsLibrary alloc] init];
    }
    return _assetsLibrary;
}

#pragma mark - Public Method

- (void)getGroupListSuccessBlock:(void (^)(NSArray *))successBlock failureBlock:(void (^)(NSError *))failureBlock
{
    NSMutableArray *groups = [[NSMutableArray alloc] init];
    
    NSUInteger type = ALAssetsGroupLibrary | ALAssetsGroupAlbum | ALAssetsGroupEvent | ALAssetsGroupFaces | ALAssetsGroupPhotoStream | ALAssetsGroupSavedPhotos;
    
    ALAssetsLibraryGroupsEnumerationResultsBlock resultsBlock = ^(ALAssetsGroup *assetsGroup, BOOL *stop) {
        if (assetsGroup) {
            [assetsGroup setAssetsFilter:[ALAssetsFilter allPhotos]];
            if (assetsGroup.numberOfAssets > 0) {
                HHPhotoGroupModel *photoGroup = [self photoGroupFromAssetsGroup:assetsGroup];
                [groups addObject:photoGroup];
            }
        }else{
            if (successBlock) {
                successBlock (groups);
            }
        }
    };
    
    [self.assetsLibrary enumerateGroupsWithTypes:type usingBlock:resultsBlock failureBlock:failureBlock];
    
}

- (void)getPhotoListFromGroup:(id)photoGroupUrl selectedImageList:(NSArray *)selectedImageList successBlock:(void (^)(NSArray *))successBlock failureBlock:(void (^)(NSError *))failureBlock
{
    //先找到group， 再找对应asset
    NSURL *groupUrl = (NSURL *)photoGroupUrl;
    NSMutableArray *photos = [[NSMutableArray alloc] init];
    NSArray *selectedUrlList = [selectedImageList valueForKeyPath:@"self.imageUrl"];
    
    [self.assetsLibrary groupForURL:groupUrl resultBlock:^(ALAssetsGroup *assetsGroup) {
        if (assetsGroup) {
            [assetsGroup enumerateAssetsUsingBlock:^(ALAsset *asset, NSUInteger index, BOOL *stop) {
                if (asset) {
                    HHImageModel *imageModel = [self imageModelFormAsset:asset selectedUrlList:selectedUrlList];
                    [photos addObject:imageModel];
                }else{
                    if (successBlock) {
                        successBlock(photos);
                    }
                }
            }];
        }
    } failureBlock:failureBlock];
}

- (void)getThumbnialFromUrl:(id)url successBlock:(void (^)(UIImage *))successBlock failureBlock:(void (^)(NSError *))failureBlock
{
    NSURL *assetUrl = (NSURL *)url;
    ALAssetsLibraryAssetForURLResultBlock resultBlock = ^(ALAsset *asset) {
        UIImage *image = [self thumbnailFromAsset:asset];
        if (image && successBlock) {
            successBlock(image);
        }
    };
    
    [self.assetsLibrary assetForURL:assetUrl resultBlock:resultBlock failureBlock:failureBlock];
}

- (void)getFullScreenImageFromUrl:(id)url successBlock:(void (^)(UIImage *))successBlock failureBlock:(void (^)(NSError *))failureBlock
{
    NSURL *assetUrl = (NSURL *)url;
    ALAssetsLibraryAssetForURLResultBlock resultBlock = ^(ALAsset *asset) {
        UIImage *image = [self fullScreenImageFromAsset:asset];
        if (image && successBlock) {
            successBlock(image);
        }
    };
    
    [self.assetsLibrary assetForURL:assetUrl resultBlock:resultBlock failureBlock:failureBlock];
}

#pragma mark - Private Method

- (HHPhotoGroupModel *)photoGroupFromAssetsGroup:(ALAssetsGroup *)assetsGroup
{
    HHPhotoGroupModel *photoGroup = [[HHPhotoGroupModel alloc] init];
    
    CGImageRef groupImage = assetsGroup.posterImage;
    size_t height = CGImageGetHeight(groupImage);
    float scale = height / [HHPhotoGroupModel sizeForPhotoGroupImage];
    
    photoGroup.image = [UIImage imageWithCGImage:groupImage scale:scale orientation:UIImageOrientationUp];
    photoGroup.groupName = [assetsGroup valueForProperty:ALAssetsGroupPropertyName];
    photoGroup.groupUrl = [assetsGroup valueForProperty:ALAssetsGroupPropertyURL];
    photoGroup.numberOfPhotos = assetsGroup.numberOfAssets;
    
    return photoGroup;
}

- (HHImageModel *)imageModelFormAsset:(ALAsset *)asset selectedUrlList:(NSArray *)selectedUrlList
{
    HHImageModel *imageModel = [[HHImageModel alloc] init];
    imageModel.imageUrl = [asset valueForProperty:ALAssetPropertyAssetURL];
    if ([selectedUrlList containsObject:imageModel.imageUrl]) {
        imageModel.isSelected = YES;
    }else{
        imageModel.isSelected = NO;
    }
    return imageModel;
}

- (UIImage *)thumbnailFromAsset:(ALAsset *)asset
{
    CGImageRef imageRef = asset.thumbnail;
    UIImage *image = [UIImage imageWithCGImage:imageRef];
    return image;
}

- (UIImage *)fullScreenImageFromAsset:(ALAsset *)asset
{
    CGImageRef imageRef = [[asset defaultRepresentation] fullScreenImage];
    UIImage *image = [UIImage imageWithCGImage:imageRef];
    return image;
}


@end
