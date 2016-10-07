//
//  DrawerController.m
//  DrawerController
//
//  Created by Logic on 2016/10/1.
//  Copyright © 2016年 BFW. All rights reserved.
//

#import "DrawerController.h"

#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)

@interface DrawerController ()

@property (nonatomic, strong) UIPanGestureRecognizer * pan;
@property (nonatomic, strong) UITapGestureRecognizer * tap;

@end

@implementation DrawerController
@synthesize drawerState;

- (instancetype)initWithMidVC : (UIViewController *) midVC leftVC :(UIViewController *) leftVC rithtVC: (UIViewController *) rightVC {
    self = [super init];
    
    self.midVC = midVC;
    self.leftVC = leftVC;
    self.rightVC = rightVC;
    
    self.openWidth = SCREEN_WIDTH/3*2;
    self.openTime = 0.3;
    self.thresholdWidth = SCREEN_WIDTH/3;
    
    self.pan = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(handlePan:)];
    self.tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(handleTap:)];

    [self addObserver:self forKeyPath:@"PanGestureEnabled" options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld context:nil];
    [self addObserver:self forKeyPath:@"TapGestureEnabled" options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld context:nil];
    
    self.PanGestureEnabled = YES;
    self.TapGestureEnabled = YES;
    self.tap.enabled = NO;
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if (self.leftVC) {
        [self.view addSubview:self.leftVC.view];
    }
    if (self.rightVC) {
        [self.view addSubview:self.rightVC.view];
    }
    if (self.midVC) {
        [self.view addSubview:self.midVC.view];
    }
}

//KVO监测视图手势的启用
- (void)observeValueForKeyPath:(nullable NSString *)keyPath ofObject:(nullable id)object change:(nullable NSDictionary<NSString*, id> *)change context:(nullable void *)context {
    if ([keyPath isEqualToString:@"PanGestureEnabled"]) {
        if (self.PanGestureEnabled) {
            [self.midVC.view addGestureRecognizer:self.pan];
        } else {
            [self.midVC.view removeGestureRecognizer:self.pan];
        }
    } else if ([keyPath isEqualToString:@"TapGestureEnabled"]) {
        if (self.TapGestureEnabled) {
            [self.midVC.view addGestureRecognizer:self.tap];
        } else {
            [self.midVC.view removeGestureRecognizer:self.tap];
        }
    }
}

/**
 *  根据拖动手势执行不同的视图位移动作
 *
 *  @param rec 手势
 */
- (void) handlePan: (UIPanGestureRecognizer *)rec{
    
    CGPoint center = self.view.center;
    CGPoint point = [rec translationInView:self.view];
    switch (rec.state) {
        case UIGestureRecognizerStateBegan:
            switch (drawerState) {
                case DrawerStateNormal:
                    if (point.x > 0 && self.leftVC) {       //右滑、左视图非空
                        [self.rightVC.view setHidden:YES];
                        [self.leftVC.view setHidden:NO];
                        drawerState = DrawerStateLeftOpening;
                    }
                    if (point.x < 0 && self.rightVC) {      //左滑、右视图存在
                        [self.rightVC.view setHidden:NO];
                        [self.leftVC.view setHidden:YES];
                        drawerState = DrawerStateRightOpening;
                    }
                    break;
                case DrawerStateLeftOpened:
                    if (point.x < 0) {
                        drawerState = DrawerStateLeftClosing;
                    }
                    break;
                case DrawerStateRightOpened:
                    if (point.x > 0) {
                        drawerState = DrawerStateRightClosing;
                    }
                    break;
                default:
                    break;
            }
            break;
        case UIGestureRecognizerStateChanged:
            switch (drawerState) {
                case DrawerStateLeftOpening:
                    if (point.x > 0 && self.leftVC) {
                        self.midVC.view.center = CGPointMake(center.x + point.x , center.y);
                    }
                    break;
                case DrawerStateRightOpening:
                    if (point.x < 0 && self.rightVC) {
                        self.midVC.view.center = CGPointMake(center.x + point.x , center.y);
                    }
                    break;
                case DrawerStateLeftClosing:
                    if (point.x < 0 && point.x > -self.openWidth ) {        //左滑，滑动距离小于抽屉的拉开距离
                        self.midVC.view.center = CGPointMake(center.x + self.openWidth + point.x , center.y);
                    }
                    break;
                case DrawerStateRightClosing:
                    if (point.x > 0 && point.x < self.openWidth ) {        //左滑，滑动距离小于抽屉的拉开距离
                        self.midVC.view.center = CGPointMake(center.x - self.openWidth + point.x , center.y);
                    }
                    break;
                default:
                    break;
            }
            break;
        case UIGestureRecognizerStateEnded:
            switch (drawerState) {
                case DrawerStateLeftOpening:
                    if (point.x > self.thresholdWidth) {     //滑动距离大于预设阈值
                        [self openLeftDrawerWithNowOpenedWidth:point.x];
                    } else {
                        [self closeDrawer];
                    }
                    break;
                case DrawerStateRightOpening:
                    if (point.x < -self.thresholdWidth) {
                        [self openRightDrawerWithNowOpenedWidth:point.x];
                    } else {
                        [self closeDrawer];
                    }
                    break;
                case DrawerStateLeftClosing:
                case DrawerStateRightClosing:
                    [self closeDrawer];
                    break;
                default:
                    break;
            }
            break;
        default:
            break;
    }
}

- (void) handleTap: (UITapGestureRecognizer *)rec{
    [self closeDrawer];
}

- (void) openLeftDrawerWithNowOpenedWidth : (CGFloat)x {
    if (!self.leftVC) {
        return;
    }
    CGPoint center = self.view.center;
    NSTimeInterval time = self.openTime *(self.openWidth - x)/self.openWidth;       //动画时间=预设时间*当前已拉开距离/预设抽屉展开距离
    [UIView animateWithDuration:time animations:^{
        self.midVC.view.center = CGPointMake(center.x + self.openWidth , center.y);
    } completion:^(BOOL finished) {
        drawerState = DrawerStateLeftOpened;
        self.tap.enabled = YES;
    }];
}

- (void) openRightDrawerWithNowOpenedWidth : (CGFloat)x {
    if (!self.rightVC) {
        return;
    }
    CGPoint center = self.view.center;
    NSTimeInterval time = self.openTime *(self.openWidth + x)/self.openWidth;
    [UIView animateWithDuration:time animations:^{
        self.midVC.view.center = CGPointMake(center.x - self.openWidth , center.y);
    } completion:^(BOOL finished) {
        drawerState = DrawerStateRightOpened;
        self.tap.enabled = YES;
        
    }];
}

#pragma mark 对外接口
- (void) openLeftDrawer {
    if (!self.leftVC) {
        return;
    }
    if (drawerState == DrawerStateNormal) {
        [self.rightVC.view setHidden:YES];
        [self.leftVC.view setHidden:NO];
        CGPoint center = self.view.center;
        [UIView animateWithDuration:self.openTime animations:^{
            self.midVC.view.center = CGPointMake(center.x + self.openWidth , center.y);
        } completion:^(BOOL finished) {
            drawerState = DrawerStateLeftOpened;
            self.tap.enabled = YES;
        }];
    }
}

- (void) openRightDrawer {
    if (!self.rightVC) {
        return;
    }
    if (drawerState == DrawerStateNormal) {
        [self.rightVC.view setHidden:NO];
        [self.leftVC.view setHidden:YES];
        CGPoint center = self.view.center;
        [UIView animateWithDuration:self.openTime animations:^{
            self.midVC.view.center = CGPointMake(center.x - self.openWidth , center.y);
        } completion:^(BOOL finished) {
            drawerState = DrawerStateRightOpened;
            self.tap.enabled = YES;
        }];
    }
}

- (void) closeDrawer {
    CGFloat openedWidth = ABS(self.midVC.view.center.x - self.view.center.x);   //从mid视图当前中心点移动到屏幕中心
    NSTimeInterval time = self.openTime *openedWidth/self.openWidth;
    [UIView animateWithDuration:time animations:^{
        self.midVC.view.center = self.view.center;
    } completion:^(BOOL finished) {
        drawerState = DrawerStateNormal;
        self.tap.enabled = NO;
    }];
}

- (void) leftButtonTrigger {
    if (!self.leftVC) {
        return;
    }
    if (drawerState == DrawerStateLeftOpened) {
        [self closeDrawer];
    } else if (drawerState == DrawerStateNormal) {
        [self openLeftDrawer];
    }
}

- (void) rightButtonTrigger {
    if (!self.rightVC) {
        return;
    }
    if (drawerState == DrawerStateRightOpened) {
        [self closeDrawer];
    } else if (drawerState == DrawerStateNormal) {
        [self openRightDrawer];
    }
}

@end
