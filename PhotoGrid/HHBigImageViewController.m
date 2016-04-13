
//
//  LDBigImageViewController.m
//  PhotoGrid
//
//  Created by Hong on 15/10/16.
//  Copyright © 2015年 Hong. All rights reserved.
//

//View
#import "HHBigImageViewController.h"
#import "HHBigImageCollectionView.h"
//Manager
#import "HHPhotoManager.h"
//Model
#import "HHImageModel.h"

@interface HHBigImageViewController ()

@property (nonatomic, strong) UIButton *selectedBarButton;
@property (nonatomic, strong) HHBigImageCollectionView *collectionView;
@end

@implementation HHBigImageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    _selectedBarButton = [UIButton buttonWithType:UIButtonTypeCustom];
    CGFloat height = CGRectGetHeight(self.navigationController.navigationBar.frame);
    _selectedBarButton.frame = CGRectMake(0, 0, height, height);
    _selectedBarButton.backgroundColor = [UIColor grayColor];
    [_selectedBarButton addTarget:self action:@selector(selectedBarButtonAction) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *barButtonItem = [[UIBarButtonItem alloc] initWithCustomView:_selectedBarButton];
    [self.navigationItem setRightBarButtonItem:barButtonItem];
    
    _collectionView = [[LDBigImageCollectionView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:_collectionView];
    if (_photoList) {
        _collectionView.photoList = _photoList;
    }
    __weak HHBigImageViewController *weakSelf = self;
    [_collectionView setScrollBlock:^(NSUInteger page) {
        HHImageModel *model = nil;
        if (page < weakSelf.collectionView.photoList.count) {
            model = [weakSelf.collectionView.photoList objectAtIndex:page];
            [weakSelf updateSelectedBarButtonWithImageModel:model];
        }
    }];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self.collectionView setCurrentPage:self.photoIndex];
}

#pragma mark - Action

- (void)selectedBarButtonAction
{
    if (self.collectionView.currentPage < self.collectionView.photoList.count) {
        HHImageModel *model = [self.collectionView.photoList objectAtIndex:self.collectionView.currentPage];
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"self.isSelected == 1"];
        NSArray *selectedModel = [self.collectionView.photoList filteredArrayUsingPredicate:predicate];
        if (selectedModel.count < self.maxCount || !model.isSelected) {
            model.isSelected = !model.isSelected;
            [self updateSelectedBarButtonWithImageModel:model];
        }else{
            NSLog(@"最多只能选择%ld图片", self.maxCount);
        }
    }
}

#pragma mark - Private Method

- (void)updateSelectedBarButtonWithImageModel:(HHImageModel *)model
{
    self.selectedBarButton.backgroundColor = model.isSelected ? [UIColor redColor] : [UIColor grayColor];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
