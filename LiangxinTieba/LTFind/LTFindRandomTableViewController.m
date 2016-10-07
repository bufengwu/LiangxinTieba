//
//  LTFindRandomTableViewController.m
//  LiangxinTieba
//
//  Created by mac on 2016/9/29.
//  Copyright © 2016年 XYD. All rights reserved.
//

#import "LTFindRandomTableViewController.h"

@interface LTFindRandomTableViewController ()

@property (nonatomic, strong) NSMutableArray * dataSource;

@end

@implementation LTFindRandomTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.backgroundColor = RGBA(255, 255, 255, 0.7);
    if (self.dataSource == nil || self.dataSource.count == 0) {
        UILabel * emptyMsgView = [[UILabel alloc]init];
        emptyMsgView.text = NSLocalizedString(@"no more data", nil);
        emptyMsgView.textColor = [UIColor grayColor];
        [emptyMsgView sizeToFit];
        emptyMsgView.center = self.tableView.center;
        [self.view addSubview:emptyMsgView];
        self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    };
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.dataSource count];
}

@end
