//
//  LDImageGroupViewController.h
//  PhotoGrid
//
//  Created by Hong on 15/10/15.
//  Copyright © 2015年 Hong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HHImageGroupViewController : UIViewController

@property (nonatomic, copy) void (^doneBlock)(NSArray *imageList);
@property (nonatomic, assign)NSUInteger maxCount;
@property (nonatomic, strong) NSArray *selectedImageModelList;

@end
