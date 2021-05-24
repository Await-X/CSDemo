//
//  MyHSVC.m
//  CSDemo
//
//  Created by apple on 2020/11/23.
//  Copyright © 2020 CS. All rights reserved.
//

#import "MyHSVC.h"

#import "AppDelegate.h"


@interface MyHSVC ()

@property (nonatomic, assign) UIInterfaceOrientationMask orientationMask;

@end

@implementation MyHSVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _orientationMask = UIInterfaceOrientationMaskLandscapeLeft|UIInterfaceOrientationMaskPortrait;
    
    UIImageView *imgView = [[UIImageView alloc] init];
    [self.view addSubview:imgView];
    [imgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.centerY.mas_equalTo(0);
        make.width.mas_equalTo(300);
        make.height.mas_equalTo(200);
    }];
    
    imgView.image = YGIMGName(@"lufei");
    
    
    
    UIButton *buttonCS = [[UIButton alloc] init];
    [buttonCS setTitle:@"横" forState:(UIControlStateNormal)];
    [buttonCS setBackgroundColor:[UIColor redColor]];
    [buttonCS addTarget:self action:@selector(ActionHBtnClick) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:buttonCS];
    [buttonCS mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(150);
        make.right.mas_equalTo(-30);
        make.width.height.mas_equalTo(80);
    }];
    
    
    UIButton *hsBtn = [[UIButton alloc] init];
    [hsBtn setTitle:@"竖" forState:(UIControlStateNormal)];
    [hsBtn setBackgroundColor:[UIColor redColor]];
    [hsBtn addTarget:self action:@selector(ActionSBtnClick) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:hsBtn];
    [hsBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(150);
        make.left.mas_equalTo(30);
        make.width.height.mas_equalTo(80);
    }];
    
}
- (void)ActionSBtnClick
{
    //[AppDelegate sharedInstance].supportLandscape = NO;
    [self switchToLandscapePortrait];
}
- (void)ActionHBtnClick
{
    //[AppDelegate sharedInstance].supportLandscape = YES;
    [self switchToLandscapeRight];
}

//- (void)viewWillAppear:(BOOL)animated {
//    [super viewWillAppear:animated];
//    [AppDelegate sharedInstance].supportLandscape = YES;
//    NSLog(@"viewWillAppear : %s",__FUNCTION__);
//    [self switchToLandscapeRight];
//}
//
//- (void)viewWillDisappear:(BOOL)animated {
//    [super viewWillDisappear:animated];
//    [AppDelegate sharedInstance].supportLandscape = NO;
//    NSLog(@"viewWillDisappear : %s",__FUNCTION__);
//    [self switchToLandscapePortrait];
//}

//- (BOOL)shouldAutorotate {
//    NSLog(@"%s",__FUNCTION__);
//    return YES;
//}

//- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation {
//    NSLog(@"preferredInterfaceOrientationForPresentation : %s", __FUNCTION__);
////这里加入[AppDelegate sharedInstance].supportLandscape判断，是为了防止appdelegate中不支持目标方向，而产生Supported orientations has no common orientation with the application的错误
//    if ([AppDelegate sharedInstance].supportLandscape) {
//        if (_orientationMask & UIInterfaceOrientationMaskLandscapeLeft) {
//            return UIInterfaceOrientationLandscapeLeft;
//        }
//    }
//    return UIInterfaceOrientationPortrait;
//}

//- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
//    NSLog(@"supportedInterfaceOrientations : %s", __FUNCTION__);
////这里加入[AppDelegate sharedInstance].supportLandscape判断，是为了防止appdelegate中不支持目标方向，而产生Supported orientations has no common orientation with the application的错误
//    if ([AppDelegate sharedInstance].supportLandscape) {
//        return _orientationMask | UIInterfaceOrientationMaskLandscapeLeft;
//    } else {
//        return UIInterfaceOrientationMaskPortrait;
//    }
//}

// 手动设置横屏
- (void)switchToLandscapeRight {
    NSLog(@"switchToLandscapeRight : %s",__FUNCTION__);
    _orientationMask = UIInterfaceOrientationMaskLandscapeLeft;
    //为了防止plus及ipad机型自带桌面旋转功能时，横屏失败，所以先强制旋转到其他方向，再设置横屏才会有效果
    [[UIDevice currentDevice] setValue:@(UIDeviceOrientationFaceDown) forKey:@"orientation"];
    [[UIDevice currentDevice] setValue:@(UIDeviceOrientationLandscapeRight) forKey:@"orientation"];
}

// 手动设置竖屏
- (void)switchToLandscapePortrait {
    NSLog(@"switchToLandscapePortrait : %s",__FUNCTION__);
    _orientationMask = UIInterfaceOrientationMaskPortrait;
    [[UIDevice currentDevice] setValue:@(UIDeviceOrientationFaceDown) forKey:@"orientation"];
    [[UIDevice currentDevice] setValue:@(UIDeviceOrientationPortrait) forKey:@"orientation"];
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
