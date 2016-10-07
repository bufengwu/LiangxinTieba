//
//  LTFindViewController.m
//  LiangxinTieba
//
//  Created by mac on 2016/9/27.
//  Copyright © 2016年 XYD. All rights reserved.
//

#import "LTFindViewController.h"

#import "LTFindHotTableViewController.h"
#import "LTFindRandomTableViewController.h"

@interface LTFindViewController ()

@property (nonatomic, strong) UIViewController * findHotVC;
@property (nonatomic, strong) UIViewController * findRandVC;
@property (nonatomic, strong) UIViewController * currentVC;

@end

@implementation LTFindViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.layer.contents = (id)([UIImage imageNamed:@"table_background"].CGImage);
    self.navigationItem.title = NSLocalizedString(@"Surprising", nil);
    
    NSArray * segmentArr = @[NSLocalizedString(@"find hot article", nil),NSLocalizedString(@"see random", nil)];
    
    UISegmentedControl * segmentControl = [[UISegmentedControl alloc]initWithItems:segmentArr];
    [segmentControl addTarget:self action:@selector(segmentControlPressed:) forControlEvents:UIControlEventValueChanged];
    segmentControl.layer.borderColor = [UIColor whiteColor].CGColor;
    segmentControl.layer.borderWidth = 2;
    segmentControl.tintColor = [UIColor whiteColor];
    segmentControl.backgroundColor = [UIColor clearColor];
    segmentControl.layer.cornerRadius = 10;
    segmentControl.layer.masksToBounds = YES;
    segmentControl.selectedSegmentIndex = 0;
    
    self.navigationItem.titleView = segmentControl;

    self.findHotVC = [[LTFindHotTableViewController alloc] initWithStyle:UITableViewStyleGrouped];
    self.findRandVC = [[LTFindRandomTableViewController alloc] initWithStyle:UITableViewStyleGrouped];
    
    [self addChildViewController:self.findHotVC];
    [self addChildViewController:self.findRandVC];
    
    self.findHotVC.view.frame = self.view.frame;
    self.findRandVC.view.frame = self.view.frame;
    
    [self.view addSubview:self.findHotVC.view];
    self.currentVC = self.findHotVC;
}

- (void) segmentControlPressed:(UISegmentedControl *)sender {
    switch (sender.selectedSegmentIndex) {
        case 0:
            [self transToNewViewController: self.findHotVC];
            break;
        case 1:
            [self transToNewViewController: self.findRandVC];
        default:
            break;
    }
}

//转换子视图控制器
- (void)transToNewViewController:(UIViewController *)newViewController {
    
    if (newViewController == self.currentVC) {
        return;
    }
    
    [self transitionFromViewController:self.currentVC toViewController:newViewController duration:0.3 options:UIViewAnimationOptionTransitionCrossDissolve animations:nil completion:^(BOOL finished) {
        if (finished) {
            [newViewController didMoveToParentViewController:self];
            _currentVC = newViewController;
        }
    }];
}

@end
