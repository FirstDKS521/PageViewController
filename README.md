##iOS开发：对UIPageViewController的简单封装

开发中经常会有这样的需求![page.gif](http://upload-images.jianshu.io/upload_images/1840399-af10a2a3452e1ea6.gif?imageMogr2/auto-orient/strip)

在这里我简单的封装了下，便于学习如何使用UIPageViewController，由于项目中没有用到这个动能，暂时不知道需要哪些需求，所以只是一个简单的封装；使用方法简单，在你需要用到的页面，调用下面的方法，就可以看到效果：

```
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
```
demo中有一些文案说明，可以帮助理解；
