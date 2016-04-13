//
//  LDImageToolBar.h
//  PhotoGrid
//
//  Created by Hong on 15/10/16.
//  Copyright © 2015年 Hong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HHImageToolBar : UIView

@property (nonatomic, strong) UILabel *countLabel;
@property (nonatomic, copy) void (^doneButtonBlock)();

@end
