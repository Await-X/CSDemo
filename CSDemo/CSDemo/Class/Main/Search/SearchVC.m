//
//  SearchVC.m
//  CS
//
//  Created by apple on 2020/6/28.
//  Copyright © 2020 CS. All rights reserved.
//

#import "SearchVC.h"

#define SH ([[UIScreen mainScreen] bounds].size.height)
#define SW ([[UIScreen mainScreen] bounds].size.width)

@interface SearchVC ()
<
UISearchBarDelegate
>

@property (nonatomic, strong) UISearchBar *searchBar;

@end

@implementation SearchVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //self.view.backgroundColor = [UIColor xpf_randomColor];
    [self onnav];
    
    
    
    [self ss];
    
}



- (void)ss
{
    
    UIButton *viewCAB = [[UIButton alloc] init];
    viewCAB.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:viewCAB];
    [viewCAB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(0);
        make.centerY.mas_equalTo(200);
        make.width.height.mas_equalTo(100);
    }];
    viewCAB.tag = 100;
    [viewCAB addTarget:self action:@selector(onAction:) forControlEvents:(UIControlEventTouchUpInside)];
}

- (void)onAction:(UIButton *)button
{
    [button.layer addAnimation:[self moveX:0.0f x:-100] forKey:@"rotationAnimation"];

//    [UIView animateWithDuration:0.3 animations:^{
//    } completion:^(BOOL finished) {
//        self.view.center = CGPointMake(0, -(SH/2));
//    }];
    [UIView animateWithDuration:0.3 animations:^{
        self.view.center = CGPointMake(SW/2, -(SH/2));
    }];
}

///
- (CABasicAnimation *)moveX:(CGFloat)time x:(NSInteger)x
{
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.translation.y"];
    //animation.toValue = [NSValue valueWithCGPoint:CGPointMake(300, 300)]; // 终了帧
    animation.toValue = [NSNumber numberWithFloat:x];
    //animation.byValue = [NSNumber numberWithFloat:x];
    animation.duration = time;
    //animation.beginTime = CACurrentMediaTime() + 1;// 1秒后执行
    animation.removedOnCompletion = NO;
    animation.repeatCount = MAXFLOAT;
    animation.fillMode = kCAFillModeForwards;
    
    //animation.cumulative = YES;
    //由快变慢
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    return animation;
}


#pragma mark - 搜索栏
- (void)onnav
{
    //添加方法一  （此方法当界面消失时，需要在viewWillDisappear方法中remove掉UISearchBar……所以建议使用第二种添加方法）

    //CGRect mainViewBounds = self.navigationController.view.bounds;

    //self.searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(CGRectGetWidth(mainViewBounds)/2-((CGRectGetWidth(mainViewBounds)-120)/2), CGRectGetMinY(mainViewBounds)+28, CGRectGetWidth(mainViewBounds)-120, 30)];
    //添加到view中
    //[self.navigationController.view addSubview:self.searchBar];

    //添加方法二
    UIView *titleView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, XW-100, 30)];
    //UIColor *color =  self.navigationController.navigationBar.tintColor;
    //[titleView setBackgroundColor:color];
    self.searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, XW - 100, 30)];
    self.searchBar.placeholder = @"黝黑~又在写bug呢啊！！！";
    self.searchBar.layer.cornerRadius = 15;
    self.searchBar.layer.masksToBounds = YES;
    //设置背景图是为了去掉上下黑线
    self.searchBar.backgroundImage = [[UIImage alloc] init];
    //self.searchBar.backgroundImage = [UIImage imageNamed:@"sexBankgroundImage"];
    // 设置SearchBar的主题颜色
    //self.searchBar.barTintColor = [UIColor colorWithRed:111 green:212 blue:163 alpha:1];
    //设置背景色
    self.searchBar.backgroundColor = [UIColor colorWithRed:0/255.0f green:0/255.0f blue:0/255.0f alpha:0.1];
    // 修改cancel
    self.searchBar.showsCancelButton=NO;
    self.searchBar.barStyle=UIBarStyleDefault;
    self.searchBar.keyboardType=UIKeyboardTypeNamePhonePad;
    //self.searchBar.searchBarStyle = UISearchBarStyleMinimal;//没有背影，透明样式
    self.searchBar.delegate=self;
    // 修改cancel
    self.searchBar.showsSearchResultsButton=NO;
    //5. 设置搜索Icon
    [self.searchBar setImage:[UIImage imageNamed:@"Search_Icon"] forSearchBarIcon:UISearchBarIconSearch state:UIControlStateNormal];
    /*这段代码有个特别的地方就是通过KVC获得到UISearchBar的私有变量
     searchField（类型为UITextField），设置SearchBar的边框颜色和圆角实际上也就变成了设置searchField的边框颜色和圆角，你可以试试直接设置SearchBar.layer.borderColor和cornerRadius，会发现这样做是有问题的。*/
    //一下代码为修改placeholder字体的颜色和大小
    UITextField *searchField = [_searchBar valueForKey:@"searchField"];
    //2. 设置圆角和边框颜色
    if (searchField) {
        [searchField setBackgroundColor:[UIColor clearColor]];
        //searchField.layer.borderColor = [UIColor colorWithRed:49/255.0f green:193/255.0f blue:123/255.0f alpha:1].CGColor;
        //searchField.layer.borderWidth = 1;
        //searchField.layer.cornerRadius = 23.0f;
        //searchField.layer.masksToBounds = YES;
        // 根据@"_placeholderLabel.textColor" 找到placeholder的字体颜色
        [searchField setValue:[UIColor colorWithRed:200/255.0f green:200/255.0f blue:200/255.0f alpha:1] forKeyPath:@"placeholderLabel.textColor"];
    }
    // 输入文本颜色
    searchField.textColor= [UIColor whiteColor];
    searchField.font= [UIFont systemFontOfSize:15];
    // 默认文本大小
    [searchField setValue:[UIFont boldSystemFontOfSize:13] forKeyPath:@"placeholderLabel.font"];
    //只有编辑时出现出现那个叉叉
    searchField.clearButtonMode = UITextFieldViewModeWhileEditing;
    [titleView addSubview:self.searchBar];
    //Set to titleView
    self.navigationItem.titleView = titleView;
}

@end
