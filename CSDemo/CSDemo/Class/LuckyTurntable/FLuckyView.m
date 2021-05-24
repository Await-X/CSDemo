// 底部view 承载

#import "FLuckyView.h"
#import "FSectorItem.h" //
#import "FItemModel.h"

@interface FLuckyView ()
<
CAAnimationDelegate
>
/// 按钮
@property (nonatomic, strong) UIButton *contStartBtn;
///
@property (nonatomic, strong) FSectorItem *itemView;
/// 判断 抽奖任务是否进行中
@property (nonatomic, assign) BOOL isAnimation;

@end

@implementation FLuckyView

- (instancetype)init {
    if (self = [super init]) {
        //
        [self onAddLampUI]; // 背景 跑马灯
        [self onTtemUI]; // item
        [self onAddGoUI]; // 抽奖 按钮
    }
    return self;
}

#pragma mark -- 生命周期方法  
- (void)didMoveToSuperview {
    [super didMoveToSuperview];
    // Tells the view that its superview changed.
    // 当view的父级视图更改的时候会调用此方法
}

/// 背景 跑马灯
- (void)onAddLampUI
{
    //
    UIImageView *lampimgView = [[UIImageView alloc] init];//WithFrame:CGRectMake(0, 0, RATIOA(310), RATIOA(310))
    [self addSubview:lampimgView];
    [lampimgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.centerY.mas_equalTo(0);
        make.width.height.mas_equalTo(RATIOA(336));
    }];
    lampimgView.center = self.center; // 居中
    lampimgView.image = [UIImage imageNamed:@"goodLucky_bg"];
    lampimgView.layer.masksToBounds = YES;
    lampimgView.layer.cornerRadius = RATIOA(336) / 2;
    
    UIImage *image1 = [[UIImage alloc] init];
    UIImage *image2 = [[UIImage alloc] init];
    image1 = [UIImage imageNamed:@"goodLucky_bg_1"];
    image2 = [UIImage imageNamed:@"goodLucky_bg_2"];
    
    NSArray *imagesArray = @[image1, image2];
    lampimgView.animationImages = imagesArray;
    lampimgView.animationDuration = 0.2;//[imagesArray count]
    lampimgView.animationRepeatCount = 100000000;//循环次数
    [lampimgView startAnimating];
}

/// item
- (void)onTtemUI
{
    //
    self.itemView = [[FSectorItem alloc] init];
    [self addSubview:self.itemView];
    [self.itemView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.centerY.mas_equalTo(0);
        make.width.height.mas_equalTo(RATIOA(300));
    }];
    self.itemView.radius = RATIOA(150);
    self.itemView.layer.cornerRadius = RATIOA(150);
    self.itemView.layer.masksToBounds = YES;
    self.itemView.backgroundColor = [UIColor whiteColor];
    NSMutableArray *itemMutAry = [NSMutableArray array];
    for (int i = 0; i < 8; i++) {
        FItemModel *model = [[FItemModel alloc] init];
        model.imgStr = @"icon_heart_3";
        model.textStr = [NSString stringWithFormat:@"很酷的一个小伙子-%d", i];
        [itemMutAry addObject:model];
    }
    self.itemView.itemAry = itemMutAry;//@[@"icon_heart_3", @"icon_heart_2", @"icon_heart_1", @"icon_heart_3", @"icon_heart_2", @"icon_heart_1", @"icon_heart_3", @"icon_heart_2", @"icon_heart_3", @"icon_heart_2"];
    
}

/// 抽奖 按钮
- (void)onAddGoUI
{
    
    [self addSubview:self.contStartBtn];
    [self.contStartBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.centerY.mas_equalTo(0);
        make.width.height.mas_equalTo(RATIOA(40));
    }];
    //[self.contStartBtn setBackgroundColor:[UIColor orangeColor]];
    self.contStartBtn.layer.masksToBounds = YES;
    self.contStartBtn.layer.cornerRadius = RATIOA(20);
    [self.contStartBtn setImage:[UIImage imageNamed:@"goodLucky_go"] forState:(UIControlStateNormal)];
    self.contStartBtn.imageView.contentMode = UIViewContentModeScaleAspectFill;
    [self.contStartBtn addTarget:self action:@selector(onActionClick) forControlEvents:(UIControlEventTouchUpInside)];
    
}

/// 按钮
- (UIButton *)contStartBtn
{
    if (!_contStartBtn) {
        _contStartBtn = [[UIButton alloc] init];
    }
    return _contStartBtn;
}

- (void)onActionClick
{
    XPFLog(@" -------- 开始 --------");
    //判断是否正在转
    if (_isAnimation)
    {
        return;
    }
    _isAnimation = YES;
    
    NSInteger turnsNum = 6; // 控制圈数
    NSInteger turnAngle = (8 - 7) * 360/8; // 8个奖项（0~7）指定某个中奖
    CGFloat perAngle = M_PI/180.0;
    CABasicAnimation *rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation"];
    rotationAnimation.toValue = [NSNumber numberWithFloat:turnAngle * perAngle + 360 * perAngle * turnsNum];
    rotationAnimation.duration = 3.0f;
    rotationAnimation.cumulative = YES;
    rotationAnimation.delegate = self;
    //由快变慢
    rotationAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    rotationAnimation.fillMode = kCAFillModeForwards;
    rotationAnimation.removedOnCompletion = NO;
    [self.itemView.layer addAnimation:rotationAnimation forKey:@"rotationAnimation"];
}

#pragma mark ----- 动画结束
- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {
    
    _isAnimation = NO;
}

@end
