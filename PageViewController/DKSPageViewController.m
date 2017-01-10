//
//  DKSPageViewController.m
//  MoreTabBar
//
//  Created by aDu on 2017/1/6.
//  Copyright © 2017年 DuKaiShun. All rights reserved.
//

#import "DKSPageViewController.h"

#define K_Width self.view.frame.size.width
static float titleHeight = 40; //标题栏的高度
@interface DKSPageViewController ()<UIPageViewControllerDelegate, UIPageViewControllerDataSource>

@property (nonatomic, strong) UIPageViewController *pageVC;
@property (nonatomic, strong) NSArray *titleArray; //标题栏数组
@property (nonatomic, strong) NSArray *controllerArray; //控制器数组
@property (nonatomic, strong) NSMutableArray *buttonArray; //按钮数组
@property (nonatomic, assign) NSInteger count; //总数量
@property (nonatomic, strong) UIView *titleView; //标题视图
@property (nonatomic, strong) UIView *lineView; //下滑线

@end

@implementation DKSPageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
}

- (id)initWithTitles:(NSArray *)titleArray controllers:(NSArray *)controllerArray
{
    self = [super init];
    if (self) {
        self.count = titleArray.count;
        self.titleArray = titleArray;
        self.controllerArray = controllerArray;
        
        self.titleColor = [UIColor orangeColor];
        self.lightColor = [UIColor redColor];
        
        //添加标题栏
        [self addTitleView];
        
        self.titleView.frame = CGRectMake(0, 0, K_Width, titleHeight);
        self.lineView.frame = CGRectMake(0, titleHeight - 1, K_Width / _count, 1);
        self.pageVC.view.frame = CGRectMake(0, titleHeight, K_Width, self.view.frame.size.height - titleHeight);
    }
    return self;
}

#pragma mark - 添加导航标题

- (void)addTitleView
{
    for (int i = 0; i < self.count; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setTitle:self.titleArray[i] forState:UIControlStateNormal];
        [button setTitleColor:self.titleColor forState:UIControlStateNormal];
        [button setTitleColor:self.lightColor forState:UIControlStateSelected];
        button.tag = 100 + i;
        button.frame = CGRectMake(i * K_Width / self.count, 0, K_Width / self.count, titleHeight);
        [button addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
        [self.titleView addSubview:button];
        [self.buttonArray addObject:button];
    }
    [self click:self.buttonArray[0]];
}

#pragma mark - 点击按钮的方法

- (void)click:(UIButton *)button
{
    [self unClick:button status:YES];
}

- (void)unClick:(UIButton *)button status:(BOOL)status
{
    for (UIButton *btn in self.buttonArray) {
        if (button.tag == btn.tag) {
            btn.selected = YES;
        } else {
            btn.selected = NO;
        }
    }
    [self scrollLineView:button.tag - 100];
    if (status) {
        [self.pageVC setViewControllers:@[[self.controllerArray objectAtIndex:button.tag - 100]] direction:(UIPageViewControllerNavigationDirectionForward) animated:NO completion:nil];
    }
}

#pragma mark - UIPageViewController

//前一个页面,如果返回为nil,那么UIPageViewController就会认为当前页面是第一个页面
- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController
{
    //获取当前的位置
    NSInteger index = [self indexForViewController:viewController];
    if (index == 0 || index == NSNotFound) {
        return nil;
    }
    return [self.controllerArray objectAtIndex:index - 1];
}

//下一个页面,如果返回为nil,那么UIPageViewController就会认为当前页面是最后一个页面
- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController
{
    NSInteger index = [self indexForViewController:viewController];
    if (index == NSNotFound || index == self.controllerArray.count - 1) {
        return nil;
    }
    return [self.controllerArray objectAtIndex:index + 1];
}

//这个方法是在UIPageViewController结束滚动或翻页的时候触发
- (void)pageViewController:(UIPageViewController *)pageViewController didFinishAnimating:(BOOL)finished previousViewControllers:(NSArray<UIViewController *> *)previousViewControllers transitionCompleted:(BOOL)completed
{
    UIViewController *viewcontroller = self.pageVC.viewControllers[0];
    NSUInteger index = [self indexForViewController:viewcontroller];
    //改变button的颜色
    [self unClick:self.buttonArray[index] status:NO];
}

//返回多少个控制器
- (NSInteger)presentationCountForPageViewController:(UIPageViewController *)pageViewController
{
    return self.controllerArray.count;
}

#pragma mark - 获取当前VC的位置

- (NSInteger)indexForViewController:(UIViewController *)controller
{
    return [self.controllerArray indexOfObject:controller];
}

#pragma mark - 滚动条滚动

- (void)scrollLineView:(NSInteger)index
{
    [UIView animateWithDuration:0.05 animations:^{
        self.lineView.frame = CGRectMake(index * K_Width / _count, titleHeight - 1, K_Width / _count, 1);
    }];
}

#pragma mark - init

- (UIPageViewController *)pageVC
{
    if (!_pageVC) {
        NSDictionary *option = [NSDictionary dictionaryWithObject:[NSNumber numberWithInteger:UIPageViewControllerSpineLocationNone] forKey:UIPageViewControllerOptionInterPageSpacingKey];
        _pageVC = [[UIPageViewController alloc] initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal options:option];
        [_pageVC setViewControllers:@[self.controllerArray[0]] direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:nil];
        _pageVC.view.backgroundColor = [UIColor whiteColor];
        _pageVC.delegate = self;
        _pageVC.dataSource = self;
        [self addChildViewController:_pageVC];
        [self.view addSubview:_pageVC.view];
    }
    return _pageVC;
}

- (UIView *)titleView
{
    if (!_titleView) {
        _titleView = [UIView new];
        [self.view addSubview:_titleView];
    }
    return _titleView;
}

- (UIView *)lineView
{
    if (!_lineView) {
        _lineView =  [UIView new];
        _lineView.clipsToBounds = YES;
        //滚动条的颜色
        _lineView.backgroundColor = self.lightColor;
        [self.titleView addSubview:_lineView];
    }
    return _lineView;
}

- (NSMutableArray *)buttonArray
{
    if (_buttonArray == nil) {
        _buttonArray = [NSMutableArray array];
    }
    return _buttonArray;
}

@end
