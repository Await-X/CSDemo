// 点赞 漂浮 的 UI

#import "XSpotLikeGoods.h"
#import "XHRollModel.h"
#import "UIView+Ext.h"
#import <UIImageView+WebCache.h>

@interface XSpotLikeGoods ()
#pragma mark ----- 横着 滚动 属性创建
/// 内容 横滑
@property (nonatomic, strong) UILabel *moneyHText;
/// 数量
@property (nonatomic, strong) UILabel *moneyHNb;
/// 图片
@property (nonatomic, strong) UIImageView *moneyHimg;
/// 承载 背景图片
@property (nonatomic, strong) UIView *moneyHbgView;
/// 横着 当前是否执行动画
@property (nonatomic, assign) BOOL isHBool;
/// 记录 要滚动的 数据
@property (nonatomic, strong) NSMutableArray *bulletData;

#pragma mark ----- 竖着 滚动 属性创建
/// 图片
@property (nonatomic, strong) UIImageView *moneySImg;
/// 额度
@property (nonatomic, strong) UILabel *moneySText;
/// 承载 内容 的 view
@property (nonatomic, strong) UIView *moneySView;
/// 当前是否执行动画
@property (nonatomic, assign) BOOL isSBool;

@end

@implementation XSpotLikeGoods

- (instancetype)initWithFrame:(CGRect)frame directionType:(directionType)type
{
    self = [super initWithFrame:frame];
    if (self) {
        switch (type) {
            case directionType_H: {
                [self addSubContViewHHHHHUI];
            } break;
            case directionType_S: {
                [self addSubContViewSSSSSUI];
            } break;
                
            default: {
                self.hidden = YES;
            } break;
        }
    }
    return self;
}

#pragma mark ----- S 横着 滚动

#pragma mark ----- add UI
- (void)addSubContViewHHHHHUI
{
    self.isHBool = YES;
    
    // 文字
    self.moneyHText.frame = CGRectMake(0, 0, 100, self.frame.size.height);
    [self.moneyHbgView addSubview:self.moneyHText];
    
    /// 图片
    CGFloat Hhh = 24.0;
    CGFloat Yyy = self.frame.size.height/2 - Hhh/2;
    self.moneyHimg.frame = CGRectMake(self.moneyHText.x + self.moneyHText.width, Yyy, Hhh, Hhh);
    [self.moneyHbgView addSubview:self.moneyHimg];
    
    /// 数量
    self.moneyHNb.frame = CGRectMake(self.moneyHimg.x + self.moneyHimg.width, 0, 20, self.frame.size.height);
    [self.moneyHbgView addSubview:self.moneyHNb];
    
    //
    CGRect rectBGview = CGRectMake(self.frame.size.width / 2, self.moneyHText.y, self.moneyHText.width + self.moneyHimg.width + self.moneyHNb.width, self.frame.size.height);
    self.moneyHbgView.frame = rectBGview;
    [self addSubview:self.moneyHbgView];
}

/**
 *  添加把数据数组
 *  name
 *  typeName 点赞 金豆 金币 钱 ...
 *  typeImg 图片 地址
 *  numbers 获得数量
 */
- (void)addHDataName:(NSString *)name type:(NSString *)typeName typeImg:(NSString *)typeImg number:(NSString *)numbers
{
    // 
    NSString *textStr = [NSString stringWithFormat:@"%@获得%@个%@", name, numbers, typeName];
    NSMutableAttributedString *absStr = [[NSMutableAttributedString alloc] initWithString:textStr];
    //
    UIImage *image = [UIImage imageNamed:typeImg];
    //
    NSTextAttachment *attach = [[NSTextAttachment alloc] init];
    attach.image = image;
    //
    CGFloat height = [textStr sizeWithAttributes:@{NSFontAttributeName : [UIFont systemFontOfSize:10]}].height;
    //
    CGFloat widthStr = [textStr sizeWithAttributes:@{NSFontAttributeName : [UIFont systemFontOfSize:10]}].width + height + 20;
    //
    CGFloat numberwidths = [numbers sizeWithAttributes:@{NSFontAttributeName : [UIFont systemFontOfSize:10]}].width + 20;
    //
    CGFloat typeImgwidths = 24.0;
    
    attach.bounds = CGRectMake(0, 0, height, height);
    
    //设置不同字体颜色
    [absStr addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithHexString:@"#FBB905"] range:NSMakeRange(absStr.length - typeName.length, typeName.length)];
    
    // 存储 model
    
    XHRollModel *rollModel = [[XHRollModel alloc] init];
    rollModel.name = name;
    rollModel.typeName = typeName;
    rollModel.typeImg = typeImg;
    rollModel.numbers = numbers;
    rollModel.widths = widthStr;
    rollModel.attributedtexts = absStr;
    rollModel.numberwidths = numberwidths;
    rollModel.typeImgwidths = typeImgwidths;
    
    [self.bulletData addObject:rollModel];
    //
    [self showHStartPlayDuration:0];
}

#pragma mark ----- 横着开始播放滚动
/// 开始播放滚动 duration 持续时间 固定3秒 可扩展
- (void)showHStartPlayDuration:(NSInteger)duration
{
    if (self.bulletData.count != 0)
    {
        if (self.isHBool)
        {
            //
            duration = 2;
            // 隐藏掉/显示
            // 记得先要复位
            XHRollModel *rollModel = [self.bulletData firstObject];
            CGFloat WWw = rollModel.widths;
            CGFloat HHh = self.frame.size.height;
            self.moneyHText.attributedText = rollModel.attributedtexts;
            self.moneyHText.frame = CGRectMake(0, 0, WWw, HHh);
            //
            CGFloat Hhhimg = rollModel.typeImgwidths;
            CGFloat Yyyimg = self.frame.size.height/2 - Hhhimg/2;
            self.moneyHimg.frame = CGRectMake(self.moneyHText.x + self.moneyHText.width, Yyyimg, Hhhimg, Hhhimg);
            [self.moneyHimg sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@", rollModel.typeImg]] placeholderImage:YGIMGName(@"icon_heart_1")];
            CGFloat nbWww = rollModel.numberwidths;
            self.moneyHNb.text = rollModel.numbers;
            self.moneyHNb.frame = CGRectMake(self.moneyHimg.x + self.moneyHimg.width, 0, nbWww, self.frame.size.height);
            //
            self.moneyHbgView.frame = CGRectMake(SW, 0, WWw + Hhhimg + nbWww, self.frame.size.height);
            //
            [UIView animateWithDuration:duration delay:0 options:UIViewAnimationOptionCurveLinear animations: ^{
                //
                [self.moneyHbgView setAlpha:0.8];
                [self.moneyHimg setAlpha:1.0];
                CGPoint center = self.moneyHbgView.center;
                center.x -= SW + WWw; // 方向
                self.moneyHbgView.center = center;
                //
                self.isHBool = NO;
                
            } completion:^(BOOL finished) {
                [self.moneyHbgView setAlpha:0.8];
                [self.moneyHimg setAlpha:1.0];
                // 隐藏掉/显示
                // 记得要复位
                self.moneyHbgView.frame = CGRectMake(SW, 0, WWw + Hhhimg + nbWww, self.frame.size.height);
                //
                self.isHBool = YES;
                //
                if (self.bulletData.count > 0)
                {
                    [self.bulletData removeObjectAtIndex:0];
                    //
                    [self showHStartPlayDuration:0];
                }
            }];
        }
    }
}

#pragma mark ----- 懒加载
- (UIView *)moneyHbgView
{
    if (!_moneyHbgView) {
        _moneyHbgView = [[UIView alloc] init];
        _moneyHbgView.layer.cornerRadius = self.frame.size.height / 2;
        _moneyHbgView.layer.borderWidth = 1.0;
        _moneyHbgView.layer.borderColor = [[UIColor colorWithHexString:@"#FFFFFF"] CGColor];
        _moneyHbgView.backgroundColor = [UIColor colorWithHexString:@"#292929"];
        _moneyHbgView.alpha = 0.5;
    }
    return _moneyHbgView;
}
- (UILabel *)moneyHText
{
    if (!_moneyHText) {
        _moneyHText = [[UILabel alloc] init];
        _moneyHText.font = [UIFont systemFontOfSize:10];
        _moneyHText.textAlignment = NSTextAlignmentCenter;
        _moneyHText.textColor = [UIColor whiteColor];
    }
    return _moneyHText;
}

/// 图片
- (UIImageView *)moneyHimg
{
    if (!_moneyHimg) {
        _moneyHimg = [[UIImageView alloc] init];
        _moneyHimg.image = YGIMGName(@"icon_heart_3");
    }
    return _moneyHimg;
}

/// 数量
- (UILabel *)moneyHNb
{
    if (!_moneyHNb) {
        _moneyHNb = [[UILabel alloc] init];
        _moneyHNb.textColor = [UIColor colorWithHexString:@"#FBB905"];
        _moneyHNb.font = [UIFont systemFontOfSize:10];
        _moneyHNb.textAlignment = NSTextAlignmentCenter;
    }
    return _moneyHNb;
}

- (NSMutableArray *)bulletData
{
    if (!_bulletData) {
        _bulletData = [NSMutableArray array];
    }
    return _bulletData;
}






#pragma mark /////////////////////////////////////

#pragma mark ----- S 竖着 滚动

#pragma mark ----- add UI
- (void)addSubContViewSSSSSUI
{
    //
    self.isSBool = YES;
    /// 承载 内容 的 view
    CGFloat moneyVHh = 44.0;
    CGFloat contViewYy = self.frame.size.height - moneyVHh;
    CGFloat contViewWw = self.frame.size.width;
    
    self.moneySView.frame = CGRectMake(0, contViewYy, contViewWw, moneyVHh);
    [self addSubview:self.moneySView];
    /// 图片
    self.moneySImg.frame = CGRectMake(0, 0, moneyVHh, moneyVHh);
    [self.moneySView addSubview:self.moneySImg];
    /// 额度
    self.moneySText.frame = CGRectMake(moneyVHh, 0, contViewWw - moneyVHh, moneyVHh);
    [self.moneySView addSubview:self.moneySText];
    
}

#pragma mark ----- 开始播放滚动
- (void)showSStartPlayDuration:(NSInteger)duration
{
    if (self.isSBool)
    {
        //
        duration = 2;
        // 隐藏掉/显示
        [self onHiddenUI:NO];
        // 记得先要复位
        CGFloat H44 = 44.0;
        CGFloat moneyH_44 = self.frame.size.height - H44;
        self.moneySView.frame = CGRectMake(0, moneyH_44, self.frame.size.width, H44);
        //
        [UIView animateWithDuration:duration delay:0 options:UIViewAnimationOptionCurveLinear animations: ^{
            CGPoint center = self.moneySView.center;
            center.y -= moneyH_44;
            self.moneySView.center = center;
            [self.moneySView setAlpha:0.5];
            self.isSBool = NO;
        } completion:^(BOOL finished) {
            [self.moneySView setAlpha:1.0];
            // 隐藏掉/显示
            [self onHiddenUI:YES];
            // 记得要复位
            self.moneySView.frame = CGRectMake(0, moneyH_44, self.frame.size.width, H44);
            self.isSBool = YES;
        }];
    }
}

#pragma mark ----- set 懒加载
- (void)setShowTypeImg:(showImgType)showTypeImg
{
    switch (showTypeImg) {
        case showImgType_Golds: {
            self.moneySImg.image = YGIMGName(@"icon_heart_3");
            
        } break;
        case showImgType_Beans: {
            self.moneySImg.image = YGIMGName(@"icon_heart_3");
            
        } break;
        case showImgType_Money: {
            self.moneySImg.image = YGIMGName(@"icon_heart_3");
            
        } break;
            
        default: {
        } break;
    }
}
- (void)setShowImg:(NSString *)showImg
{
    if (showImg)
    {
        // 金豆
        self.moneySImg.image = YGIMGName(@"icon_heart_3");
        //self.moneySImg sd
        
        // 钱
        
        // 币
    }
}

- (void)setShowMoney:(NSString *)showMoney
{
    _showMoney = showMoney;
    //
    self.moneySText.text = showMoney;
    
}

/// 显示 隐藏
- (void)onHiddenUI:(BOOL)ishes
{
    self.moneySView.hidden = ishes;
}

/// 图片
- (UIImageView *)moneySImg
{
    if (!_moneySImg) {
        _moneySImg = [[UIImageView alloc] init];
    }
    return _moneySImg;
}
/// 额度
- (UILabel *)moneySText
{
    if (!_moneySText) {
        _moneySText = [[UILabel alloc] init];
        _moneySText.textAlignment = NSTextAlignmentCenter;
    }
    return _moneySText;
}

/// 承载 内容 的 view
- (UIView *)moneySView
{
    if (!_moneySView) {
        _moneySView = [[UIView alloc] init];
        //[self onHiddenUI:YES];
    }
    return _moneySView;
}

@end
