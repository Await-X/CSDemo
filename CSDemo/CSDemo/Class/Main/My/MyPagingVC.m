//
//  MyPagingVC.m
//  CSDemo
//
//  Created by apple on 2020/10/29.
//  Copyright © 2020 CS. All rights reserved.
//

#import "MyPagingVC.h"

@interface MyPagingVC ()
<
JXCategoryViewDelegate, JXCategoryListContainerViewDelegate
>
///
@property (nonatomic, strong) JXCategoryTitleImageView *categoryView;
///
@property (nonatomic, assign) NSInteger new_exchange;
///
@property (nonatomic, assign) NSInteger cheap_exchange;

@end

@implementation MyPagingVC

- (void)addUI
{
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationController.navigationBar.translucent = false;
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    /// 自定义一个 view
    _userHeaderView = [[MyPagingStoreHeaderView alloc] init];
    _userHeaderView.imageView.image = [UIImage imageNamed:@"lufei.jpg"];
    [_userHeaderView.btn setBackgroundImage:[UIImage imageNamed:@"lufei.jpg"] forState:(UIControlStateNormal)];
    _userHeaderView.nickLabel.text = @"";
//    _userHeaderView.clickBlock = ^(NSInteger index) {
//        NSLog(@" 点击了这个top image");
//    };
    self.categoryView = [[JXCategoryTitleImageView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, JXheightForHeaderInSection)];
    self.categoryView.delegate = self;
    self.categoryView.titleSelectedFont = [UIFont systemFontOfSize:14];//BFont(WidthScale750(30));
    self.categoryView.titleSelectedColor = [UIColor blueColor];
    self.categoryView.titleFont = [UIFont systemFontOfSize:14];//Font(WidthScale750(28));
    self.categoryView.titleColor = [UIColor whiteColor];
    self.categoryView.averageCellSpacingEnabled = NO;
    self.categoryView.cellWidth = JXCategoryViewAutomaticDimension;
    self.categoryView.cellSpacing = 15*RATIO;
    self.categoryView.backgroundColor = [UIColor redColor];
    [self.view addSubview:self.categoryView];
    
    self.categoryView.titles = @[@"综合", @"新品", @"价格"];
    self.categoryView.imageNames = @[@"", @"", @"store_price0"];
    self.categoryView.titleColorGradientEnabled = YES;
    self.categoryView.titleImageSpacing = 5;
    self.categoryView.imageTypes = @[@5, @5, @3];
    self.categoryView.imageSize = CGSizeMake(14, 14);
    
    JXCategoryIndicatorLineView *lineView = [[JXCategoryIndicatorLineView alloc] init];
    lineView.indicatorColor = [UIColor clearColor];//[UIColor colorWithRed:105/255.0 green:144/255.0 blue:239/255.0 alpha:1];
    lineView.indicatorWidth = 30;
    self.categoryView.indicators = @[lineView];
    
    _pagerView = [self preferredPagingView];
    self.pagerView.mainTableView.gestureDelegate = self;
    [self.view addSubview:self.pagerView];

    self.categoryView.listContainer = (id<JXCategoryViewListContainer>)self.pagerView.listContainerView;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self addUI];
}
 
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    self.navigationController.interactivePopGestureRecognizer.enabled = (self.categoryView.selectedIndex == 0);
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    self.navigationController.interactivePopGestureRecognizer.enabled = YES;
}
 
- (JXPagerView *)preferredPagingView {
    return [[JXPagerView alloc] initWithDelegate:self];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    self.pagerView.frame = self.view.bounds;
}

#pragma mark - JXPagerViewDelegate
- (UIView *)tableHeaderViewInPagerView:(JXPagerView *)pagerView {
    return self.userHeaderView;
}

- (NSUInteger)tableHeaderViewHeightInPagerView:(JXPagerView *)pagerView {
    return JXTableHeaderViewHeight;
}

- (NSUInteger)heightForPinSectionHeaderInPagerView:(JXPagerView *)pagerView {
    return JXheightForHeaderInSection;
}

- (UIView *)viewForPinSectionHeaderInPagerView:(JXPagerView *)pagerView {
    return self.categoryView;
}

- (NSInteger)numberOfListsInPagerView:(JXPagerView *)pagerView {
    //和categoryView的item数量一致
    return 3;
}

- (id<JXPagerViewListViewDelegate>)pagerView:(JXPagerView *)pagerView initListAtIndex:(NSInteger)index {
    ListViewController *list = [[ListViewController alloc] init];
    //list.title = self.titles[index];
    list.isNeedHeader = self.isNeedHeader;
    list.isNeedFooter = self.isNeedFooter;
    if (index == 0) {
        list.dataSource = @[@"橡胶火箭", @"橡胶火箭炮", @"橡胶机关枪", @"橡胶子弹", @"橡胶攻城炮", @"橡胶象枪", @"橡胶象枪乱打", @"橡胶灰熊铳", @"橡胶雷神象枪", @"橡胶猿王枪", @"橡胶犀·榴弹炮", @"橡胶大蛇炮", @"橡胶火箭", @"橡胶火箭炮", @"橡胶机关枪", @"橡胶子弹", @"橡胶攻城炮", @"橡胶象枪", @"橡胶象枪乱打", @"橡胶灰熊铳", @"橡胶雷神象枪", @"橡胶猿王枪", @"橡胶犀·榴弹炮", @"橡胶大蛇炮"].mutableCopy;
    } else if (index == 1) {
        list.dataSource = @[@"吃烤肉", @"吃鸡腿肉", @"吃牛肉", @"各种肉"].mutableCopy;
    } else {
        list.dataSource = @[@"【剑士】罗罗诺亚·索隆", @"【航海士】娜美", @"【狙击手】乌索普", @"【厨师】香吉士", @"【船医】托尼托尼·乔巴", @"【船匠】 弗兰奇", @"【音乐家】布鲁克", @"【考古学家】妮可·罗宾"].mutableCopy;
    }
    return list;
}


/// 点击事件
- (void)categoryView:(JXCategoryBaseView *)categoryView didClickSelectedItemAtIndex:(NSInteger)index {
    if (index == 2) {
        if (self.cheap_exchange == -1) {
            self.cheap_exchange = 0;
            return;
        }
        if (self.cheap_exchange == 0) {
            self.categoryView.imageNames = @[@"", @"", @"store_price0"];
        }
        else if (self.cheap_exchange == 1) {
            self.categoryView.imageNames = @[@"", @"", @"store_price1"];
        }
        else if (self.cheap_exchange == 2) {
            self.categoryView.imageNames = @[@"", @"", @"store_price2"];
        }
        [self.categoryView reloadData];
    }
}

#pragma mark - JXCategoryViewDelegate
- (void)categoryView:(JXCategoryBaseView *)categoryView didSelectedItemAtIndex:(NSInteger)index {
    self.navigationController.interactivePopGestureRecognizer.enabled = (index == 0);
}

#pragma mark - JXPagerMainTableViewGestureDelegate
- (BOOL)mainTableViewGestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    //禁止categoryView左右滑动的时候，上下和左右都可以滚动
    if (otherGestureRecognizer == self.categoryView.collectionView.panGestureRecognizer) {
        return NO;
    }
    return [gestureRecognizer isKindOfClass:[UIPanGestureRecognizer class]] && [otherGestureRecognizer isKindOfClass:[UIPanGestureRecognizer class]];
}


@end
