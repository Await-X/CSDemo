// 

#import "XPFTabBarVC.h"
#import "XPFNavigationVC.h"

#import "OtherViewController.h"
#import "MyViewController.h"
#import "HomeViewController.h"

@interface XPFTabBarVC ()
///
@property (nonatomic, strong) HomeViewController *home;
///
@property (nonatomic, strong) OtherViewController *other;
///
@property (nonatomic, strong) MyViewController *my;
///
@property (nonatomic, strong) NSArray *titles;
///
@property (nonatomic, strong) NSArray *images;
///
@property (nonatomic, strong) NSArray *selectedImages;

@end

@implementation XPFTabBarVC

- (NSArray *)titles {
    if (!_titles) {
        _titles = @[@"首页", @"消息", @"我的"];
    }
    return _titles;
}
- (NSArray *)images {
    if (!_images) {
        _images = @[@"tabbar_shop_normal", @"tabbar_my_normal", @"tabbar_meeting_normal"];
    }
    return _images;
}
- (NSArray *)selectedImages {
    if (!_selectedImages) {
        _selectedImages = @[@"tabbar_shop_selected", @"tabbar_my_selected", @"tabbar_meeting_selected"];
    }
    return _selectedImages;
}

- (void)viewDidLoad {
    [super viewDidLoad]; 
    //
    [self InitView];
    
}

///
- (void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item {
    tabBar.tintColor = [UIColor redColor]; //新版本xcode不加会出现蓝色字体。
    NSLog(@" ----- %@", item.title);
    
}

///  tab 透明
- (void)tabBarClearColor {
    [[UITabBar appearance] setBarTintColor:[UIColor whiteColor]];
    [UITabBar appearance].translucent = NO;
}

/// 发送通知
- (void)addNotificationCenterName:(NSString *)notifyName {
    [[NSNotificationCenter defaultCenter] postNotificationName:notifyName object:nil];
}

///
- (void)InitView
{   //
    HomeViewController *homeVC = [[HomeViewController alloc] init];
    self.home = homeVC;
    //
    OtherViewController *otherVC = [[OtherViewController alloc] init];
    self.other = otherVC;
    //
    MyViewController *myVC = [[MyViewController alloc] init];
    self.my = myVC;
    
    NSArray *viewControllers = @[homeVC, otherVC, myVC];
    for (int i = 0; i < viewControllers.count; i++)
    {
        UIViewController *childVc = viewControllers[i];
        
        [self setVC:childVc title:self.titles[i] image:self.images[i] selectedImage:self.selectedImages[i] offset:5.0f badgeValueHide:YES badgeValueNumber:0 tag:i+10090];
    }
}

///
- (void)setVC:(UIViewController *)VC
        title:(NSString *)title
        image:(NSString *)image
selectedImage:(NSString *)selectedImage
       offset:(CGFloat)offset badgeValueHide:(BOOL)isHide badgeValueNumber:(NSString *)badgeStr tag:(NSInteger)tag
{
    //
    VC.tabBarItem.title = title;
    //VC.tabBarItem.titlePositionAdjustment = UIOffsetMake(0, -offset*3.0);
    //
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    dict[NSForegroundColorAttributeName] = [UIColor grayColor];//[UIColor colorWithHexString:@"#FFFFFF"];
    dict[NSFontAttributeName] = [UIFont systemFontOfSize:17];
    [VC.tabBarItem setTitleTextAttributes:dict forState:(UIControlStateNormal)];
    NSMutableDictionary *dictSeled = [NSMutableDictionary dictionary];
    dictSeled[NSForegroundColorAttributeName] = [UIColor redColor];
    dictSeled[NSFontAttributeName] = [UIFont systemFontOfSize:17];
    [VC.tabBarItem setTitleTextAttributes:dictSeled forState:(UIControlStateSelected)];
    //
    VC.tabBarItem.image = [[UIImage imageNamed:image] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    VC.tabBarItem.selectedImage = [[UIImage imageNamed:selectedImage] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    //VC.tabBarItem.imageInsets = UIEdgeInsetsMake(offset, 0, -offset, 0);
    //
    if (isHide) {
        if ([badgeStr isEqualToString:@"0"]) { }
        else
        {
        }
    }
    VC.tabBarItem.tag = tag;
    //
    XPFNavigationVC *nav = [[XPFNavigationVC alloc] initWithRootViewController:VC];
    [self addChildViewController:nav];
}

@end
