// 主  view

#import "XYouthView.h"

#define BaseV_W ([[UIScreen mainScreen] bounds].size.width)
#define BaseV_H ([[UIScreen mainScreen] bounds].size.height)

@interface XYouthView ()
/// 蒙层View
@property (nonatomic, strong) UIView *backgroundView;
/// 弹出的基View 在这个view上 做事情 +内容
@property (nonatomic, strong) UIView *baseView;
/// 取消
@property (nonatomic, strong) UIButton *backBtn;
/// 继续
@property (nonatomic, strong) UIButton *keeponBtn;
/// 描述内容
@property (nonatomic, strong) UITextView *textView;
/// 安全图片
@property (nonatomic, strong) UIImageView *topImgView;
/// 标题
@property (nonatomic, strong) UILabel *titleName;

@end

@implementation XYouthView

#pragma mark ------

/// 预先创建一个弹出View
/// @param superView 创建在父试图上，可以为nil  为nil创建在window上
- (instancetype)initShowYouthAlertViewSuperView:(nullable UIView *)superView {
    
    if (self == [super init]) {
        // 创建UI
        [self createUISuperView:superView];
    }
    return self;
}


/// 创建UI
- (void)createUISuperView:(nullable UIView *)superView
{
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
        make.left.right.top.bottom.mas_equalTo(0);
    }];
    
    [self.baseView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.centerY.mas_equalTo(0);
        make.width.mas_equalTo(300);
        make.height.mas_equalTo(350);
    }];
    
    [self.baseView addSubview:self.backBtn];
    [self.backBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_equalTo(0);
        make.height.mas_equalTo(50);
    }];
    
    [self.baseView addSubview:self.keeponBtn];
    [self.keeponBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.bottom.mas_equalTo(self.backBtn.mas_top);
        make.height.mas_equalTo(50);
    }];
    
    [self.baseView addSubview:self.topImgView];
    [self.topImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.mas_equalTo(0);
        make.height.mas_equalTo(100);
    }];
    
    [self.baseView addSubview:self.titleName];
    [self.titleName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.topImgView.mas_bottom).offset(10);
        make.left.right.mas_equalTo(0);
    }];
    
    [self.baseView addSubview:self.textView];
    [self.textView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.right.mas_equalTo(-15);
        make.bottom.mas_equalTo(self.keeponBtn.mas_top);
        make.top.mas_equalTo(self.titleName.mas_bottom);
    }];
    
}

/// 隐藏View
- (void)hiddenAlertView
{
    // 动画处理
    [UIView animateWithDuration:0.3 animations:^{
        
    } completion:^(BOOL finished) {
        self.hidden = YES;
    }];
}
/// 展示View
- (void)showAlertView
{   // 动画处理
    self.hidden = NO;
    [UIView animateWithDuration:0.3 animations:^{
        
    } completion:^(BOOL finished) {
        
    }];
}

- (void)onKeeponBtnClick
{
    
}

- (void)onbackBtnClick
{
    [self hiddenAlertView];
}

#pragma mark ----- lazy
- (UILabel *)titleName
{
    if (!_titleName) {
        _titleName = [[UILabel alloc] init];
        _titleName.textColor = [UIColor blackColor];
        _titleName.font = [UIFont systemFontOfSize:18];
        _titleName.text = @"青少年模式";
        _titleName.textAlignment = NSTextAlignmentCenter;
        [_titleName setFont:[UIFont fontWithName:@"Helvetica-Bold" size:18]];
    }
    return _titleName;
}
- (UIImageView *)topImgView
{
    if (!_topImgView) {
        _topImgView = [[UIImageView alloc] init];
        _topImgView.image = [UIImage imageNamed:@"icon_heart_1"];
    }
    return _topImgView;
}
- (UITextView *)textView
{
    if (!_textView) {
        _textView = [[UITextView alloc] init];
        _textView.backgroundColor = [UIColor clearColor];
        _textView.textColor = [UIColor blackColor];
        _textView.font = [UIFont systemFontOfSize:18];
        _textView.text = @"为呵护未成年人健康成长，APP特别推出青少年模式，该模式下部分功能无法正常使用。请监护人主动选择，并设置监护密码。";
        _textView.textAlignment = NSTextAlignmentCenter;
        [_textView setEditable:NO];
        
        NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
        paragraphStyle.lineSpacing = 5;// 字体的行间距
        NSDictionary *attributes = @{NSFontAttributeName : [UIFont systemFontOfSize:18], NSParagraphStyleAttributeName : paragraphStyle};
        
        _textView.attributedText = [[NSAttributedString alloc] initWithString:_textView.text attributes:attributes];
    }
    return _textView;
}
- (UIButton *)keeponBtn
{
    if (!_keeponBtn) {
        _keeponBtn = [[UIButton alloc] init];
        [_keeponBtn addTarget:self action:@selector(onKeeponBtnClick) forControlEvents:(UIControlEventTouchUpInside)];
        [_keeponBtn setTitle:@"进入青少年模式 >" forState:(UIControlStateNormal)];
        [_keeponBtn setTitleColor:[UIColor grayColor] forState:(UIControlStateNormal)];
        _keeponBtn.titleLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:18];
    }
    return _keeponBtn;
}
- (UIButton *)backBtn
{
    if (!_backBtn) {
        _backBtn = [[UIButton alloc] init];
        [_backBtn addTarget:self action:@selector(onbackBtnClick) forControlEvents:(UIControlEventTouchUpInside)];
        [_backBtn setTitle:@"我知道了" forState:(UIControlStateNormal)];
        [_backBtn setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
        [_backBtn setBackgroundColor:[UIColor greenColor]];
        _backBtn.titleLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:18];//[UIFont systemFontOfSize:18];
    }
    return _backBtn;
}

- (UIView *)baseView {
    if (!_baseView) {
        _baseView = [[UIView alloc] init];
        _baseView.backgroundColor = [UIColor orangeColor];
        _baseView.layer.masksToBounds = YES;
        _baseView.layer.cornerRadius = 5;
        [self addSubview:_baseView];
    }
    return _baseView;
}

- (UIView *)backgroundView {
    if (!_backgroundView) {
        _backgroundView = [[UIView alloc] init];
        /*
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hiddenAlertView)];
        [_backgroundView addGestureRecognizer:tap];
        */
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
