//
//  LDPhotoLibraryFactory.m
//  PhotoGrid
//
//  Created by Hong on 15/10/15.
//  Copyright © 2015年 Hong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HHPhotoLibraryFactory.h"
#import "HHPhotoLibraryAsset.h"
#import "HHPhotoLibraryPhoto.h"

@implementation HHPhotoLibraryFactory

+ (HHPhotoLibrary *)createPhotoLibrary
{
    CGFloat version = [[[UIDevice currentDevice] systemVersion] floatValue];
    
    if (version < 9.0) {
        return [[HHPhotoLibraryAsset alloc] init];
    }else{
        return [[HHPhotoLibraryPhoto alloc] init];
    }
}

@end
