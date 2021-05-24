//

#import "XPFNavigationVC.h"

@interface XPFNavigationVC ()
<
UINavigationBarDelegate, UINavigationControllerDelegate, UIGestureRecognizerDelegate
>

@end

@implementation XPFNavigationVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //UIGestureRecognizerDelegate
    self.interactivePopGestureRecognizer.delegate = self;
    //UINavigationControllerDelegate
    self.delegate = self;
}

#pragma mark - UINavigationControllerDelegate

- (void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated{
    
    if (navigationController.viewControllers.count == 1) {
        //如果是 rootViewController 就关闭手势响应
        self.interactivePopGestureRecognizer.enabled = NO;
    } else {
        //如果不是 rootViewController 就开启手势响应
        self.interactivePopGestureRecognizer.enabled = YES;
    }
}

//
+ (void)initialize {
    UINavigationBar *bar = [UINavigationBar appearance];
    
    // 导航栏背景颜色
    [bar setBarTintColor:[UIColor blackColor]];
    
    // 需求要求导航时图片
    //UIImage *bg = [UIImage imageNamed:@""];
    //[bar setBackgroundImage:bg forBarMetrics:UIBarMetricsDefault];
    // 设置导航文字颜色和大小, 需要改变字体样式添加如下
    [bar setTitleTextAttributes:@{NSFontAttributeName : [UIFont systemFontOfSize:17.0f], /*NSStrokeWidthAttributeName : @3,*/ NSForegroundColorAttributeName:[UIColor whiteColor]}];
    
}

//
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    
    if (self.childViewControllers.count) {
        viewController.hidesBottomBarWhenPushed = YES;
        UIButton *button = [[UIButton alloc] init];
        //[button setImage:[UIImage imageNamed:@"navigationButtonReturn"] forState:UIControlStateNormal];
        //[button setImage:[UIImage imageNamed:@"navigationButtonReturnClick"] forState:UIControlStateHighlighted];
        button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        [button setTitle:@"<" forState:UIControlStateNormal];
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
        //[button setBackgroundImage:[UIImage imageNamed:@"返回"] forState:(UIControlStateNormal)];
        [button addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
        
        CGFloat www = 20.0;
        button.bounds = CGRectMake(0, 0, www, www);
        button.contentEdgeInsets = UIEdgeInsetsMake(0, -5, 0, 0);
        button.titleLabel.font = [UIFont systemFontOfSize:17.0f];
        
        viewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    }
    //push 时关闭手势响应
    self.interactivePopGestureRecognizer.enabled = NO;
    [super pushViewController:viewController animated:animated];
}

/** 项目中返回🔙 MJWNavigationController */
- (void)back {
    [self popViewControllerAnimated:YES];
}

///
- (UIStatusBarStyle)preferredStatusBarStyle {
    //return UIStatusBarStyleLightContent;
    return UIStatusBarStyleDefault;
}
///
- (void)popToBack {
    [self popViewControllerAnimated:YES];
}
///
- (UIViewController *)popViewControllerAnimated:(BOOL)animated {
    return [super popViewControllerAnimated:animated];
}
#pragma mark --------navigation delegate
////该方法可以解决popRootViewController时tabbar的bug
//- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated
//{
//    //删除系统自带的tabBarButton
//    for (UIView *tabBar in self.tabBarController.tabBar.subviews)
//    {
//        if ([tabBar isKindOfClass:NSClassFromString(@"UITabBarButton")])
//        {
//            [tabBar removeFromSuperview];
//        }
//    }
//
//}

@end
