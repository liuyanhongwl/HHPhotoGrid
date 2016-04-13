//
//  LDBigImageCollectionView.h
//  PhotoGrid
//
//  Created by Hong on 15/10/16.
//  Copyright © 2015年 Hong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HHBigImageCollectionView : UICollectionView

@property (nonatomic, strong) NSArray *photoList;
@property (nonatomic, copy) void (^scrollBlock)(NSUInteger page);
@property (nonatomic, assign) NSUInteger currentPage;

@end
