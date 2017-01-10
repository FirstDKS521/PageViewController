//
//  DKSPageViewController.h
//  MoreTabBar
//
//  Created by aDu on 2017/1/6.
//  Copyright © 2017年 DuKaiShun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DKSPageViewController : UIViewController

/**
 * 默认字体的颜色
 */
@property (nonatomic, strong) UIColor *titleColor;

/**
 * 高亮字体的颜色
 */
@property (nonatomic, strong) UIColor *lightColor;

/**
 * titleArray 标题名称数组
 * controllerArray 子试图控制器数组
 */
- (id)initWithTitles:(NSArray *)titleArray controllers:(NSArray *)controllerArray;

@end
