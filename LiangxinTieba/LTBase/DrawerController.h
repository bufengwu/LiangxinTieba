//
//  DrawerController.h
//  DrawerController
//
//  Created by Logic on 2016/10/1.
//  Copyright © 2016年 BFW. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, DrawerState) {
    DrawerStateNormal = 0,      //中间视图正常显示，左右抽屉隐藏
    DrawerStateLeftOpening,   //使用手势拖动拉开左抽屉过程中
    DrawerStateLeftOpened,   //左抽屉完全打开
    DrawerStateRightOpening,  //使用手势拖动拉开右抽屉过程中
    DrawerStateRightOpened,  //右抽屉完全打开

    DrawerStateLeftClosing, //使用手势拖动关闭左抽屉过程中
    DrawerStateRightClosing,    //使用手势拖动关闭右抽屉过程中
};

@interface DrawerController : UIViewController

@property (nonatomic, strong, nullable) UIViewController * leftVC;
@property (nonatomic, strong, nullable) UIViewController * rightVC;
@property (nonatomic, strong, nonnull) UIViewController * midVC;

/**
 *  抽屉状态
 */
@property (nonatomic, assign, readonly) DrawerState drawerState;

/**
 *  抽屉打开过程的动画时间，默认0.3秒
 */
@property (nonatomic, assign) NSTimeInterval openTime;

/**
 *  抽屉展开的的宽度，默认为四分之三屏幕宽度
 */
@property (nonatomic, assign) CGFloat openWidth;

/**
 *  使用拖动手势打开抽屉的阈值，大于此距离弹出抽屉，小于关闭抽屉，默认三分之一屏幕宽度
 */
@property (nonatomic, assign) CGFloat thresholdWidth;

/**
 *  是否启用左右拖动手势管理抽屉，默认启用;需要在设置了三个视图后修改
 */
@property (nonatomic, assign) BOOL PanGestureEnabled;

/**
 *  开启抽屉后单击手势关闭抽屉，默认启用;需要在设置了三个视图后修改
 */
@property (nonatomic, assign) BOOL TapGestureEnabled;

/**
 *  Drawer视图控制器初始化函数
 *
 *  @param midVC   中间视图控制器
 *  @param leftVC  左视图控制器，可为空
 *  @param rightVC 右视图控制器，可为空
 *
 *  @return Drawer的实例对象
 */
- (nonnull instancetype)initWithMidVC : (nonnull UIViewController *) midVC leftVC :(nullable UIViewController *) leftVC rithtVC: (nullable UIViewController *) rightVC;

/**
 *  打开左侧抽屉
 */
- (void) openLeftDrawer;

/**
 *  打开右侧抽屉
 */
- (void) openRightDrawer;

/**
 *  关闭抽屉
 */
- (void) closeDrawer;

/**
 *  左抽屉控制，关闭时调用打开抽屉，打开时调用关闭抽屉
 */
- (void) leftButtonTrigger;

/**
 *  右抽屉控制，关闭时调用打开抽屉，打开时调用关闭抽屉
 */
- (void) rightButtonTrigger;

@end
