//
//  LTUtils.m
//  LiangxinTieba
//
//  Created by mac on 2016/9/27.
//  Copyright © 2016年 XYD. All rights reserved.
//

#import "LTUtils.h"

#define BundleName @"LTzh-cn"

@implementation LTUtils

+ (NSBundle *)getLocalBundle:(NSString *) name {
    NSString *bundlePath = [[NSBundle mainBundle] pathForResource:name ofType:@"bundle"];
    return [NSBundle bundleWithPath:bundlePath];
}

+(NSString *) getLabelByName:(NSString *) name {
    NSBundle * xzBundle = [self getLocalBundle:BundleName];
    return [xzBundle localizedStringForKey:name value:nil table:@"Localizable"];
}

+ (UIImage *) getImageByName:(NSString *) name {
    NSBundle * xzBundle = [self getLocalBundle:BundleName];
    NSString *imgpath = [xzBundle pathForResource:name ofType:@"png"];
    return [[UIImage alloc] initWithContentsOfFile:imgpath];
}

@end
