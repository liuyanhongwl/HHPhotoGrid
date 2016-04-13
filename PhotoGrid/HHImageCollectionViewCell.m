//
//  LDImageCollectionViewCell.m
//  PhotoGrid
//
//  Created by Hong on 15/10/15.
//  Copyright © 2015年 Hong. All rights reserved.
//

#import "HHImageCollectionViewCell.h"
#import "HHPhotoManager.h"
#import "HHImageModel.h"

#define SelectedButton_Size 22

@interface HHImageCollectionViewCell ()

@property (nonatomic, strong)UIImageView *imageView;
@property (nonatomic, strong)UIButton *selectedButton;
@end

@implementation HHImageCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _imageView = [[UIImageView alloc] init];
        [self.contentView addSubview:_imageView];
        
        _selectedButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_selectedButton addTarget:self action:@selector(selectedButtonAction) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:_selectedButton];
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
    
    _imageView.frame = self.contentView.frame;
    __weak UIImageView *weakImageView = self.imageView;
    [HHPhotoManager getThumbnialFromUrl:_imageModel.imageUrl successBlock:^(UIImage *image) {
        weakImageView.image = image;
    } failureBlock:^(NSError *error) {
        NSLog(@"asset方式-获取缩略图失败-%@",error);
    }];
    
    _selectedButton.frame = CGRectMake(CGRectGetMaxX(_imageView.frame) - SelectedButton_Size, 0, SelectedButton_Size, SelectedButton_Size);
    _selectedButton.backgroundColor = _imageModel.isSelected ? [UIColor orangeColor] : [UIColor grayColor];
}

#pragma mark - Action
- (void)selectedButtonAction
{
    if (self.selectButtonBlock) {
        self.selectButtonBlock(!_imageModel.isSelected, _imageModel, self);
    }
}

@end
