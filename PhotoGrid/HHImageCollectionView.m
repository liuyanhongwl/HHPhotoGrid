//
//  LDImageCollectionView.m
//  PhotoGrid
//
//  Created by Hong on 15/10/15.
//  Copyright © 2015年 Hong. All rights reserved.
//

#import "HHImageCollectionView.h"
#import "HHImageCollectionViewCell.h"

#define ImageCell_Identifier   @"ImageCollectionViewCell"
@interface HHImageCollectionView ()<UICollectionViewDelegateFlowLayout,UICollectionViewDataSource>

@end

@implementation HHImageCollectionView

- (instancetype)initWithFrame:(CGRect)frame
{
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.minimumInteritemSpacing = 2;
    flowLayout.minimumLineSpacing = 4;
    CGFloat itemWidth = CGRectGetWidth(frame)/4.0 - flowLayout.minimumInteritemSpacing;
    flowLayout.itemSize = CGSizeMake(itemWidth, itemWidth);
    self = [super initWithFrame:frame collectionViewLayout:flowLayout];
    if (self) {
        self.delegate = self;
        self.dataSource = self;
        
        _photoList = [NSArray array];
        [self registerClass:[HHImageCollectionViewCell class] forCellWithReuseIdentifier:ImageCell_Identifier];
        
    }
    return self;
}

#pragma mark - setter & getter

- (void)setPhotoList:(NSArray *)photoList
{
    _photoList = photoList;
    [self reloadData];
}

#pragma mark - Delegate
#pragma mark UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.photoList.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    HHImageCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:ImageCell_Identifier forIndexPath:indexPath];
    cell.selectButtonBlock = self.selectButtonBlock;
    cell.imageModel = [self.photoList objectAtIndex:indexPath.row];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"点击小图");
    if (self.tapItemBlock) {
        self.tapItemBlock(indexPath);
    }
}



/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
