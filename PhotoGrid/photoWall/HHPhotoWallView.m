//
//  PhotoWallView.m
//  testUI2
//
//  Created by 段志蔚 on 15/10/1.
//  Copyright © 2015年 段志蔚. All rights reserved.
//

#import "HHPhotoWallView.h"
#import "HHPhotoWallCollectionViewCell.h"
@interface HHPhotoWallView()
@property (nonatomic, assign) CGPoint reorderingCellCenter;
@property (nonatomic, assign) CGPoint panTranslation;
@end
@implementation HHPhotoWallView
{
    UICollectionView *_collectionView;
    UIImageView *imageView;
    PCollectionViewFlowLayout *canMoveFlowLayout;
    UICollectionViewFlowLayout *flowLayout;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initCollectionViewWithFrame:frame];
    }
    return self;
}

-(void)initCollectionViewWithFrame:(CGRect)frame
{
    canMoveFlowLayout = [[PCollectionViewFlowLayout alloc]init];
    [canMoveFlowLayout setMinimumInteritemSpacing:1.0f];
    [canMoveFlowLayout setMinimumLineSpacing:1.0f];
    flowLayout  = [[UICollectionViewFlowLayout alloc]init];
    [flowLayout setMinimumInteritemSpacing:1.0f];
    [flowLayout setMinimumLineSpacing:1.0f];
    if (self.cellMoveEnabled) {
        _collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height) collectionViewLayout:canMoveFlowLayout];
    }else{
        _collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height) collectionViewLayout:flowLayout];
    }
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    _collectionView.scrollEnabled = self.scrollEnabled;
    _collectionView.backgroundColor = [UIColor blueColor];
    [_collectionView registerClass:[HHPhotoWallCollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
    [self addSubview:_collectionView];
}

- (void)setFrame:(CGRect)frame
{
    [super setFrame:frame];
    _collectionView.frame = self.bounds;
}

- (void)setPhotos:(NSMutableArray *)photos
{
    _photos = photos;
    [_collectionView reloadData];
}

- (void)setInterItemSpace:(CGFloat)interItemSpace
{
    _interItemSpace = interItemSpace;
    flowLayout.minimumInteritemSpacing = interItemSpace;
    canMoveFlowLayout.minimumInteritemSpacing = interItemSpace;
}

- (void)setLineSpace:(CGFloat)lineSpace
{
    _lineSpace = lineSpace;
    flowLayout.minimumLineSpacing = lineSpace;
    canMoveFlowLayout.minimumLineSpacing = lineSpace;
}

#pragma mark - Delegate
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if (!self.cellCount) {
        return self.photos.count;
    }else
    {
    return self.cellCount;
    }
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return self.cellSize;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    HHPhotoWallCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    if(self.cellCount < self.photos.count)
    {
        UIImage *img = [self.photos objectAtIndex:indexPath.row];
        [cell putImageInCell:img];
    }else
    {
        if (indexPath.row<self.photos.count) {
            UIImage *img = [self.photos objectAtIndex:indexPath.row];
            [cell putImageInCell:img];
        }else
        {
            [cell putImageInCell:nil];
            cell.backgroundColor = [UIColor orangeColor];
        }
    }
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
}

- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    [self.delegate collectionDidSelectItemAtIndexPath:indexPath];
}

#pragma mark - PCollectionViewFlowLayoutDataSource

- (void)collectionView:(UICollectionView *)collectionView itemAtIndexPath:(NSIndexPath *)fromIndexPath didMoveToIndexPath:(NSIndexPath *)toIndexPath
{
    [self.delegate cellDidMoveFromIndexPath:fromIndexPath moveToIndexPath:toIndexPath];
}

#pragma mark - private Method





/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
