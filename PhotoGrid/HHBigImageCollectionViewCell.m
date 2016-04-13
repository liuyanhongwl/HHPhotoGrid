//
//  LDBigImageCollectionViewCell.m
//  PhotoGrid
//
//  Created by Hong on 15/10/16.
//  Copyright © 2015年 Hong. All rights reserved.
//

#import "HHBigImageCollectionViewCell.h"
#import "HHPhotoManager.h"
#import "HHImageModel.h"

@interface HHBigImageCollectionViewCell ()<UIScrollViewDelegate>

@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UIImageView *imageView;

@end

@implementation HHBigImageCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _scrollView = [[UIScrollView alloc] init];
        _scrollView.backgroundColor = [UIColor cyanColor];
        _scrollView.delegate = self;
        _scrollView.maximumZoomScale = 2.0f;
        [self.contentView addSubview:_scrollView];
        
        _imageView = [[UIImageView alloc] init];
        _imageView.contentMode = UIViewContentModeScaleAspectFit;
        [self.scrollView addSubview:_imageView];

        self.contentView.backgroundColor = [UIColor orangeColor];
    }
    return self;
}

- (void)setImageModel:(HHImageModel *)imageModel
{
    _imageModel = imageModel;
    [self setNeedsLayout];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.scrollView.frame = self.contentView.bounds;
    self.scrollView.zoomScale = 1.0f;
    self.imageView.frame = self.scrollView.bounds;
    
    __weak HHBigImageCollectionViewCell *weakSelf = self;
    [HHPhotoManager getFullScreenImageFromUrl:_imageModel.imageUrl successBlock:^(UIImage *image) {
        weakSelf.imageView.image = image;

        // height fill to contentView
//        CGFloat width = CGRectGetWidth(weakSelf.contentView.frame);
//        CGFloat height = width / image.size.width * image.size.height;
//        CGFloat originY = 0;
//        if (height < CGRectGetHeight(weakSelf.scrollView.frame)) {
//            originY = (CGRectGetHeight(weakSelf.scrollView.frame) - height) / 2.0;
//        }
//        weakSelf.imageView.frame = CGRectMake(0, originY, width, height);
//        weakSelf.scrollView.contentSize = CGSizeMake(width, height);
        
        // height fit to contentView
        CGFloat originX = 0.0f;
        CGFloat originY = 0.0f;
        CGFloat width = 0.0f;
        CGFloat height = 0.0f;
        if (image.size.height > image.size.width) {
            height = CGRectGetHeight(weakSelf.contentView.frame);
            width = height / image.size.height * image.size.width;
            originX = (CGRectGetWidth(weakSelf.scrollView.frame) - width) / 2.0;
            originY = 0.0f;
        }else{
            width = CGRectGetWidth(weakSelf.contentView.frame);
            height = width / image.size.width * image.size.height;
            originX = 0.0f;
            originY = (CGRectGetHeight(weakSelf.scrollView.frame) - height) / 2.0;
        }
        weakSelf.imageView.frame = CGRectMake(originX, originY, width, height);
        weakSelf.scrollView.contentSize = CGSizeMake(width, height);
        
    } failureBlock:^(NSError *error) {
        NSLog(@"asset方式-获取全屏图失败-%@",error);
    }];
}

#pragma mark - Deleate
#pragma mark UIScrollViewDelegate

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    return self.imageView;
}

- (void)scrollViewDidEndZooming:(UIScrollView *)scrollView withView:(UIView *)view atScale:(CGFloat)scale
{
    CGFloat originX = 0.0f;
    CGFloat originY = 0.0f;
    if (CGRectGetHeight(self.imageView.frame) <= CGRectGetHeight(scrollView.frame)) {
        originY = (CGRectGetHeight(scrollView.frame) - CGRectGetHeight(self.imageView.frame))/2.0;
    }
    if (CGRectGetWidth(self.imageView.frame) <= CGRectGetWidth(scrollView.frame)) {
        originX = (CGRectGetWidth(scrollView.frame) - CGRectGetWidth(self.imageView.frame))/2.0;
    }
    
    [UIView animateWithDuration:0.25 animations:^{
        self.imageView.frame = CGRectMake(originX, originY, CGRectGetWidth(self.imageView.frame), CGRectGetHeight(self.imageView.frame)); 
    }];
}


@end
