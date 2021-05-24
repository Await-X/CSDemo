//

#import "LuckDraw.h"
//#import "UIView+XPFViewFillet.h"
//#import "DrawFanPicturaView.h"
//#import "GBAnimationRoundView.h"
#import "xpfview.h"

@interface LuckDraw ()
<
CAAnimationDelegate
>

@property (nonatomic, strong) UIImageView *bgImageView;

@property (nonatomic, assign) BOOL isAnimation;

@property (nonatomic, assign) CGFloat circleAngle;
/// 点击某一个奖品取奖品信息
@property (nonatomic, assign) NSInteger takeindex;
/// 数据
@property (nonatomic, strong) NSMutableArray *prizeArray;
/// 数据 变动
@property (nonatomic, strong) NSMutableArray *prizeArrayChange;
/// 变动处理 点击同一个
@property (nonatomic, assign) NSInteger istakeindex;

@end

@implementation LuckDraw

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initView];
    
    NSLog(@" ====> %f", sqrt(4)); // ====> 2.000000
    
}

#pragma mark ----- 初始化View
- (void)initView
{
    // 底部图片
    UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 200, 320, 320)];
    imgView.center = self.view.center; // 居中
    imgView.backgroundColor = [UIColor orangeColor];
    imgView.layer.masksToBounds = YES;
    imgView.layer.cornerRadius = 320 / 2;
    [self.view addSubview:imgView];
    
    //转盘背景
    _bgImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 200, 300, 300)];
    _bgImageView.center = self.view.center; // 居中
    _bgImageView.image = [UIImage imageNamed:@"lufei"];
    //_bgImageView.backgroundColor = [UIColor redColor];
    _bgImageView.layer.masksToBounds = YES;
    _bgImageView.layer.cornerRadius = 300 / 2;
    [self.view addSubview:_bgImageView];
    
    //添加GO按钮图片
    UIImageView *btnimage = [[UIImageView alloc]initWithFrame:CGRectMake(self.view.bounds.size.width/2-50, self.view.bounds.size.height/2-50, 100, 100)];
    btnimage.image = [UIImage imageNamed:@"delete"];
    [self.view addSubview:btnimage];
    
    _bgImageView.userInteractionEnabled = YES;
    btnimage.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(btnClick)];
    [btnimage addGestureRecognizer:tap];
    
    //添加文字
    _prizeArray = [NSMutableArray arrayWithObjects:@"谢谢参与", @"一等奖", @"谢谢参与", @"二等奖", @"谢谢参与", @"三等奖", @"谢谢参与", @"特等奖", nil];
    _prizeArrayChange = [NSMutableArray arrayWithObjects:@"谢谢参与", @"一等奖", @"谢谢参与", @"二等奖", @"谢谢参与", @"三等奖", @"谢谢参与", @"特等奖", nil];
    NSInteger Cot = _prizeArray.count;
    for (int i = 0; i < Cot; i ++) {
        CGFloat www = (CGRectGetHeight(_bgImageView.frame)/2)*(CGRectGetHeight(_bgImageView.frame)/2) + (CGRectGetHeight(_bgImageView.frame)/2)*(CGRectGetHeight(_bgImageView.frame)/2);
        
        CGFloat ccccc = M_PI * sqrt(www)*2;
        NSLog(@" ===== %f, %f, %f, %f, %f, %f", ccccc, ccccc/Cot, sqrt(www), www, sqrt(www)*2, CGRectGetHeight(_bgImageView.frame));
        
        // sqrt(www)*2 直径 sqrt(www) 半径
        
        CGFloat kh = sqrt(www) - CGRectGetHeight(_bgImageView.frame)/2;
        CGFloat CK2 = kh * kh + (CGRectGetHeight(_bgImageView.frame)/2)*(CGRectGetHeight(_bgImageView.frame)/2);
        CGFloat Ck = sqrt(CK2);
        CGFloat Cm = Ck / 2;
        CGFloat Mo2 = sqrt(www)*sqrt(www) - Cm*Cm;
        CGFloat Mo = sqrt(Mo2);
        CGFloat titleY = sqrt(www) - CGRectGetHeight(_bgImageView.frame)/2;
        //NSLog(@"=m=?===> %f, %f, %f, %f, %f, %f, %f", kh, CK2, Ck, Cm, Mo2, Mo, sqrt(www));
        xpfview *bgView = [[xpfview alloc] initWithFrame:CGRectMake(0, 0, Ck, Mo) index:i]; // *3/5
        bgView.backgroundColor = [UIColor clearColor];
        bgView.layer.anchorPoint = CGPointMake(0.5, 1.0);
        bgView.center = CGPointMake(CGRectGetHeight(_bgImageView.frame)/2, CGRectGetHeight(_bgImageView.frame)/2);
        
        CGFloat angle = M_PI*2/Cot * i;
        bgView.transform = CGAffineTransformMakeRotation(angle);
        //UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0,M_PI * CGRectGetHeight(_bgImageView.frame)/Cot,CGRectGetHeight(_bgImageView.frame)*3/5)];
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, titleY, bgView.bounds.size.width, 20)];
        //label.layer.anchorPoint = CGPointMake(0.5, 1.0);
        //label.center = CGPointMake(CGRectGetHeight(_bgImageView.frame)/2, CGRectGetHeight(_bgImageView.frame)/2);
        label.text = [NSString stringWithFormat:@"%@", _prizeArray[i]];
        label.textColor = [UIColor whiteColor];
        label.backgroundColor = [UIColor clearColor];
        label.textAlignment = NSTextAlignmentCenter;
        label.font = [UIFont boldSystemFontOfSize:14];
        //CGFloat angle = M_PI*2/Cot * i;
        //label.transform = CGAffineTransformMakeRotation(angle);
        [bgView addSubview:label];
        
        CGFloat prizeWh = 30;
        CGFloat prizex = bgView.bounds.size.width/2 - prizeWh/2;
        CGFloat prizey = titleY + 20 + 5;
        //
        UIImageView *prizeImg = [[UIImageView alloc] initWithFrame:CGRectMake(prizex, prizey, prizeWh, prizeWh)];
        prizeImg.image = [UIImage imageNamed:@"delete"];
        prizeImg.userInteractionEnabled = YES;
        [bgView addSubview:prizeImg];
        
        UIButton *prizeBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, prizeImg.bounds.size.width, prizeImg.bounds.size.height)];
        prizeBtn.tag = 10020 + i;
        [prizeBtn addTarget:self action:@selector(onActionPrize:) forControlEvents:(UIControlEventTouchUpInside)];
        [prizeImg addSubview:prizeBtn];
        
        bgView.tag = 10020 + i;
        label.tag = 10020 + i;
        [_bgImageView addSubview:bgView];
    }
}

- (void)onActionPrize:(UIButton *)button
{
//    if (self.istakeindex == self.takeindex) {
//        [self onExchange:self.takeindex];
//        self.istakeindex ++;
//    }
    NSInteger index = button.tag - 10020;
    NSLog(@" ======> %ld, %@, %@", button.tag, self.prizeArrayChange[index], self.prizeArrayChange);
}

#pragma mark ----- 处理数组数据
- (void)onExchange:(NSInteger)index
{
    if (index == 0) {
        return;
    }
    
    for (int i = 0; i < index; i++) {
        [self.prizeArrayChange insertObject:[self.prizeArrayChange lastObject] atIndex:0];
        [self.prizeArrayChange removeObjectAtIndex:self.prizeArrayChange.count-1];
    }
    
}

#pragma mark 点击Go按钮
- (void)btnClick
{
    NSLog(@"点击Go");
    //判断是否正在转
    if (_isAnimation) {
        return;
    }
    _isAnimation = YES;
    //控制概率[0, 80)
    NSInteger lotteryPro = arc4random()%80;
    //设置转圈的圈数
    NSInteger circleNum = 6;
    //i * i*(360/90);
    /*
     中奖 type = 每个奖的 012345...
     谢谢惠顾 几个 随机几个角度。这几个角度都是谢谢惠顾。
     停止动画的时候需要处理一下 角度 得的是什么奖项
     */
    if (lotteryPro < 10) {
        _circleAngle = 0;
        self.takeindex = 0;
    }else if (lotteryPro < 20){
        _circleAngle = 45;
        self.takeindex = 1;
    }else if (lotteryPro < 30){
        _circleAngle = 90;
        self.takeindex = 2;
    }else if (lotteryPro < 40){
        _circleAngle = 135;
        self.takeindex = 3;
    }else if (lotteryPro < 50){
        _circleAngle = 180;
        self.takeindex = 4;
    }else if (lotteryPro < 60){
        _circleAngle = 225;
        self.takeindex = 5;
    }else if (lotteryPro < 70){
        _circleAngle = 270;
        self.takeindex = 6;
    }else if (lotteryPro < 80){
        _circleAngle = 315;
        self.takeindex = 7;
    }
    
//    self.istakeindex = self.takeindex;
    if (self.istakeindex < 8) {
        self.istakeindex = self.istakeindex + self.takeindex;
    }
    else if (self.istakeindex >= 8)
    {
        self.istakeindex = self.istakeindex + self.takeindex - self.istakeindex;
    }
    [self onExchange:self.istakeindex];
    
    
    CGFloat perAngle = M_PI/180.0;
    
//    if (self.istakeindex == self.takeindex) {
//        [self onExchange:self.takeindex];
//        self.istakeindex ++;
//    }
    
    NSLog(@"turnAngle = %ld", (long)_circleAngle);
    
    CABasicAnimation *rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation"];
    rotationAnimation.toValue = [NSNumber numberWithFloat:_circleAngle * perAngle + 360 * perAngle * circleNum];
    rotationAnimation.duration = 3.0f;
    rotationAnimation.cumulative = YES;
    rotationAnimation.delegate = self;
    
    
    //由快变慢
    rotationAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    rotationAnimation.fillMode=kCAFillModeForwards;
    rotationAnimation.removedOnCompletion = NO;
    [_bgImageView.layer addAnimation:rotationAnimation forKey:@"rotationAnimation"];
    
}

#pragma mark 动画结束
- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {
    
    NSLog(@"动画停止");
    NSString *title;
    if (_circleAngle == 0) {
        title = @"谢谢参与!";
    }else if (_circleAngle == 45){
        title = @"恭喜你，获得特等奖！";
    }else if (_circleAngle == 90){
        title = @"谢谢参与!";
    }else if (_circleAngle == 135){
        title = @"恭喜你，获得三等奖！";
    }else if (_circleAngle == 180){
        title = @"谢谢参与!";
    }else if (_circleAngle == 225){
        title = @"恭喜你，获得二等奖！";
    }else if (_circleAngle == 270){
        title = @"谢谢参与!";
    }else if (_circleAngle == 315){
        title = @"恭喜你，获得一等奖！";
    }
    UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"温馨提示" message:title delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    [alert show];
    
    _isAnimation = NO;
    
}



@end
