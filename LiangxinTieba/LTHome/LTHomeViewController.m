//
//  LTHomeViewController.m
//  LiangxinTieba
//
//  Created by mac on 2016/9/27.
//  Copyright © 2016年 XYD. All rights reserved.
//

#import "LTHomeViewController.h"
#import "CollectionViewCell.h"
#import "LTTabBarController.h"
#import "DrawerController.h"

#import "LTBarDetailViewController.h"

@interface LTHomeViewController ()<UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) UICollectionView * collectView;

@end

@implementation LTHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = NSLocalizedString(@"My Bars", nil);
    
    self.view.layer.contents = (id)([UIImage imageNamed:@"table_background"].CGImage);
    
    UICollectionViewFlowLayout * layout = [[UICollectionViewFlowLayout alloc]init];
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    
    self.collectView = [[UICollectionView alloc]initWithFrame:self.view.frame collectionViewLayout:layout];
    self.collectView.backgroundColor = [UIColor clearColor];
    
    self.collectView.delegate = self;
    self.collectView.dataSource = self;
    
    [self.collectView registerNib: [UINib nibWithNibName:@"CollectionViewCell" bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:@"barName"];
    
    [self.view addSubview:self.collectView];
}


- (void) viewDidAppear:(BOOL)animated {     //只在此页面使用侧滑菜单
        [((LTTabBarController *)self.tabBarController).drawer setPanGestureEnabled:YES];
        [((LTTabBarController *)self.tabBarController).drawer setTapGestureEnabled:YES];
}
- (void) viewDidDisappear:(BOOL)animated {      //离开此页面后移除打开侧滑菜单的手势
        [((LTTabBarController *)self.tabBarController).drawer setPanGestureEnabled:NO];
        [((LTTabBarController *)self.tabBarController).drawer setTapGestureEnabled:NO];
}


#pragma mark UICollectionViewDataSource
- (UICollectionViewCell *) collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    CollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"barName" forIndexPath:indexPath];
    cell.barName.text = [NSString stringWithFormat:@"%ld",(long)indexPath.row];
    [cell.imgView setImage:[UIImage imageNamed:@"collection_star_level"]];

    return cell;
}
//返回section个数
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

//每个section的item个数
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 15;
}
#pragma mark UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {

    
    self.hidesBottomBarWhenPushed=YES;
    
    UIViewController * barVC = [[LTBarDetailViewController alloc] init];
    barVC.navigationItem.title = ((CollectionViewCell*)[collectionView cellForItemAtIndexPath:indexPath]).barName.text;
    
    [self.navigationController pushViewController:barVC animated:YES];
    self.hidesBottomBarWhenPushed=NO;
}

#pragma mark UICollectionViewDelegateFlowLayout
//设置每个item的尺寸
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake((SCREEN_WIDTH-60)/2, 60);
}

//设置每个item的UIEdgeInsets
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(10, 15, 15, 15);
}

//设置每个item水平间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 10;
}

//设置每个item垂直间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 30;
}

@end
