//
//  Other2Vc.m
//  CSDemo
//
//  Created by apple on 2020/8/11.
//  Copyright © 2020 CS. All rights reserved.
//

#import "Other2Vc.h"

@interface Other2Vc ()

@end

@implementation Other2Vc

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self onAddPushPOP];
}

/// 返回 iOS 如何判断当前页面是push进入还是present进入
- (void)did
{
    NSArray *viewcontrollers = self.navigationController.viewControllers;
    if (viewcontrollers.count > 1)
    {
        if ([viewcontrollers objectAtIndex:viewcontrollers.count - 1] == self)
        {  //push方式
            XPFLog(@"push方式");
            [self.navigationController popViewControllerAnimated:YES];
        }
    }
    else
    {  //present方式
        XPFLog(@"present方式");
        [self.navigationController dismissViewControllerAnimated:YES completion:nil];
    }
}

- (void)onAddPushPOP
{   //
    UIButton *addBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    addBtn.frame = CGRectMake(30, 180, self.view.bounds.size.width - 60, 44);
    addBtn.backgroundColor = [UIColor orangeColor];
    [addBtn setTitle:@" dis pres " forState:UIControlStateNormal];
    [addBtn addTarget:self action:@selector(didPushPOP) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:addBtn];
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
