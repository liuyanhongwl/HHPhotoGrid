//
//  LDBigImageViewController.h
//  PhotoGrid
//
//  Created by Hong on 15/10/16.
//  Copyright © 2015年 Hong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HHBigImageViewController : UIViewController

@property (nonatomic, strong) NSArray *photoList;
@property (nonatomic, assign) NSUInteger photoIndex;
@property (nonatomic, assign) NSUInteger maxCount;
@property (nonatomic, copy) void (^selectButtonBlock)(BOOL isSelected);    //选择图片

@end
