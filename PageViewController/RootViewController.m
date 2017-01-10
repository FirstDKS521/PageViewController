//
//  RootViewController.m
//  PageViewController
//
//  Created by aDu on 2017/1/10.
//  Copyright © 2017年 DuKaiShun. All rights reserved.
//

#import "RootViewController.h"
#import "DKSPageViewController.h"

@interface RootViewController ()

@end

@implementation RootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"首页";
    self.navigationController.navigationBar.translucent = NO;
    
    NSArray *titleArray = @[@"发现", @"关注", @"订单", @"收藏"];
    NSMutableArray *controllerArray = [NSMutableArray array];
    for (int i = 0; i < 4; i++) {
        UIViewController *vc = [[UIViewController alloc] init];
        vc.view.backgroundColor = [UIColor colorWithRed:arc4random() % 256 / 255.0 green:arc4random() % 256 / 255.0 blue:arc4random() % 256 / 255.0 alpha:1.0];
        [controllerArray addObject:vc];
    }
    
    DKSPageViewController *dksVC = [[DKSPageViewController alloc] initWithTitles:titleArray controllers:controllerArray];
    dksVC.view.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    [self addChildViewController:dksVC];
    [self.view addSubview:dksVC.view];
}

@end
