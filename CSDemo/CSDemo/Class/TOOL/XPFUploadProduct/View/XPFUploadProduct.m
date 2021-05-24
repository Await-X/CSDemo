// 

#import "XPFUploadProduct.h"
// 存储 
#import "XPFStorageModel.h"
//
#import <Masonry.h>

#import "XPFTopHeadImgVideoView.h"
#import "XPFTopHeadImgView.h"

#import "XPFTopHeadTitleView.h"

#import "XPFAddRemarkView.h"

#import "XPFUploadProductCell.h"

#define VIEW_WIDTH  [UIScreen mainScreen].bounds.size.width
#define VIEW_HEIGHT [UIScreen mainScreen].bounds.size.height

static const CGFloat kTopHeadImgVideoViewMargin = 12.0;

@interface XPFUploadProduct ()
<
UITableViewDataSource,
UITableViewDelegate,
XPFTopHeadImgVideoDelegate,
XPFTopHeadImgDelegate
>
/// 底部 tableView
@property (nonatomic, strong) UITableView *tableView;
///
@property (nonatomic, strong) UIView *topBGView;

/// 商品类型
@property (nonatomic, strong) XPFTopHeadTitleView *topOneTitleView;
/// 图片/视频选择 标题
@property (nonatomic, strong) XPFTopHeadTitleView *topTwoTitleView;
/// 选择 图片 和 视频
@property (nonatomic, strong) XPFTopHeadImgVideoView *topHeadImgVideoView;
/// 商品标题
@property (nonatomic, strong) XPFTopHeadTitleView *topThreeTitleView;
/// 添加标题描述
@property (nonatomic, strong) XPFAddRemarkView *myTitle;
/// 商品描述标题
@property (nonatomic, strong) XPFTopHeadTitleView *topFourTitleView;
/// 添加商品描述
@property (nonatomic, strong) XPFAddRemarkView *myProductsDescribe;
/// 商品图片标题
@property (nonatomic, strong) XPFTopHeadTitleView *topFiveTitleView;
/// 选择商品图片
@property (nonatomic, strong) XPFTopHeadImgView *topHeadImgView;
/// 记录 选择图片 的高度
@property (nonatomic, assign) CGFloat TopHeadImgViewHh;
/// 记录 选择图片/视频 的高度
@property (nonatomic, assign) CGFloat TopHeadImgVideoViewHh;

/// 数组区域

/// 保存视频数组

/// 保存图片数组

/// 保存描述商品图片数组

/// 保存规格数组


@end

@implementation XPFUploadProduct

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self setTableView];
    }
    return self;
} 

#pragma mark ----- tableView

/// tab  view
- (void)setTableView
{
    [self addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.top.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.bottom.mas_equalTo(0);
    }];
    
    //
    self.topBGView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, VIEW_WIDTH, 450 + (VIEW_WIDTH/3 + kTopHeadImgVideoViewMargin)*2)];
    self.topBGView.backgroundColor = [UIColor clearColor];
    
    __weak __typeof(self)weakSelf = self;
    
    // 商品类型
    self.topOneTitleView = [[XPFTopHeadTitleView alloc] initWithFrame:CGRectMake(0, 0, VIEW_WIDTH, 50) mustImg:YES titleName:@"商品类型" type:(TitleType_View)];
    self.topOneTitleView.RBtnClickBlock = ^(NSInteger index) { NSLog(@" 选择 类型 ");
        [weakSelf.topOneTitleView x_modifySelectClassification:@"类型1类型1类型1类型1类型1"];
    };
    [self.topBGView addSubview:self.topOneTitleView];
    
    // 图片视频选择
    self.topTwoTitleView = [[XPFTopHeadTitleView alloc] initWithFrame:CGRectMake(0, 50, VIEW_WIDTH, 50) mustImg:YES titleName:@"选择图片/视频" type:(TitleType_None)];
    [self.topBGView addSubview:self.topTwoTitleView];
    //
    _topHeadImgVideoView = [[XPFTopHeadImgVideoView alloc] initWithFrame:CGRectMake(0, 100, VIEW_WIDTH, VIEW_WIDTH/3 + kTopHeadImgVideoViewMargin) SelectImgMax:5 SelectVideoMax:1];
    _topHeadImgVideoView.delegateImgVideo = self;
    [self.topBGView addSubview:_topHeadImgVideoView];
    
    // 商品标题标题
    self.topThreeTitleView = [[XPFTopHeadTitleView alloc] initWithFrame:CGRectMake(0, 100 + VIEW_WIDTH/3 + kTopHeadImgVideoViewMargin, VIEW_WIDTH, 50) mustImg:YES titleName:@"标题" type:(TitleType_None)];
    [self.topBGView addSubview:self.topThreeTitleView];
    
    // 商品标题描述
    self.myTitle = [[XPFAddRemarkView alloc] initWithFrame:CGRectMake(0, 150 + VIEW_WIDTH/3 + kTopHeadImgVideoViewMargin, VIEW_WIDTH, 50) LimitMaxWord:20 placeHolder:@"输入商品标题"];
    [self.topBGView addSubview:self.myTitle];
    
    // 商品描述标题
    self.topFourTitleView = [[XPFTopHeadTitleView alloc] initWithFrame:CGRectMake(0, 200 + VIEW_WIDTH/3 + kTopHeadImgVideoViewMargin, VIEW_WIDTH, 50) mustImg:YES titleName:@"商品描述" type:(TitleType_None)];
    [self.topBGView addSubview:self.topFourTitleView];
    
    // 商品描述
    self.myProductsDescribe = [[XPFAddRemarkView alloc] initWithFrame:CGRectMake(0, 250 + VIEW_WIDTH/3 + kTopHeadImgVideoViewMargin, VIEW_WIDTH, 150) LimitMaxWord:200 placeHolder:@"输入商品描述"];
    [self.topBGView addSubview:self.myProductsDescribe];
    
    // 描述图片标题
    self.topFiveTitleView = [[XPFTopHeadTitleView alloc] initWithFrame:CGRectMake(0, 400 + VIEW_WIDTH/3 + kTopHeadImgVideoViewMargin, VIEW_WIDTH, 50) mustImg:YES titleName:@"选择描述图片" type:(TitleType_None)];
    [self.topBGView addSubview:self.topFiveTitleView];
    
    //
    self.TopHeadImgVideoViewHh = 400 + VIEW_WIDTH/3 + kTopHeadImgVideoViewMargin + 50;
    
    // 描述图片
    self.topHeadImgView = [[XPFTopHeadImgView alloc] initWithFrame:CGRectMake(0, self.TopHeadImgVideoViewHh, VIEW_WIDTH, VIEW_WIDTH/3 + kTopHeadImgVideoViewMargin) SelectImgMax:6];
    self.topHeadImgView.delegateImg = self;
    [self.topBGView addSubview:self.topHeadImgView];
    
    // 记录 描述图片 选择区域的高度
    self.TopHeadImgViewHh = VIEW_WIDTH/3 + kTopHeadImgVideoViewMargin;
    
    _tableView.tableHeaderView = self.topBGView;
}


#pragma mark ----- XPFTopHeadImgView delegate
- (void)onTopHeadImgViewH:(CGFloat)frame
{
    self.topHeadImgView.frame  = CGRectMake(0, self.TopHeadImgVideoViewHh, VIEW_WIDTH, frame);
    self.TopHeadImgViewHh = frame;
    //
    self.topBGView.frame = CGRectMake(0, 0, VIEW_WIDTH, self.TopHeadImgVideoViewHh + self.TopHeadImgViewHh);
    
    [self.tableView reloadData];
}

- (void)onTopHeadImgAryS:(NSArray *)imgAry
{
    NSLog(@"==onTopHeadImgAryS==选择的图片个数==> %lu ", imgAry.count);
    if (imgAry.count > 0) {
        NSLog(@"==onTopHeadImgAryS==选择的图片=%lu=> %@", imgAry.count, imgAry);
    }
}

#pragma mark ----- XPFTopHeadImgVideoView delegate
- (void)onTopHeadImgVideoViewH:(CGFloat)frame
{
    /// 选择 图片 和 视频
    self.topHeadImgVideoView.frame = CGRectMake(0, 100, VIEW_WIDTH, frame);
    // 这里需要加 kTopHeadImgVideoViewMargin 的边距 优化
    CGFloat zzzz = frame + kTopHeadImgVideoViewMargin + 100;
    
    /// 商品标题
    self.topThreeTitleView.frame = CGRectMake(0, zzzz, VIEW_WIDTH, 50);
    /// 添加标题描述
    self.myTitle.frame = CGRectMake(0, zzzz + 50, VIEW_WIDTH, 50);
    /// 商品描述标题
    self.topFourTitleView.frame = CGRectMake(0, zzzz + 100, VIEW_WIDTH, 50);
    /// 添加商品描述
    self.myProductsDescribe.frame = CGRectMake(0, zzzz + 150, VIEW_WIDTH, 150);
    /// 商品图片标题
    self.topFiveTitleView.frame = CGRectMake(0, zzzz + 300, VIEW_WIDTH, 50);
    //
    self.TopHeadImgVideoViewHh = zzzz + 350;
    /// 选择商品图片
    self.topHeadImgView.frame = CGRectMake(0, self.TopHeadImgVideoViewHh, VIEW_WIDTH, self.TopHeadImgViewHh);
    //
    self.topBGView.frame = CGRectMake(0, 0, VIEW_WIDTH, zzzz + 350 + self.TopHeadImgViewHh);
    
    [self.tableView reloadData];
}

- (void)onTopHeadImgAry:(NSArray *)imgAry video:(NSArray *)videoAry
{
    NSLog(@"==onTopHeadImgAry==选择的图片或者视频个数==> %lu ", imgAry.count + videoAry.count);
    NSInteger index = imgAry.count + videoAry.count;
    if (index > 0) {
        NSLog(@"==onTopHeadImgAry==选择的视频=%lu=> %@", videoAry.count, videoAry);
        NSLog(@"==onTopHeadImgAry==选择的图片=%lu=> %@", imgAry.count, imgAry);
    }
}
#pragma mark ----- tableView
///
- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _tableView.backgroundColor  = [UIColor clearColor];
        _tableView.dataSource       = self;
        _tableView.delegate         = self;
        _tableView.separatorStyle   = UITableViewCellSeparatorStyleNone;
        _tableView.rowHeight        = 170;
    }
    return _tableView;
}

#pragma mark ----- tableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}
///
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    XPFUploadProductCell *cell = [XPFUploadProductCell cellWithTableView:tableView indexPath:indexPath];
    cell.backgroundColor = [UIColor xpf_randomColor];
    return cell;
}

///
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}


@end
