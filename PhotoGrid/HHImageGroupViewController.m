//
//  LDImageGroupViewController.m
//  PhotoGrid
//
//  Created by Hong on 15/10/15.
//  Copyright © 2015年 Hong. All rights reserved.
//

//View
#import "HHImageGroupViewController.h"
#import "HHImageGroupViewCell.h"
#import "HHImageViewController.h"
//Manager
#import "HHPhotoManager.h"
//Model
#import "HHPhotoGroupModel.h"

@interface HHImageGroupViewController ()<UITableViewDelegate, UITableViewDataSource>

//DATA
@property (nonatomic, strong) NSArray *photoGroupList;
//UI
@property (nonatomic, strong) UITableView *tableView;

@end

@implementation HHImageGroupViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _photoGroupList = [NSArray array];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(dismiss)];
    
    _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    
    
    __weak HHImageGroupViewController *weakSelf = self;
    [HHPhotoManager getGroupListSuccessBlock:^(NSArray *groupList) {
        weakSelf.photoGroupList = groupList;
        [weakSelf.tableView reloadData];
    } failureBlock:^(NSError *failureBlock) {
        NSLog(@"获取相册失败");
    }];

}

#pragma mark - Action

- (void)dismiss
{
    if (self.navigationController) {
        [self.navigationController dismissViewControllerAnimated:YES completion:nil];
    }
}

#pragma mark - Delegate
#pragma mark UITableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.photoGroupList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifiter = @"GroupCell";
    HHImageGroupViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifiter];
    if (!cell) {
        cell = [[HHImageGroupViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:identifiter];
    }
    cell.photoGroup = [self.photoGroupList objectAtIndex:indexPath.row];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [HHPhotoGroupModel heightForPhotoGroupCell];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    HHImageViewController *imageVC = [[HHImageViewController alloc] init];
    imageVC.doneBlock = self.doneBlock;
    imageVC.maxCount = self.maxCount;
    imageVC.selectedImageModelList = self.selectedImageModelList;
    imageVC.groupUrl = [(LDPhotoGroupModel *)[self.photoGroupList objectAtIndex:indexPath.row] groupUrl];
    if (self.navigationController) {
        [self.navigationController pushViewController:imageVC animated:YES];
    }
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
