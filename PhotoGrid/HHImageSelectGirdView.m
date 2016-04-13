//
//  LDImageSelectGirdView.m
//  PhotoGrid
//
//  Created by Hong on 15/10/19.
//  Copyright © 2015年 Hong. All rights reserved.
//

//View
#import "HHImageSelectGirdView.h"
#import "HHImageGroupViewController.h"
#import "HHPhotoWallView.h"
//Model
#import "HHImageModel.h"
//Manager
#import "HHPhotoManager.h"

#define LD_MAXIMAGE_COUNT   6

@interface HHImageSelectGirdView ()<HHPhotoWallViewDelegate>
//UI
@property (nonatomic, strong) HHPhotoWallView *wallView;
//DATA
@property (nonatomic, assign) NSUInteger colCount;
@property (nonatomic, assign) HHImageSelectGirdViewType type;
@end

@implementation HHImageSelectGirdView

- (instancetype)initWithFrame:(CGRect)frame colCount:(NSUInteger)colCount cellSpace:(CGFloat)cellSpace type:(HHImageSelectGirdViewType)type
{
    self = [super initWithFrame:frame];
    if (self) {
        _type = type;
        _colCount = colCount;

        CGFloat viewWidth = CGRectGetWidth(frame);
        CGFloat imageWidth = (viewWidth - (colCount - 1) * cellSpace) / colCount;
        _wallView = [[HHPhotoWallView alloc] initWithFrame:CGRectMake(0, 0, viewWidth, imageWidth)];
        _wallView.delegate = self;
        _wallView.cellCount = type == LDImageSelectGirdViewTypeImageOnly ? 1 : 2;
        _wallView.cellSize = CGSizeMake(imageWidth, imageWidth);
        _wallView.interItemSpace = cellSpace;
        _wallView.lineSpace = cellSpace;
        [self addSubview:_wallView];
    }
    return self;
}

#pragma mark - setter & getter

- (void)setType:(HHImageSelectGirdViewType)type
{
    _type = type;
}

#pragma mark - Action

- (void)pictureButtonAction
{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"选择照片" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *photoAction = [UIAlertAction actionWithTitle:@"照片" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        HHImageGroupViewController *groupVC = [[HHImageGroupViewController alloc] init];
        groupVC.maxCount = LD_MAXIMAGE_COUNT;
        groupVC.selectedImageModelList = self.imageModelList;
        
        __weak HHImageSelectGirdView *weakSelf = self;
        NSMutableArray *thumbnialImages = [NSMutableArray array];
        [groupVC setDoneBlock:^(NSArray *selectedImageList) {
            for (HHImageModel *imageModel in selectedImageList) {
                [HHPhotoManager getThumbnialFromUrl:imageModel.imageUrl successBlock:^(UIImage *thumb) {
                    [thumbnialImages addObject:thumb];
                    if (thumbnialImages.count == selectedImageList.count) {
                        if (thumbnialImages.count < LD_MAXIMAGE_COUNT) {
                            weakSelf.wallView.cellCount = thumbnialImages.count + self.type;
                        }else{
                            weakSelf.wallView.cellCount = thumbnialImages.count + self.type - 1;
                        }
                        
                        NSUInteger rowCount = weakSelf.wallView.cellCount / self.colCount + 1;
                        weakSelf.wallView.frame = CGRectMake(CGRectGetMinX(weakSelf.wallView.frame), CGRectGetMinY(weakSelf.wallView.frame), CGRectGetWidth(weakSelf.wallView.frame), weakSelf.wallView.cellSize.width * rowCount + weakSelf.wallView.lineSpace * (rowCount - 1));
                        _imageModelList = selectedImageList;
                        weakSelf.wallView.photos = thumbnialImages;
                    }
                } failureBlock:^(NSError *error) {
                    NSLog(@"Done-获取缩略图失败-%@",error);
                }];
            }
        }];
        UINavigationController *navi = [[UINavigationController alloc] initWithRootViewController:groupVC];
        [navi.navigationBar setBackgroundImage:[[UIImage alloc] init] forBarMetrics:UIBarMetricsDefault];
        [[self viewController] presentViewController:navi animated:YES completion:^{
            
        }];
        
    }];
    UIAlertAction *cameraAction = [UIAlertAction actionWithTitle:@"相机" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
    }];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        [alertController dismissViewControllerAnimated:YES completion:^{
            
        }];
    }];
    [alertController addAction:photoAction];
    [alertController addAction:cameraAction];
    [alertController addAction:cancelAction];
    [[self viewController] presentViewController:alertController animated:YES completion:^{
        
    }];
}

#pragma mark - Private Method

- (UIViewController *)viewController
{
    UIResponder *next = self.nextResponder;
    while (next) {
        if ([next isKindOfClass:[UIViewController class]]) {
            return (UIViewController *)next;
        }
        next = next.nextResponder;
    }
    return nil;
}

#pragma mark - Delegate
#pragma mark LDPhotoWallViewDelegate

-(void)collectionDidSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSUInteger otherIndex = indexPath.row - self.imageModelList.count;
    if (otherIndex == 0) {
        if (self.imageModelList.count == LD_MAXIMAGE_COUNT) {
            NSLog(@"视频");
        }else{
            [self pictureButtonAction];
        }
    }else if (otherIndex == 1){
        NSLog(@"视频");
    }
//    if (_type == LDImageSelectGirdViewTypeImageOnly) {
//        [self pictureButtonAction];
//    }else{
//        if (otherIndex == 2 && self) {
//            [self pictureButtonAction];
//        }else if(otherIndex == 1){
//            NSLog(@"视频");
//        }
//    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
