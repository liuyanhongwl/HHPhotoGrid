//
//  LDImageGroupViewCell.m
//  PhotoGrid
//
//  Created by Hong on 15/10/15.
//  Copyright © 2015年 Hong. All rights reserved.
//

#import "HHImageGroupViewCell.h"
#import "HHPhotoGroupModel.h"

@implementation HHImageGroupViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
    }
    return self;
}

- (void)setPhotoGroup:(HHPhotoGroupModel *)photoGroup
{
    _photoGroup = photoGroup;
    [self setNeedsLayout];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.imageView.image = self.photoGroup.image;
//    self.imageView.contentMode = UIViewContentModeScaleAspectFill;
//    self.imageView.clipsToBounds = YES;
//    CGFloat imageSize = [LDPhotoGroupModel sizeForPhotoGroupImage];
//    CGFloat imageY = (CGRectGetHeight(self.contentView.frame) - imageSize) / 2.0;
//    self.imageView.frame = CGRectMake(30, imageY, imageSize, imageSize);

    self.textLabel.text = self.photoGroup.groupName;
    self.detailTextLabel.text = [NSString stringWithFormat:@"%ld", self.photoGroup.numberOfPhotos];
    self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
}



- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
