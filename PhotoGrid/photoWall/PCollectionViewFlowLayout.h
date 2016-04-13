//
//  PCollectionViewFlowLayout.h
//  PhotoWall
//
//  Created by Alex on 15/10/1.
//  Copyright © 2015年 Alex. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, RAScrollDirction) {
    RAScrollDirctionNone,
    RAScrollDirctionUp,
    RAScrollDirctionDown
};

@protocol PCollectionViewFlowLayoutDataSource <UICollectionViewDataSource>
@optional
- (void)collectionView:(UICollectionView *)collectionView itemAtIndexPath:(NSIndexPath *)fromIndexPath willMoveToIndexPath:(NSIndexPath *)toIndexPath;
- (void)collectionView:(UICollectionView *)collectionView itemAtIndexPath:(NSIndexPath *)fromIndexPath didMoveToIndexPath:(NSIndexPath *)toIndexPath;
- (BOOL)collectionView:(UICollectionView *)collectionView canMoveItemAtIndexPath:(NSIndexPath *)indexPath;
- (BOOL)collectionView:(UICollectionView *)collectionView itemAtIndexPath:(NSIndexPath *)fromIndexPath canMoveToIndexPath:(NSIndexPath *)toIndexPath;
@end

@protocol PCollectionViewFlowLayout <UICollectionViewDelegateFlowLayout>
@optional
- (CGFloat)reorderingItemAlpha:(UICollectionView * )collectionview; 
- (UIEdgeInsets)autoScrollTrigerEdgeInsets:(UICollectionView *)collectionView;
- (UIEdgeInsets)autoScrollTrigerPadding:(UICollectionView *)collectionView;

- (void)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout willBeginDraggingItemAtIndexPath:(NSIndexPath *)indexPath;
- (void)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout didBeginDraggingItemAtIndexPath:(NSIndexPath *)indexPath;
- (void)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout willEndDraggingItemAtIndexPath:(NSIndexPath *)indexPath;
- (void)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout didEndDraggingItemAtIndexPath:(NSIndexPath *)indexPath;
@end

@interface PCollectionViewFlowLayout : UICollectionViewFlowLayout <UIGestureRecognizerDelegate>
@property (nonatomic, strong) UIView *cellFakeView;
@property (nonatomic, strong) CADisplayLink *displayLink;
@property (nonatomic, assign) RAScrollDirction scrollDirection;
@property (nonatomic, strong) NSIndexPath *reorderingCellIndexPath;
@property (nonatomic, assign) CGPoint reorderingCellCenter;
@property (nonatomic, assign) CGPoint cellFakeViewCenter;
@property (nonatomic, assign) CGPoint panTranslation;
@property (nonatomic, assign) UIEdgeInsets scrollTrigerEdgeInsets;
@property (nonatomic, assign) UIEdgeInsets scrollTrigePadding;
@property (nonatomic, assign) BOOL setUped;
@property (nonatomic, assign) BOOL needsUpdateLayout;
@property (nonatomic, strong, readonly) UILongPressGestureRecognizer *longPressGesture;
@property (nonatomic, strong, readonly) UIPanGestureRecognizer *panGesture;
@property (nonatomic, assign) id<PCollectionViewFlowLayout> delegate;
@property (nonatomic, assign) id<PCollectionViewFlowLayoutDataSource> datasource;

@end
