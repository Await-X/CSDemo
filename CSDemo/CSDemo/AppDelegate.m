//
//  AppDelegate.m
//  CSDemo
//
//  Created by apple on 2020/5/21.
//  Copyright © 2020 CS. All rights reserved.
//

#import "AppDelegate.h"

#import "XPFTabBarVC.h"

#import "HomeViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


///
- (void)xpf_window {
    //
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:YES];
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.rootViewController = [[XPFTabBarVC alloc] init];
    //self.window.rootViewController = [[HomeViewController alloc] init];
    [self.window makeKeyAndVisible];
}


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    [self xpf_window];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}

/// 程序进入后台
- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}

/// 程序进入前台
- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

/*

+ (AppDelegate *)sharedInstance
{
    static AppDelegate *appdelegate = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        appdelegate = [[AppDelegate alloc] init];
    });
    return appdelegate;
}
//- (UIInterfaceOrientationMask)application:(UIApplication *)application supportedInterfaceOrientationsForWindow:(UIWindow *)window {
//    NSLog(@"%s",__FUNCTION__);
//    if (self.isSupportLandscape) {
//        return UIInterfaceOrientationMaskAllButUpsideDown;
//    } else {
//        return UIInterfaceOrientationMaskPortrait;
//    }
//}


//是否允许旋转
- (BOOL)shouldAutorotate {
    NSLog(@"%s",__FUNCTION__);
    return YES;
}
//present时可支持的旋转方向（present时在supportedInterfaceOrientations前执行）
- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation {
    NSLog(@"%s",__FUNCTION__);
    if (_orientationMask & UIInterfaceOrientationMaskLandscapeLeft) {
        return UIInterfaceOrientationLandscapeLeft;
    }
    return UIInterfaceOrientationPortrait;
}
//支持的旋转方向
- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    NSLog(@"%s",__FUNCTION__);
    if ([AppDelegate sharedInstance].supportLandscape) {
        return _orientationMask | UIInterfaceOrientationMaskLandscapeLeft;
    } else {
        return UIInterfaceOrientationMaskPortrait;
    }
}


*/




















@end
