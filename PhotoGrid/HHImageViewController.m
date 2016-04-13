//
//  LDImageViewController.m
//  PhotoGrid
//
//  Created by Hong on 15/10/15.
//  Copyright © 2015年 Hong. All rights reserved.
//

//View
#import "HHImageViewController.h"
#import "HHImageCollectionView.h"
#import "HHBigImageViewController.h"
#import "HHImageToolBar.h"
#import "HHImageCollectionViewCell.h"
//Manager
#import "HHPhotoManager.h"
//Model
#import "HHImageModel.h"

#define ToolBar_Height      50

@interface HHImageViewController ()

//UI
@property (nonatomic, strong) HHImageCollectionView *collectionView;
@property (nonatomic, strong) HHImageToolBar *toolBar;
//DATA
@property (nonatomic, assign) NSUInteger currentCount;
@end

@implementation HHImageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    __weak HHImageViewController *weakSelf = self;
    _collectionView = [[HHImageCollectionView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame) - ToolBar_Height)];
    [_collectionView setTapItemBlock:^(NSIndexPath *indexP) {
        HHBigImageViewController *bigImageVC = [[HHBigImageViewController alloc] init];
        bigImageVC.photoList = weakSelf.collectionView.photoList;
        bigImageVC.photoIndex = indexP.row;
        bigImageVC.maxCount = weakSelf.maxCount;
        [weakSelf.navigationController pushViewController:bigImageVC animated:YES];
    }];
    [_collectionView setSelectButtonBlock:^(BOOL isSelected, HHImageModel *imageModel ,HHImageCollectionViewCell *cell) {
        if (weakSelf.currentCount == weakSelf.maxCount && isSelected) {
            NSLog(@"最多只能选择%ld图片", weakSelf.maxCount);
            return ;
        }
        imageModel.isSelected = !imageModel.isSelected;
        [cell setNeedsLayout];
        
        if (isSelected) {
            weakSelf.currentCount ++;
        }else{
            weakSelf.currentCount --;
        }
    }];
    [self.view addSubview:_collectionView];
    
    [HHPhotoManager getPhotoListFromGroup:self.groupUrl selectedImageList:self.selectedImageModelList successBlock:^(NSArray *photoList) {
        weakSelf.collectionView.photoList = photoList;
    } failureBlock:^(NSError *error) {
        NSLog(@"获取相册内缩略图数组失败");
    }];
    
//    [LDPhotoManager getPhotoListFromGroup:self.groupUrl successBlock:^(NSArray *photoList) {
//        weakSelf.collectionView.photoList = photoList;
//    } failureBlock:^(NSError *error) {
//        NSLog(@"获取相册内缩略图数组失败");
//    }];
    
    [self initToolBar];
}

- (void)initToolBar
{
    _toolBar = [[HHImageToolBar alloc] initWithFrame:CGRectMake(0, CGRectGetHeight(self.view.frame) - ToolBar_Height, CGRectGetWidth(self.view.frame), ToolBar_Height)];
    __weak HHImageViewController *weakSelf = self;
    [_toolBar setDoneButtonBlock:^{
        NSLog(@"Done Action");
        
        if (weakSelf.doneBlock) {
            NSPredicate *predicate = [NSPredicate predicateWithFormat:@"self.isSelected = 1"];
            NSArray *selectedImageList = [weakSelf.collectionView.photoList filteredArrayUsingPredicate:predicate];
            weakSelf.doneBlock(selectedImageList);
        }
        [weakSelf.navigationController dismissViewControllerAnimated:YES completion:nil];
    }];
    
    [self.view addSubview:_toolBar];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
//    [self.collectionView reloadData];
    
    NSArray *cellArray = [self.collectionView visibleCells];
    for (UITableViewCell *cell in cellArray) {
        [cell setNeedsLayout];
    }
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"self.isSelected = 1"];
    NSArray *selectedImageList = [self.collectionView.photoList filteredArrayUsingPredicate:predicate];
    self.currentCount = selectedImageList.count;
}

#pragma mark - setter & getter

- (void)setCurrentCount:(NSUInteger)currentCount
{
    _currentCount = currentCount;
    _toolBar.countLabel.text = [NSString stringWithFormat:@"%ld/%ld",(unsigned long)self.currentCount, (unsigned long)self.maxCount];
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
