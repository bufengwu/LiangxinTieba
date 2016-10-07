//
//  LTSideSlipViewController.m
//  LiangxinTieba
//
//  Created by mac on 16/9/27.
//  Copyright © 2016年 XYD. All rights reserved.
//

#import "LTLeftDrawerViewController.h"

@interface LTLeftDrawerViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView * tableView;
@property (nonatomic, strong) NSArray * labelArr;
@end

@implementation LTLeftDrawerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor orangeColor];
    self.view.frame = CGRectMake(0, 0, SCREEN_WIDTH/3*2, SCREEN_HEIGHT);
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH/3*2, SCREEN_HEIGHT)];
    self.tableView.bounces = NO;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    self.labelArr = @[@"选择排序方式",@"按赏金排序",@"按时间排序",@"按热度排序"];
}

#pragma mark tableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        return 200;
    }
    return 80;
}

#pragma mark tableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.labelArr count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"sortBox"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"sortBox"];
        cell.textLabel.text = self.labelArr[indexPath.row];
        if (indexPath.row == 0) {
            cell.backgroundColor = RGB(80, 98, 107);
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
    }
    return cell;
}
@end
