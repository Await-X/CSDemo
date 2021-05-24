//

#import "XPFTopHeadTitleView.h"

#import <Masonry.h>

#define VIEW_WIDTH  [UIScreen mainScreen].bounds.size.width
#define VIEW_HEIGHT [UIScreen mainScreen].bounds.size.height

@interface XPFTopHeadTitleView ()

/// 必选/选选 图片
@property (nonatomic, strong) UIImageView *imgViewMust;
/// 标题
@property (nonatomic, strong) UILabel *titleName;

/// 选择填写的内容
@property (nonatomic, strong) UIButton *contBtn;
/// 箭头
@property (nonatomic, strong) UIImageView *imgViewArrow;

@end

@implementation XPFTopHeadTitleView

/*
  需求
    第一种 右侧 没有内容
    第二种 右侧 可以点击 并且修改 右侧分类内容
    第三种 左侧 有个星号 必填 和选填的图片
*/

/// whether（左侧有个星号必填/选填的图片) type（第一种右侧没有内容，第二种右侧可以点击并且修改右侧分类内容）
- (instancetype)initWithFrame:(CGRect)frame mustImg:(BOOL)whether titleName:(NSString *)titleStr type:(TitleType)type
{
    self = [super initWithFrame:frame];
    if (self) {
        //
        switch (type) {
            case TitleType_None: {
                [self setActionNothingOnTheRightUImustImg:whether titleName:titleStr];
            } break;
            case TitleType_View: {
                [self setActionContentOnTheRightUImustImg:whether titleName:titleStr];
            } break;
                
            default:
                break;
        }
    }
    return self;
}

#pragma mark ----- 第一种 右侧没有内容 / (BOOL)whether 左侧 有个星号 必填 和选填的图片
- (void)setActionNothingOnTheRightUImustImg:(BOOL)whether titleName:(NSString *)titleStr
{
    self.imgViewMust = [[UIImageView alloc] init];
    [self addSubview:self.imgViewMust];
    [self.imgViewMust mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(0);
        make.left.mas_equalTo(15);
        make.width.height.mas_equalTo(20);
    }];
    if (whether) { // 有图片
        self.imgViewMust.image = [UIImage imageNamed:@"lufei"];
    } else { // 不加图片
        self.imgViewMust.image = [UIImage imageNamed:@""];
    }
    
    self.titleName = [[UILabel alloc] init];
    [self addSubview:self.titleName];
    [self.titleName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(0);
        make.left.mas_equalTo(self.imgViewMust.mas_right).offset(3);
    }];
    self.titleName.text = titleStr;
    self.titleName.font = [UIFont systemFontOfSize:14.0];
    self.titleName.textColor = [UIColor blackColor];
    
}
#pragma mark ----- 第二种 右侧可以点击并且修改右侧分类内容 / (BOOL)whether 左侧 有个星号 必填 和选填的图片
- (void)setActionContentOnTheRightUImustImg:(BOOL)whether titleName:(NSString *)titleStr
{
    self.imgViewMust = [[UIImageView alloc] init];
    [self addSubview:self.imgViewMust];
    [self.imgViewMust mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(0);
        make.left.mas_equalTo(15);
        make.width.height.mas_equalTo(20);
    }];
    if (whether) { // 有图片
        self.imgViewMust.image = [UIImage imageNamed:@"lufei"];
    } else { // 不加图片
        self.imgViewMust.image = [UIImage imageNamed:@""];
    }
    
    self.titleName = [[UILabel alloc] init];
    [self addSubview:self.titleName];
    [self.titleName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(0);
        make.left.mas_equalTo(self.imgViewMust.mas_right).offset(3);
    }];
    self.titleName.text = titleStr;
    self.titleName.font = [UIFont systemFontOfSize:14.0];
    self.titleName.textColor = [UIColor blackColor];
    
    //
    self.imgViewArrow = [[UIImageView alloc] init];
    [self addSubview:self.imgViewArrow];
    [self.imgViewArrow mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(0);
        make.right.mas_equalTo(-15);
        make.width.height.mas_equalTo(25);
    }];
    self.imgViewArrow.image = [UIImage imageNamed:@"lufei"];
    
    self.contBtn = [[UIButton alloc] init];
    [self addSubview:self.contBtn];
    [self.contBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(0);
        make.right.mas_equalTo(self.imgViewArrow.mas_left).offset(-8);;
    }];
    [self.contBtn setTitle:@"选择分类" forState:(UIControlStateNormal)];
    self.contBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [self.contBtn setTitleColor:[UIColor blackColor] forState:(UIControlStateNormal)];
    [self.contBtn addTarget:self action:@selector(onActionContBtnClick:) forControlEvents:(UIControlEventTouchUpInside)];
}

- (void)onActionContBtnClick:(UIButton *)button
{
    if (self.RBtnClickBlock) {
        self.RBtnClickBlock(0);
    }
}
/// 切换选中的分类
- (void)x_modifySelectClassification:(NSString *)select
{
    [self.contBtn setTitle:select forState:(UIControlStateNormal)];
}

@end
