//
//  AppDelegate.m
//  LiangxinTieba
//
//  Created by mac on 16/9/27.
//  Copyright © 2016年 XYD. All rights reserved.
//

#import "AppDelegate.h"

#import "LTTabBarController.h"
#import "LTLeftDrawerViewController.h"

#import "LTHomeViewController.h"
#import "LTFindViewController.h"
#import "LTPersonalViewController.h"

#import <LiangxinTiebaSDK/LTSDK.h>

#import "DrawerController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate
// TODO: autolayout练习，核心动画练习

// TODO: 测试、性能分析、设计模式

// TODO: 数据存储，多线程，网络请求

// TODO: 音频视频，系统功能调用-->打包、上架

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    [NSThread sleepForTimeInterval:1/24];
    
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    
    [[UINavigationBar appearance] setBarTintColor:RGB(20, 155, 213)];
    [[UINavigationBar appearance] setTitleTextAttributes:@{ NSForegroundColorAttributeName : [UIColor whiteColor] }];
    
    LTHomeViewController * homeVC = [[LTHomeViewController alloc]init];
    UINavigationController * firstVC = [[UINavigationController alloc]initWithRootViewController:homeVC];
    firstVC.tabBarItem.title = NSLocalizedString(@"my home", nil);
    firstVC.tabBarItem.image = [UIImage imageNamed:@"tabBar_home"];
    
    LTFindViewController * findVC = [[LTFindViewController alloc]init];
    UINavigationController * secondVC = [[UINavigationController alloc]initWithRootViewController:findVC];
    secondVC.tabBarItem.title = NSLocalizedString(@"find fun things", nil);
    secondVC.tabBarItem.image = [UIImage imageNamed:@"tabBar_find"];
    
    LTPersonalViewController * personVC = [[LTPersonalViewController alloc]init];
    personVC.tabBarItem.title = NSLocalizedString(@"personal center", nil);
    personVC.tabBarItem.image = [UIImage imageNamed:@"tabBar_person"];
    
    LTTabBarController * tabBarVC = [[LTTabBarController alloc]init];
    tabBarVC.viewControllers = @[firstVC, secondVC, personVC];
    
    LTLeftDrawerViewController * sideSlipVC = [[LTLeftDrawerViewController alloc]init];

    DrawerController * rootVC = [[DrawerController alloc]initWithMidVC:tabBarVC leftVC:sideSlipVC rithtVC:nil];
    tabBarVC.drawer = rootVC;

    self.window.rootViewController = rootVC;
    [self.window makeKeyAndVisible];
    
    [LTSDK printTest];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
