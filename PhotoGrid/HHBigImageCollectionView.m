//
//  LDBigImageCollectionView.m
//  PhotoGrid
//
//  Created by Hong on 15/10/16.
//  Copyright © 2015年 Hong. All rights reserved.
//

#import "HHBigImageCollectionView.h"
#import "HHBigImageCollectionViewCell.h"

#define BigImageCell_Identifier @"BigImageCollectionCell"

@interface HHBigImageCollectionView ()<UICollectionViewDelegateFlowLayout,UICollectionViewDataSource>

@end

@implementation HHBigImageCollectionView

- (instancetype)initWithFrame:(CGRect)frame
{
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.minimumInteritemSpacing = 0;
    flowLayout.minimumLineSpacing = 0;
    flowLayout.itemSize = frame.size;
    flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    self = [super initWithFrame:frame collectionViewLayout:flowLayout];
    if (self) {
        self.delegate = self;
        self.dataSource = self;
        self.pagingEnabled = YES;
        self.backgroundColor = [UIColor blueColor];
        self.showsHorizontalScrollIndicator = NO;
        
        _photoList = [NSArray array];
        [self registerClass:[HHBigImageCollectionViewCell class] forCellWithReuseIdentifier:BigImageCell_Identifier];
    }
    return self;
}

#pragma mark - setter & getter

- (void)setPhotoList:(NSArray *)photoList
{
    _photoList = photoList;
    [self reloadData];
}

- (void)setCurrentPage:(NSUInteger)currentPage
{
    _currentPage = currentPage;
    [self scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:currentPage inSection:0] atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:YES];
}

#pragma mark - Delegate
#pragma mark UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.photoList.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    HHBigImageCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:BigImageCell_Identifier forIndexPath:indexPath];
    cell.imageModel = [self.photoList objectAtIndex:indexPath.row];
    return cell;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    NSUInteger page = (scrollView.contentOffset.x + CGRectGetWidth(scrollView.frame)/2.0) / CGRectGetWidth(scrollView.frame);
    _currentPage = page;
    if (self.scrollBlock) {
        self.scrollBlock (page);
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
