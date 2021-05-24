//
//  MyOneVC.m
//  CSDemo
//
//  Created by apple on 2020/10/29.
//  Copyright © 2020 CS. All rights reserved.
//

#import "MyOneVC.h"
#import "UIWindow+JXSafeArea.h"
#import "MJRefresh.h"

@interface MyOneVC ()

@property (nonatomic, strong) UIView *naviBGView;
@property (nonatomic, strong) UIView *naviBGView_1;

@end

@implementation MyOneVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self onxxxx];
}

///
- (void)onxxxx
{
    self.automaticallyAdjustsScrollViewInsets = NO;
    CGFloat topSafeMargin = [UIApplication.sharedApplication.keyWindow jx_layoutInsets].top;
    CGFloat naviHeight = [UIApplication.sharedApplication.keyWindow jx_navigationHeight];
    self.pagerView.pinSectionHeaderVerticalOffset = naviHeight;
  
    self.naviBGView_1 = [[UIView alloc] init];
    self.naviBGView_1.alpha = 1;
    self.naviBGView_1.backgroundColor = [UIColor clearColor];
    self.naviBGView_1.frame = CGRectMake(0, 0, self.view.bounds.size.width, naviHeight);
    [self.view addSubview:self.naviBGView_1];
    UIButton *back_1 = [UIButton buttonWithType:UIButtonTypeSystem];
    [back_1 setTitle:@"返回" forState:UIControlStateNormal];
    back_1.frame = CGRectMake(12, topSafeMargin, 44, 44);
    [back_1 addTarget:self action:@selector(backButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.naviBGView_1 addSubview:back_1];
    
    self.naviBGView = [[UIView alloc] init];
    self.naviBGView.alpha = 0;
    self.naviBGView.backgroundColor = [UIColor redColor];
    self.naviBGView.frame = CGRectMake(0, 0, self.view.bounds.size.width, naviHeight);
    [self.view addSubview:self.naviBGView];

    UILabel *naviTitleLabel = [[UILabel alloc] init];
    naviTitleLabel.text = @"导航栏隐藏";
    naviTitleLabel.textAlignment = NSTextAlignmentCenter;
    naviTitleLabel.frame = CGRectMake(0, topSafeMargin, self.view.bounds.size.width, 44);
    [self.naviBGView addSubview:naviTitleLabel];
     
    UIButton *back = [UIButton buttonWithType:UIButtonTypeSystem];
    [back setTitle:@"返回" forState:UIControlStateNormal];
    back.frame = CGRectMake(12, topSafeMargin, 44, 44);
    [back addTarget:self action:@selector(backButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.naviBGView addSubview:back];
     
    /*
    __weak typeof(self)weakSelf = self;
    self.pagerView.mainTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            //self.categoryView.titles = @[@"高级能力", @"高级爱好", @"高级队友"];
            //self.categoryView.defaultSelectedIndex = 0;
            //[self.categoryView reloadData];
            [self.pagerView reloadData];
            [weakSelf.pagerView.mainTableView.mj_header endRefreshing];
        });
    }];
    */
    
}


- (void)backButtonClicked:(UIButton *)btn {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];

    [self.navigationController setNavigationBarHidden:YES animated:YES];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];

    [self.navigationController setNavigationBarHidden:NO animated:NO];
}

- (void)pagerView:(JXPagerView *)pagerView mainTableViewDidScroll:(UIScrollView *)scrollView {
    //
    CGFloat thresholdDistance = 76;
    CGFloat percent = scrollView.contentOffset.y/thresholdDistance;
    percent = MAX(0, MIN(1, percent));
    self.naviBGView.alpha = percent;
    
    CGFloat percent_1 = (thresholdDistance - scrollView.contentOffset.y)/thresholdDistance;
    percent_1 = MAX(0, MIN(1, percent_1));
    self.naviBGView_1.alpha = percent_1;
    
}




@end
