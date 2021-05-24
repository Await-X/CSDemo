// 

#import "XPFEjectBaseView.h"

#define BaseV_W               ([[UIScreen mainScreen] bounds].size.width)
#define BaseV_H               ([[UIScreen mainScreen] bounds].size.height)

@interface XPFEjectBaseView ()

// 弹出的基View
@property (nonatomic,strong) UIView *baseView;
// 蒙层View
@property (nonatomic,strong) UIView *backgroundView;
// 弹出的View高度
@property (nonatomic,assign) CGFloat baseHeight;

@end

@implementation XPFEjectBaseView

#pragma mark ------

/// 预先创建一个弹出View
/// @param superView 创建在父试图上，可以为nil  为nil创建在window上
- (instancetype)initShowAlertViewSuperView:(nullable UIView *)superView {
    
    if (self == [super init]) {
        // 创建UI
        [self createUISuperView:superView];
    }
    return self;
}


/// 创建UI
- (void)createUISuperView:(nullable UIView *)superView
{
    self.baseHeight = 400;//WidthScale750(588) + (XPF_StatusBarHeight > 20 ? 34 : 0);
    self.hidden = YES;
    if (superView)
    {
        [superView addSubview:self];
        [self mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(superView);
        }];
    }
    else
    {
        UIWindow *windows = [UIApplication sharedApplication].keyWindow;
        [windows addSubview:self];
        [self mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(windows);
        }];
    }
    
    [self.backgroundView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self);
    }];
    
    self.baseView.frame = CGRectMake(0, BaseV_H, BaseV_W, self.baseHeight);
    
    [self BezierPathWithRoundedRect:self.baseView RoundingCorners:UIRectCornerTopLeft | UIRectCornerTopRight CornerRadii:CGSizeMake(20, 20)];
}

/// 隐藏View
- (void)hiddenAlertView
{
    // 动画处理
    [UIView animateWithDuration:0.3 animations:^{
        self.baseView.frame = CGRectMake(0, BaseV_H, BaseV_W, self.baseHeight);
    } completion:^(BOOL finished) {
        self.hidden = YES;
    }];
}
/// 展示View
- (void)showAlertView
{   // 动画处理
    self.hidden = NO;
    [UIView animateWithDuration:0.3 animations:^{
        self.baseView.frame = CGRectMake(0, BaseV_H - self.baseHeight, BaseV_W, self.baseHeight);
    } completion:^(BOOL finished) {
        
    }];
}

#pragma mark ----- lazy

- (UIView *)baseView {
    if (!_baseView) {
        _baseView = [[UIView alloc] init];
        _baseView.backgroundColor = [UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:0.88];
        [self addSubview:_baseView];
    }
    return _baseView;
}

- (UIView *)backgroundView {
    if (!_backgroundView) {
        _backgroundView = [[UIView alloc] init];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hiddenAlertView)];
        [_backgroundView addGestureRecognizer:tap];
        [self addSubview:_backgroundView];
    }
    return _backgroundView;
}


#pragma mark ----- 扩展

/// 利用贝塞尔曲线添加指定位置圆角
/// @param view view
/// @param conrners 圆角位置
/// @param cornerRadii 圆角大小
- (void)BezierPathWithRoundedRect:(UIView *)view RoundingCorners:(UIRectCorner)conrners CornerRadii:(CGSize)cornerRadii{
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:view.bounds byRoundingCorners:conrners cornerRadii:cornerRadii];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = view.bounds;
    maskLayer.path = maskPath.CGPath;
    view.layer.mask = maskLayer;
}

// 渐变色
- (void)CAGradientLayerWithView:(UIView *)view {
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.colors = @[(__bridge id)[UIColor redColor].CGColor, (__bridge id)[UIColor orangeColor].CGColor];
    gradientLayer.frame = view.frame;
    gradientLayer.startPoint = CGPointMake(0, 0);
    gradientLayer.endPoint = CGPointMake(1.0, 0);
    [view.layer addSublayer:gradientLayer];
}


@end
