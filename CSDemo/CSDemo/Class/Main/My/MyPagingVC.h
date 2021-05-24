//
//  MyPagingVC.h
//  CSDemo
//
//  Created by apple on 2020/10/29.
//  Copyright © 2020 CS. All rights reserved.
//

#import "PagingViewController.h"

#import "ListViewController.h"

#import "JXPagerView.h"
#import "JXCategoryView.h"
#import "JXCategoryTitleView.h"

#import "PagingViewTableHeaderView.h"
#import "MyPagingStoreHeaderView.h"

NS_ASSUME_NONNULL_BEGIN

@interface MyPagingVC : UIViewController <JXPagerViewDelegate, JXPagerMainTableViewGestureDelegate>

@property (nonatomic, strong) JXPagerView *pagerView;
//@property (nonatomic, strong) PagingViewTableHeaderView *userHeaderView;
@property (nonatomic, strong) MyPagingStoreHeaderView *userHeaderView;
@property (nonatomic, strong, readonly) JXCategoryTitleImageView *categoryView;
@property (nonatomic, assign) BOOL isNeedFooter;
@property (nonatomic, assign) BOOL isNeedHeader;
- (JXPagerView *)preferredPagingView;

@end

NS_ASSUME_NONNULL_END
