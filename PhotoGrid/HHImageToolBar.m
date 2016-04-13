//
//  LDImageToolBar.m
//  PhotoGrid
//
//  Created by Hong on 15/10/16.
//  Copyright © 2015年 Hong. All rights reserved.
//

#import "HHImageToolBar.h"

@interface HHImageToolBar ()

@end

@implementation HHImageToolBar

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {

        self.backgroundColor = [UIColor cyanColor];
        
        CGFloat subViewMargin = 10;
        CGFloat width = 80;
        CGFloat height = 40;
        
        UIButton *doneButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [doneButton setTitle:@"Done" forState:UIControlStateNormal];
        doneButton.frame = CGRectMake(CGRectGetWidth(self.frame) - subViewMargin - width, (CGRectGetHeight(self.frame) - height) / 2.0, width, height);
        [doneButton addTarget:self action:@selector(doneButtonAction) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:doneButton];
        
        width = CGRectGetWidth(self.frame) - 2*subViewMargin - CGRectGetWidth(doneButton.frame);
        _countLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMinX(doneButton.frame) - subViewMargin - width, (CGRectGetHeight(self.frame) - height) / 2.0, width, height)];
        _countLabel.textAlignment = NSTextAlignmentRight;
        [self addSubview:_countLabel];
        
    }
    return self;
}

- (void)doneButtonAction
{
    if (self.doneButtonBlock) {
        self.doneButtonBlock();
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
