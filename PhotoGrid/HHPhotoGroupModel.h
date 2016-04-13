//
//  LDPhotoGroupModel.h
//  PhotoGrid
//
//  Created by Hong on 15/10/15.
//  Copyright © 2015年 Hong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface HHPhotoGroupModel : NSObject


@property (nonatomic, strong) id groupUrl;
@property (nonatomic, strong) UIImage *image;
@property (nonatomic, strong) NSString *groupName;
@property (nonatomic, assign) long numberOfPhotos;

+ (CGFloat)heightForPhotoGroupCell;
+ (CGFloat)sizeForPhotoGroupImage;

@end
