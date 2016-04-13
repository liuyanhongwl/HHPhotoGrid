//
//  LDImageCollectionView.h
//  PhotoGrid
//
//  Created by Hong on 15/10/15.
//  Copyright © 2015年 Hong. All rights reserved.
//

#import <UIKit/UIKit.h>

@class HHImageCollectionViewCell;
@class HHImageModel;
@interface HHImageCollectionView : UICollectionView

@property (nonatomic, strong) NSArray *photoList;

@property (nonatomic, copy) void (^tapItemBlock)(NSIndexPath *indexP);//点击图片
@property (nonatomic, copy) void (^selectButtonBlock)(BOOL isSelected, HHImageModel *imageModel, HHImageCollectionViewCell *cell);    //选择图片

@end
