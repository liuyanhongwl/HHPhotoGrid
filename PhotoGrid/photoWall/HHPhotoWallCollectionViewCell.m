//
//  PhotoWallCollectionViewCell.m
//  PhotoWall
//
//  Created by 段志蔚 on 15/10/1.
//  Copyright © 2015年 段志蔚. All rights reserved.
//

#import "HHPhotoWallCollectionViewCell.h"

@interface HHPhotoWallCollectionViewCell ()

@property (nonatomic, strong)UIImageView *imageView;
@end
@implementation HHPhotoWallCollectionViewCell

-(id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _imageView = [[UIImageView alloc] init];
        [self.contentView addSubview:_imageView];
    }
    return self;
}

-(void)putImageInCell:(UIImage *)image
{
    self.imageView.frame = self.contentView.bounds;
    self.imageView.image = image;
}
@end
