//
//  LDImageSelectGirdView.h
//  PhotoGrid
//
//  Created by Hong on 15/10/19.
//  Copyright © 2015年 Hong. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, HHImageSelectGirdViewType) {
    LDImageSelectGirdViewTypeImageOnly = 1,
    LDImageSelectGirdViewTypeImageAndVideo
};

@interface HHImageSelectGirdView : UIView

- (instancetype)initWithFrame:(CGRect)frame colCount:(NSUInteger)colCount cellSpace:(CGFloat)cellSpace type:(HHImageSelectGirdViewType)type;

@property (nonatomic, assign) NSUInteger maxCount;
@property (nonatomic, strong, readonly) NSArray *imageModelList;

@end
