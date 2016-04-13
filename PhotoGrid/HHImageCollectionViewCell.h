//
//  LDImageCollectionViewCell.h
//  PhotoGrid
//
//  Created by Hong on 15/10/15.
//  Copyright © 2015年 Hong. All rights reserved.
//

#import <UIKit/UIKit.h>
@class HHImageModel;

@interface HHImageCollectionViewCell : UICollectionViewCell

@property (nonatomic, strong) HHImageModel *imageModel;
@property (nonatomic, copy) void (^selectButtonBlock)(BOOL isSelected, HHImageModel *imageModel, HHImageCollectionViewCell *cell);

@end
