//
//  ViewController.m
//  PhotoGrid
//
//  Created by Hong on 15/10/15.
//  Copyright © 2015年 Hong. All rights reserved.
//

#import "ViewController.h"
#import "HHImageSelectGirdView.h"

@interface ViewController ()


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    CGRect screenBounds = [UIScreen mainScreen].bounds;
    HHImageSelectGirdView *girdView = [[HHImageSelectGirdView alloc] initWithFrame:CGRectMake(15, 100, CGRectGetWidth(screenBounds) - 30, 200) colCount:4 cellSpace:10 type:LDImageSelectGirdViewTypeImageAndVideo];
    girdView.backgroundColor = [UIColor redColor];
    [self.view addSubview:girdView];
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
