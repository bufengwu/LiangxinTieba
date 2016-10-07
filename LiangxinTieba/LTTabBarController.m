//
//  LTTabBarController.m
//  LiangxinTieba
//
//  Created by mac on 16/9/27.
//  Copyright © 2016年 XYD. All rights reserved.
//

#import "LTTabBarController.h"

@interface LTTabBarController () <UITabBarControllerDelegate>

@end

@implementation LTTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tabBar.tintColor = RGB(20, 155, 213);
    CALayer *TopBorder = [CALayer layer];
    TopBorder.frame = CGRectMake(0.0f, 0.0f, self.tabBar.frame.size.width, 0.5f);
    TopBorder.backgroundColor = [UIColor blackColor].CGColor;
    [self.tabBar.layer addSublayer:TopBorder];
    
    [self setHidesBottomBarWhenPushed:YES];
}

- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController {

}

@end
