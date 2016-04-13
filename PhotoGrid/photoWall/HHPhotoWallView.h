//
//  PhotoWallView.h
//  testUI2
//
//  Created by 段志蔚 on 15/10/1.
//  Copyright © 2015年 段志蔚. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PCollectionViewFlowLayout.h"
@protocol HHPhotoWallViewDelegate <NSObject>
@optional
-(void)collectionDidSelectItemAtIndexPath:(NSIndexPath *)indexPath;
-(void)cellDidMoveFromIndexPath:(NSIndexPath *)fromIndexPath moveToIndexPath:(NSIndexPath *)toIndexPatch;
@end
@interface HHPhotoWallView : UIView<PCollectionViewFlowLayoutDataSource,PCollectionViewFlowLayout,UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>

@property(nonatomic,strong) NSMutableArray *photos;
@property(nonatomic,assign) id <HHPhotoWallViewDelegate> delegate;
@property(nonatomic,assign)BOOL cellMoveEnabled;
@property(nonatomic,assign)BOOL scrollEnabled;
@property(nonatomic,assign)NSInteger cellCount;
@property(nonatomic,assign)CGSize cellSize;
@property(nonatomic,assign)CGFloat interItemSpace;
@property(nonatomic,assign)CGFloat lineSpace;
@end
