// 

#import "HomeViewController.h"
#import "HomeCs2UIViewController.h"

#import "ZoomViewController.h"
//
#import "XPFUploadProductVC.h"
#import "XPFScanVC.h"
#import "LuckDraw.h"
#import <AVFoundation/AVFoundation.h> //音频视频框架
#import "XPFEjectBaseView.h"
#import "SearchVC.h"
#import <AuthenticationServices/AuthenticationServices.h>

#import <XModel/XModel.h>

#import "XPFPageControl.h"
#import "CarouselViewTool.h"
#import "SDCycleScrollView.h"

#import "XPFDarkMode.h"

#import "XSpotLikeGoods.h" //
#import <UIImageView+WebCache.h> //IImageView+WebCache
#import "SDWebImageManager.h" //导入头文件
 
#import "CSView.h" // 测试view

#import "XShareUI.h" // 分享 UI
#import "LiveView.h" //


#import "FDanmakuView.h"
#import "FDanmakuModel.h"

#import "XPFStrNil.h"

#import "FSectorItem.h" //

#import "YYWebImage.h"

@interface HomeViewController ()
<
AVAudioPlayerDelegate,
ASAuthorizationControllerDelegate, ASAuthorizationControllerPresentationContextProviding,
CarouselViewDelegate,
SDCycleScrollViewDelegate,
NTESLikeViewProtocol,
FDanmakuViewProtocol
>
//--ASAuthorizationControllerDelegate 处理数据回调
//--ASAuthorizationControllerPresentationContextProviding 设置上下文，管理视图弹出在哪里

@property (nonatomic, strong) FDanmakuView *danmakuView;

//音频播放器
@property (nonatomic, strong) AVAudioPlayer *player;
///
@property (nonatomic, strong) XPFEjectBaseView *jectView;

///
@property (nonatomic, strong) ASAuthorizationAppleIDButton *authorizationButton;

@property (nonatomic, strong) CarouselViewTool *bannerView;
@property (nonatomic, strong) SDCycleScrollView *cycleScrollerView;

///
@property (nonatomic, strong) XSpotLikeGoods *likeGoods_s;
@property (nonatomic, strong) XSpotLikeGoods *likeGoods_h;


@property (nonatomic, strong) LiveView *likeView;   //爱心视图

@property (nonatomic, strong) UIPageControl *pageControl; //

@end

@implementation HomeViewController

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    
//    FDanmakuModel *model1 = [[FDanmakuModel alloc]init];
//    model1.beginTime = 3;
//    model1.liveTime = 5;
//    model1.content = @"哈哈哈~😊🙂😎~~~";

//    FDanmakuModel *model2 = [[FDanmakuModel alloc]init];
//    model2.beginTime = 3;
//    model2.liveTime = 3;
//    model2.content = @"23322333";
    
    FDanmakuModel *model3 = [[FDanmakuModel alloc] init];
    model3.beginTime = 3;
    model3.liveTime = 5;
    model3.textTag = 10;
    model3.topImgTag = 10110;
    model3.imgUrl = @"https://www.yuange66.cn/assets/live/api/avatar/2/46.jpg";
    model3.beanNuber = @"x10";
    
    NSInteger indexarc = arc4random();
    
    model3.textid = [NSString stringWithFormat:@"%ld +", (long)indexarc];
    
    NSString *contStr = [NSString stringWithFormat:@"这条是第%ld条弹幕漂浮", (long)indexarc];
    model3.textStr = contStr;
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:contStr];
    model3.content = attributedString;
    [self.danmakuView.modelsArr addObject:model3];
    
}

- (NSTimeInterval)currentTime {
    static double time = 0;
    time += 0.1;
    return time;
}

/// 方便扩展
- (UIView *)danmakuViewWithModel:(FDanmakuModel *)model
{
    // 前后间距
    CGFloat Jjw = RATIOA(10);
    // 行高
    CGFloat hhhh = RATIOA(44);
    // 文本
    CGFloat textFontSize = 14;
    CGFloat wwwwwText = [XPFStrNil x_getSizeForLabString:model.textStr font:[UIFont systemFontOfSize:textFontSize] height:hhhh];
    // 数量
    CGFloat numberFontSize = 14;
    CGFloat wwwwwNumber = [XPFStrNil x_getSizeForLabString:model.beanNuber font:[UIFont systemFontOfSize:numberFontSize] height:hhhh];
    
    // 底部 view
    UIView *bgview = [[UIView alloc] init];
    bgview.backgroundColor = [UIColor clearColor];
    bgview.userInteractionEnabled = NO;
    bgview.frame = CGRectMake(0, 0, Jjw + wwwwwText + hhhh + wwwwwNumber + Jjw, hhhh);
    
    // 背景图片
    UIImage *bgimgname = [UIImage imageNamed:@"BulletChatBGimg"];
    //bgimgname = [bgimgname resizableImageWithCapInsets:UIEdgeInsetsMake(0, 50, 0, 50) resizingMode:UIImageResizingModeStretch];
    UIImageView *bgimgview = [[UIImageView alloc] init];
    bgimgview.image = bgimgname;
    [bgview addSubview:bgimgview];
    [bgimgview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.bottom.mas_equalTo(0);
        make.width.mas_equalTo(bgview);
    }];
    
    
    //
    UILabel *textLb = [[UILabel alloc] init];
    textLb.attributedText = model.content;
    textLb.textColor = [UIColor whiteColor];
    textLb.font = [UIFont systemFontOfSize:textFontSize];
    textLb.tag = model.textTag;
    [bgview addSubview:textLb];
    [textLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(Jjw);
        make.centerY.mas_equalTo(0);
        make.width.mas_equalTo(wwwwwText);
    }];
    
    //
    UIImageView *topimgView = [[UIImageView alloc] init];
    [topimgView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@", model.imgUrl]] placeholderImage:YGIMGName(@"icon_heart_2")];
    topimgView.tag = model.topImgTag;
    topimgView.contentMode = UIViewContentModeScaleAspectFill;
    [bgview addSubview:topimgView];
    [topimgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(textLb.mas_right).offset(hhhh/4);
        make.width.height.mas_equalTo(hhhh/2);
        make.centerY.mas_equalTo(0);
    }];
    
    //
    UILabel *lbNumber = [[UILabel alloc] init];
    lbNumber.textColor = [UIColor whiteColor];
    lbNumber.font = [UIFont systemFontOfSize:numberFontSize];
    lbNumber.text = model.beanNuber;
    [bgview addSubview:lbNumber];
    [lbNumber mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(topimgView.mas_right).offset(hhhh/4);
        make.width.mas_equalTo(wwwwwNumber);
        make.centerY.mas_equalTo(0);
    }];
    
    return bgview;
}

- (void)danmuViewDidClick:(UIView *)danmuView at:(CGPoint)point model:(FDanmakuModel *)model
{
    
    FDanmakuModel *modelsss = model;
    //NSArray *myView = [danmuView subviews];
    //NSLog(@" %@ \n %@ \n %@ \n %@ \n %@", danmuView, NSStringFromCGPoint(point), myView, model, modelsss.textid);
    
    XPFLog(@" ===> %@, %ld, %@", modelsss.textStr, (long)modelsss.textTag, modelsss.textid);
    /*
    for (UIView *view in myView)
    {
        if ([view isKindOfClass:[UIImageView class]])
        { // 根据类型判断
            UIImageView *imgView = [view viewWithTag:modelsss.textTag];
            XPFLog(@" 这里有一张图片 : %@", imgView);
        }
        if ([view isKindOfClass:[UILabel class]])
        { // 
            UILabel *labels = [view viewWithTag:modelsss.textTag];
            XPFLog(@" 这里有个label : %@", labels.text);
        }
    }
    */
}
 

- (void)addDanmakuUI
{
    
    UIImageView *imgview = [[UIImageView alloc] init];
    //imgview.image = [UIImage imageNamed:@"lufei"];
    
    NSURL *url = [NSURL URLWithString:@"http://source.yuange66.cn/FoVC064IWGHPKNr41p5SmuP2IVH9-imgW640"];
    
//    [SDWebImageDownloader.sharedDownloader setValue:@"text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,*/*;q=0.8" forHTTPHeaderField:@"Accept"];
    // 为何这个图片 显示不出来？
    
//    [imgview sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"lufei"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
//            //在这里输出下error
//        XPFLog(@" %@", error);
//    }];
    
    
//    imgview.yy_imageURL = url;
    
    // 可以显示
    //[imgview sd_setImageWithURL:[NSURL URLWithString:@"http://source.yuange66.cn/FhZPm85ZI-G0gXlnE84Ly1SgcGC_-imgW640"] placeholderImage:[UIImage imageNamed:@"lufei"]];
    
    [self.view addSubview:imgview];
    [imgview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.top.mas_equalTo(RATIO * 120);
        make.height.mas_equalTo(RATIO * 44 * 5);
    }];
    
    self.danmakuView = [[FDanmakuView alloc] init];
    self.danmakuView.delegate = self;
    self.danmakuView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:self.danmakuView];
    [self.danmakuView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.top.mas_equalTo(RATIO * 120);
        make.height.mas_equalTo(RATIO * 44 * 5);
    }];
    
    self.danmakuView.kDandaoCountSs = 4;
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"首页";
    
    self.view.backgroundColor = [UIColor grayColor];
    
    double ac = sin(45) * 100;
    double bc = sqrt(100*100 - ac*ac);
    double ab = sqrt(bc*bc + ac*ac);
    NSLog(@" ac => %f, bc => %f, ab => %f", ac, bc, ab);
    
    
    //
    [self addDanmakuUI];
    
//    FSectorItem *itemView = [[FSectorItem alloc] init];
//    [self.view addSubview:itemView];
//    [itemView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.bottom.mas_equalTo(RATIOA(-100));
//        make.width.height.mas_equalTo(RATIOA(100));
//        make.centerY.mas_equalTo(0);
//    }];
//    itemView.backgroundColor = [UIColor orangeColor];
    
    return;
    
    [self addPageControlUI];
    
    return;
    
    
    // 区域拉伸
    [self onAction_resizableImageWithCapInsets];
    
    return;
    
    [self.view addSubview:self.likeView];
    self.likeView.backgroundColor = [UIColor colorWithRed:(245 / 255.0) green:(245 / 255.0) blue:(248 / 255.0) alpha:1.0];
    [self.likeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-100.0);
        make.top.mas_equalTo(100.0);
        make.height.mas_equalTo(300.0);
        make.width.mas_equalTo(5.0 + 6.0 + 35.0);
    }];
    
    return;
    [self sendMesssg];
    
    return;
    
    [self addView];
    
    
    return;
    
    [self onAddShareUI];
    
    return;
    CSView *csv = [[CSView alloc] init];
    [self.view addSubview:csv];
    [csv mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(100);
        make.centerX.mas_equalTo(0);
        make.width.mas_equalTo(300);
        make.height.mas_equalTo(300);
    }];
    
    
    
    return;
    
    [self onaaaaaaaa];
    
    [self addIMG];
    [self onSubSLikeSpotGoods];
    [self onSubHLikeSpotGoods];
    
    return;
    // 数组排序
    // 定义一个数字数组
    NSArray *array = @[@(3),@(4),@(2),@(1)];
    // 对数组进行排序
    NSArray *result = [array sortedArrayUsingComparator:^NSComparisonResult(id _Nonnull obj1, id _Nonnull obj2) {
        XPFLog(@"%@~%@",obj1,obj2); // 3~4 2~1 3~1 3~2
        return [obj1 compare:obj2]; // 升序
    }];

    XPFLog(@"result=%@",result);
    
    // 数组排序
    // 定义一个数字数组
    NSArray *array2 = @[@(13),@(14),@(12),@(11)];
    // 对数组进行排序
    NSArray *result2 = [array2 sortedArrayUsingComparator:^NSComparisonResult(id _Nonnull obj1, id _Nonnull obj2) {
        XPFLog(@"%@~%@", obj1, obj2); // 3~4 2~1 3~1 3~2
        return [obj2 compare:obj1]; // 降序
    }];
    
    XPFLog(@"result= %@",result2);
    
    return;
    
    UILabel *title = [[UILabel alloc] init];
    [self.view addSubview:title];
    [title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(RATIO * 10);
        make.top.mas_equalTo(RATIO * 100);
        make.right.mas_equalTo(RATIO * -10);
        make.height.mas_equalTo(RATIO * 44);
    }];
    title.textColor = [UIColor orangeColor];
    
    NSString *ssssStr = @"这是一串字符串（100000032798）";
    NSMutableAttributedString *sssss = [[NSMutableAttributedString alloc] initWithString:ssssStr];
    NSRange aaa = [ssssStr rangeOfString:@"（"];
    NSString *str2 = [ssssStr substringFromIndex:aaa.location];//截取掉下标 之后的字符串
    XPFLog(@"===== %lu, ----- %lu, +++++ %lu", (unsigned long)aaa.location, (unsigned long)aaa.length, (unsigned long)str2.length);
    [sssss addAttribute:NSForegroundColorAttributeName value:[UIColor blueColor] range:NSMakeRange(aaa.location, str2.length)];
    
    
    title.attributedText = sssss;
    
//    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:@"Using NSAttributed String"];
//    [str addAttribute:NSForegroundColorAttributeName value:[UIColor blueColor] range:NSMakeRange(0,5)];
//    [str addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(6,12)];
//    [str addAttribute:NSForegroundColorAttributeName value:[UIColor greenColor] range:NSMakeRange(19,6)];
//    [str addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"Arial-BoldItalicMT" size:30.0] range:NSMakeRange(0, 5)];
//    [str addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"HelveticaNeue-Bold" size:30.0] range:NSMakeRange(6, 12)];
//    [str addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"Courier-BoldOblique" size:30.0] range:NSMakeRange(19, 6)];
//    self.titleLabel.attributedText = str;
    
    
    return;
    // 全局队列
    dispatch_queue_t globQueue = dispatch_get_global_queue(0, 0);
    __block int a = 0;
    while (a < 5) {
        dispatch_async(globQueue, ^{
            a++;
            XPFLog(@" 里面 ：%d", a);
        });
    }
    XPFLog(@" 外面 ：%d", a);
    
    // 遍历字体
    for (NSString *fontFamilyName in [UIFont familyNames]) {
        NSLog(@"family:'%@'",fontFamilyName);
        for(NSString *fontName in [UIFont fontNamesForFamilyName:fontFamilyName]) {
            NSLog(@"\t font:'%@'",fontName);
        }
        NSLog(@"---------------------------------------------");
    }
    
    UILabel *lable = [[UILabel alloc] initWithFrame:CGRectMake(50, 100, 200, 100)];
    lable.font = [UIFont fontWithName:@"FZKTK--GBK1-0" size:60];
    lable.text = @"华文行楷";
    [lable sizeToFit];
    [self.view addSubview:lable];
    
    UILabel *lable22 = [[UILabel alloc] initWithFrame:CGRectMake(50, 200, 200, 100)];
    lable22.font = [UIFont systemFontOfSize:30];
    lable22.text = @"华文行楷";
    [lable22 sizeToFit];
    [self.view addSubview:lable22];
    
    
    
    
    [self on_addBtn];
    
    
    
    [self onAddDarkBtnUI];
    
    
    _cycleScrollerView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(10, 200, 300, 200) delegate:self placeholderImage:[UIImage imageNamed:@""]];
    [self.view addSubview:_cycleScrollerView];
    
    /** 网络图片 url string 数组 */
    //_cycleScrollerView.imageURLStringsGroup = ;
    
     /** 本地图片数组 */
    _cycleScrollerView.localizationImageNamesGroup = @[@"lufei", @"lufei", @"lufei"];

    /** 当前分页控件小圆标颜色 */
    _cycleScrollerView.currentPageDotColor = [UIColor redColor];

    /** 其他分页控件小圆标颜色 */
    _cycleScrollerView.pageDotColor = [UIColor orangeColor];

    /** 当前分页控件小圆标图片 */
    _cycleScrollerView.currentPageDotImage = [UIImage imageNamed:@"bannerPageiconSelect"];

    /** 其他分页控件小圆标图片 */
    _cycleScrollerView.pageDotImage = [UIImage imageNamed:@"bannerPageicon"];
    
    /** 占位图，用于网络未加载到图片时 */
    _cycleScrollerView.placeholderImage = [UIImage imageNamed:@"icon_heart_1"];
    
    /** 分页控件小圆标大小 */
    //_cycleScrollerView.pageControlDotSize = CGSizeMake(8, 5);

    /** 自动滚动间隔时间,默认2s */
    _cycleScrollerView.autoScrollTimeInterval = 2.;// 自动滚动时间间隔

    /** 分页控件位置 */
    _cycleScrollerView.pageControlAliment = SDCycleScrollViewPageContolAlimentRight;

    /** 轮播文字label背景颜色 */
    _cycleScrollerView.titleLabelBackgroundColor = [UIColor clearColor];// 图片对应的标题的 背景色。（因为没有设标题）

    // ok xib 自动布局都可以。还是很不错的。
    /** 清除图片缓存（此次升级后统一使用SDWebImage管理图片加载和缓存）  */
    [SDCycleScrollView clearImagesCache];// 清除缓存。

    
    
    return;

    NSInteger index1 = 6;
    NSInteger index2 = 9;
    if (index1 == 6 || index2 == 9)
    {
        XPFLog(@" ||||||||||||");
    }
    if (index1 == 6 || index2 == 6)
    {
        XPFLog(@" |||||||||||| bu");
    }
    if (index1 == 6 && index2 == 9)
    {
        XPFLog(@" &&&&&&&&&&&&");
    }
    if (index1 == 9 && index2 == 9)
    {
        XPFLog(@" &&&&&&&&&&&& bu");
    }
    
    
    return;
    
    [self.view addSubview:self.bannerView];
    [self.bannerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15*RATIO);
        make.right.mas_equalTo(-15*RATIO);
        make.top.mas_equalTo(100);
        make.height.mas_equalTo(200);
    }];
    self.bannerView.backgroundColor = [UIColor orangeColor];
    self.bannerView.images = @[
@"https://gimg2.baidu.com/image_search/src=http%3A%2F%2Fattachments.gfan.net.cn%2Fforum%2Fattachments2%2F201301%2F27%2F2021185sktw6bbr5st54wr.jpg&refer=http%3A%2F%2Fattachments.gfan.net.cn&app=2002&size=f9999,10000&q=a80&n=0&g=0n&fmt=jpeg?sec=1613268193&t=7d42913aa7eba240c174ad11ef1d85ce",
@"https://gimg2.baidu.com/image_search/src=http%3A%2F%2Fdemo.kesion.com%2FUploadFiles%2F2014-08%2F2%2F201484163390.jpg&refer=http%3A%2F%2Fdemo.kesion.com&app=2002&size=f9999,10000&q=a80&n=0&g=0n&fmt=jpeg?sec=1613268193&t=6922d01a7bab76020c8322c892d61191",
@"https://gimg2.baidu.com/image_search/src=http%3A%2F%2Fb.zol-img.com.cn%2Fdesk%2Fbizhi%2Fimage%2F2%2F960x600%2F136244845695.jpg&refer=http%3A%2F%2Fb.zol-img.com.cn&app=2002&size=f9999,10000&q=a80&n=0&g=0n&fmt=jpeg?sec=1613268193&t=db4d862d4c09c5b52cd40c1309093cdb",
@"https://gimg2.baidu.com/image_search/src=http%3A%2F%2Fpic1.win4000.com%2Fwallpaper%2Ff%2F51ba7f40069c4.jpg&refer=http%3A%2F%2Fpic1.win4000.com&app=2002&size=f9999,10000&q=a80&n=0&g=0n&fmt=jpeg?sec=1613268193&t=8cab977ea9b1b7eb4f52209f09f52075",
@"https://gimg2.baidu.com/image_search/src=http%3A%2F%2Fnimg.ws.126.net%2F%3Furl%3Dhttp%253A%252F%252Fdingyue.ws.126.net%252F2020%252F1229%252Ff64643e6j00qm2z2k001yc000hs00gim.jpg%26thumbnail%3D650x2147483647%26quality%3D80%26type%3Djpg&refer=http%3A%2F%2Fnimg.ws.126.net&app=2002&size=f9999,10000&q=a80&n=0&g=0n&fmt=jpeg?sec=1613268362&t=239e2720715630e3bd93c9162d41ceed"
    ];
    
    return;
    
    XHello *hello = [[XHello alloc] init];
    [hello onXhello];
    XPFLog(@" 我的天哪 成功了、 %@", [hello onXhello]);
    
    XPFPageControl *pageControl = [[XPFPageControl alloc] initWithFrame:CGRectMake(10, 200, 300, 50)];
    pageControl.numberOfPages = 5;
    pageControl.currentPage = 5;
    [self.view addSubview:pageControl];
    pageControl.backgroundColor = [UIColor grayColor];
    [pageControl setValue:[UIImage imageNamed:@"aaaa"] forKeyPath:@"_currentPageImage"];
    [pageControl setValue:[UIImage imageNamed:@"bbbb"] forKeyPath:@"_pageImage"];

    
    return;
    
    [self log_cs];
    
    return;
    
    [self on_addBtnCeshi_C];
    [self on_addBtnsasa];
    [self on_addBtnsasa22222];
    [self on_addBtn222];
    [self on_addBtn3333];
    [self on_addBtn333333333333333333333333333333333333];
    [self on_addBtn444444];
    [self on_addBtn55555];
    [self on_addBtnapple];
     
    [self configUI];
    
}



#pragma mark -----
- (void)addPageControlUI
{
    
    self.pageControl = [[UIPageControl alloc] init];
    [self.view addSubview:self.pageControl];
    [self.pageControl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.top.mas_equalTo(RATIOA(100));
        make.height.mas_equalTo(RATIOA(44));
    }];
    
    if (@available(iOS 14.0, *))
    {
        
    }
    else
    {
        
    }
    
    self.pageControl.numberOfPages = 6;
    self.pageControl.currentPage = 0;
    self.pageControl.currentPageIndicatorTintColor = [UIColor redColor];
    //self.pageControl.pageIndicatorTintColor = [UIColor blueColor];
    
    
    if (@available(iOS 14.0, *)) {
        // 自定义图片
        self.pageControl.preferredIndicatorImage = [UIImage imageNamed:@"icon_heart_1"];
        //[self.pageControl setIndicatorImage:[UIImage imageNamed:@"icon_heart_2"] forPage:2];
    } else {
        // Fallback on earlier versions
    }
    
}

#pragma mark ----- 图片区域拉伸 resizableImageWithCapInsets
- (void)onAction_resizableImageWithCapInsets
{
     
    UIImage *img = [UIImage imageNamed:@"ceshiimg123"];//原图
    //UIImageResizingModeStretch：拉伸模式，通过拉伸UIEdgeInsets指定的矩形区域来填充图片
    //UIImageResizingModeTile：平铺模式，通过重复显示UIEdgeInsets指定的矩形区域来填充图
    img = [img resizableImageWithCapInsets:UIEdgeInsetsMake(0, 80, 0, 80) resizingMode:UIImageResizingModeStretch];
    //
    UIImageView *topimg2View = [[UIImageView alloc] init];
    topimg2View.image = img;
    [self.view addSubview:topimg2View];
    [topimg2View mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(10);
        make.width.mas_equalTo(300);
        make.top.mas_equalTo(300);
        make.height.mas_equalTo(44);
    }];
    
    //
    UIImage *imgs = [UIImage imageNamed:@"ceshiimg123"];//原图
    imgs = [imgs resizableImageWithCapInsets:UIEdgeInsetsMake(0, 40, 0, 40) resizingMode:UIImageResizingModeStretch];
    UIImageView *topimgView = [[UIImageView alloc] init];
    topimgView.image = imgs;//原图
    [self.view addSubview:topimgView];
    [topimgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(10);
        make.width.mas_equalTo(300);
        make.top.mas_equalTo(100);
        make.height.mas_equalTo(44);
    }];
    topimgView.backgroundColor = [UIColor redColor];
    
}



#pragma mark -- <LiveViewProtocol> /// 发送点赞
- (void)likeViewSendZan:(LiveView *)likeView
{
    
}


- (LiveView *)likeView
{
    if (!_likeView) {
        _likeView = [[LiveView alloc] init];
        _likeView.delegate = self;
//        _likeView.userInteractionEnabled = NO;
//        _likeView.backgroundColor = [UIColor yellowColor];
    }
    return _likeView;
}


#pragma mark -- /////////////

- (void)log_cs
{
    
    XPFLog(@" ==首页=[UIApplication sharedApplication]=高度=> %f", [[UIApplication sharedApplication] statusBarFrame].size.height);
    XPFLog(@" ==首页=[UIApplication sharedApplication]==> %d", [[UIApplication sharedApplication] statusBarFrame].size.height > 20 ? 88 : 64);
    
    XPFLog(@" =aaaaaaaaAS=> %@", aaaaaaaaAS);
    
    XPFLog(@" ====/-----====  %d, %d, %d, %d", 10%5, 10/5, 14%5, 14/5);
    XPFLog(@" ====/-----====  %d, %d, %d, %d", 13%5, 13/5, 4%5, 4/5);
    XPFLog(@" ====/-----====  %d, %d, %d, %d", 1%5, 1/5, 5%5, 5/5);
    
    
}

- (CarouselViewTool *)bannerView
{
    if (!_bannerView) {
        _bannerView = [[CarouselViewTool alloc] init];
        _bannerView.clipsToBounds = YES;
        _bannerView.delegate = self;
        _bannerView.pageColor = [UIColor lightGrayColor];
        _bannerView.currentPageColor = [UIColor whiteColor];
        _bannerView.layer.shadowColor = [UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:0.1].CGColor;
        _bannerView.layer.shadowOffset = CGSizeMake(0, 5);
        _bannerView.layer.shadowOpacity = 1;
        _bannerView.layer.shadowRadius = 20;
        _bannerView.layer.cornerRadius = 5;
    }
    return _bannerView;
}



- (void)carouselView:(CarouselViewTool *)carouselView indexOfClickedImageBtn:(NSUInteger)index
{
    
}

- (void)onDarkMode:(UIButton *)button
{
    self.view.backgroundColor = [DarkPink shared].dg_BackgroundColor;
    
    [button setTitleColor:[DarkPink shared].dg_TextColor forState:(UIControlStateNormal)];
    //[button setBackgroundColor:[DarkPink shared].dg_BackgroundColor];
    
}
- (void)onAddDarkBtnUI
{
    
    UIButton *buttonCS = [[UIButton alloc] init];
    [buttonCS setTitle:@"暗黑模式" forState:(UIControlStateNormal)];
    [buttonCS setBackgroundColor:[UIColor redColor]];
    [buttonCS addTarget:self action:@selector(onDarkMode:) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:buttonCS];
    [buttonCS mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(100);
        make.left.mas_equalTo(130);
        make.width.mas_equalTo(180);
        make.height.mas_equalTo(80);
    }];
}

- (void)on_CeshiLikeSpotGood
{
    self.likeGoods_s.showMoney = @"567";
    self.likeGoods_s.showImg = @"1";
    self.likeGoods_s.showTypeImg = showImgType_Golds;
    [self.likeGoods_s showSStartPlayDuration:0];
    
    
    [self.likeGoods_h addHDataName:@"很酷" type:@"点赞" typeImg:@"http://source.yuange66.cn/1615946279.png" number:@"10"];
    //[self.likeGoods_h addHDataName:@"很酷" type:@"点赞" typeImg:@"icon_heart_3" number:@"10"];
    //[self.likeGoods_h showHStartPlayDuration:0];
    
    
}
- (void)onSubSLikeSpotGoods
{
    //
    self.likeGoods_s = [[XSpotLikeGoods alloc] initWithFrame:CGRectMake(100, 200, 120, 300) directionType:(directionType_S)];
    self.likeGoods_s.backgroundColor = [UIColor orangeColor];
    [self.view addSubview:self.likeGoods_s];
    
    UIButton *buttonCS = [[UIButton alloc] init];
    [buttonCS setTitle:@"测试" forState:(UIControlStateNormal)];
    [buttonCS setBackgroundColor:[UIColor redColor]];
    [buttonCS addTarget:self action:@selector(on_CeshiLikeSpotGood) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:buttonCS];
    [buttonCS mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-10);
        make.width.height.mas_equalTo(100);
        make.top.mas_equalTo(200);
    }];
    
}
- (void)onSubHLikeSpotGoods
{
    //
    self.likeGoods_h = [[XSpotLikeGoods alloc] initWithFrame:CGRectMake(0, 100, SW, 44.0) directionType:(directionType_H)];
    self.likeGoods_h.backgroundColor = [UIColor clearColor];
    [self.view addSubview:self.likeGoods_h];
    
}


- (void)addIMG {
    UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(100, SH - 200, 100, 100)];
    [imgView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://desk.fd.zol-img.com.cn/t_s960x600c5/g5/M00/05/02/ChMkJ1bxATiIVlzmAAlJIHaXmLkAAOTUgN32YEACUk4716.jpg"]] placeholderImage:[UIImage imageNamed:@"lufei"]];
    [self.view addSubview:imgView];
}

- (void)onaaaaaaaa
{
    NSString *strttt = @"http://source.yuange66.cn/1615946279.png";
    if ([strttt localizedCaseInsensitiveContainsString:@"cn/"])
    {
        if ([strttt localizedCaseInsensitiveContainsString:@".png"])
        {
            NSRange startRange = [strttt rangeOfString:@"cn/"];
            NSRange endRange = [strttt rangeOfString:@".png"];
            NSRange range = NSMakeRange(startRange.location + startRange.length, endRange.location - startRange.location - startRange.length);
            NSString *result = [strttt substringWithRange:range];
            XPFLog(@" ===== %@ ", result);
        }
    }
    else
    {
        XPFLog(@" 失败 ");
    }

}

#pragma mark ----- 分享 UI
- (void)onAddShareUI
{
    //
    UIButton *buttonCS = [[UIButton alloc] init];
    buttonCS.enabled = YES;
    [buttonCS setTitle:@"share" forState:(UIControlStateNormal)];
    [buttonCS setBackgroundColor:[UIColor redColor]];
    [buttonCS addTarget:self action:@selector(ActionShare:) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:buttonCS];
    [buttonCS mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(100);
        make.left.mas_equalTo(130);
        make.width.mas_equalTo(180);
        make.height.mas_equalTo(80);
    }];
}

- (void)ActionShare:(UIButton *)button
{
    WeakSelf;
    NSArray *titleAry = @[@"好友", @"朋友圈", @"群"];
    NSArray *iconAry = @[@"icon_heart_1", @"icon_heart_2", @"icon_heart_3"];
    XShareUI *shareV = [[XShareUI alloc] initWithTitles:titleAry iconNames:iconAry];
    [shareV showActionSharePopupChoiceWithClickBlock:^(int btnIndex) {
        //
        NSLog(@" ==这个按钮== %d", btnIndex);
    } cancelBlock:^{
        //
    }];
    
}


- (void)addView
{
    UIButton *ceshiView = [[UIButton alloc] init];
    [self.view addSubview:ceshiView];
    [ceshiView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.centerY.mas_equalTo(0);
        make.width.height.mas_equalTo(RATIO*100);
    }];
    [ceshiView addTarget:self action:@selector(onActionClick:) forControlEvents:(UIControlEventTouchUpInside)];
    ceshiView.backgroundColor = [UIColor redColor];
    [ceshiView setImage:[UIImage imageNamed:@"lufei"] forState:(UIControlStateNormal)];
}

- (void)onActionClick:(UIButton *)button
{
    
    button.selected = !button.selected;
    //
    if (button.selected)
    {
//        [UIView animateWithDuration:.5 animations:^{
//            button.transform = CGAffineTransformMakeRotation(90 * M_PI / 180.0);
//        }];
        
        [UIView animateWithDuration:0.3 animations:^{
            button.transform = CGAffineTransformMakeRotation(90 * M_PI / 180.0); //CGAffineTransformRotate(button.transform , 3.14);
            // 缩放是按比例缩放
             button.transform = CGAffineTransformScale(button.transform, 2, 2);
        }];
    }
    else
    {
//        [UIView animateWithDuration:.5 animations:^{
//            button.transform = CGAffineTransformMakeRotation(0 * M_PI / 180);
//        }];
        
        [UIView animateWithDuration:0.3 animations:^{
            button.transform = CGAffineTransformMakeRotation(0 * M_PI / 180); //CGAffineTransformRotate(button.transform , -3.14);
            button.transform = CGAffineTransformScale(button.transform, 1, 1);
        }];
    }
    
}


#pragma mark ----- 发消息
- (void)sendMesssg
{
//    objc_msgSend(@"", @selector(sendMesssg), @"");
    
    
}



#pragma mark -----------------
-(void)configUI {
    if (@available(iOS 13.0, *)) {
        self.authorizationButton = [[ASAuthorizationAppleIDButton alloc]init];
        [self.authorizationButton addTarget:self action:@selector(click) forControlEvents:(UIControlEventTouchUpInside)];
        self.authorizationButton.center = self.view.center;
        [self.view addSubview:self.authorizationButton];
    } else {
        // Fallback on earlier versions
    }
}

-(void)click API_AVAILABLE(ios(13.0)){
    ASAuthorizationAppleIDProvider *appleIDProvider = [[ASAuthorizationAppleIDProvider alloc]init];
    ASAuthorizationAppleIDRequest *request = [appleIDProvider createRequest];
    request.requestedScopes = @[ASAuthorizationScopeFullName,ASAuthorizationScopeEmail];
    ASAuthorizationController *auth = [[ASAuthorizationController alloc]initWithAuthorizationRequests:@[request]];
    auth.delegate = self;
    auth.presentationContextProvider = self;
    [auth performRequests];
}
///代理主要用于展示在哪里
-(ASPresentationAnchor)presentationAnchorForAuthorizationController:(ASAuthorizationController *)controller API_AVAILABLE(ios(13.0)){
    return self.view.window;
}


-(void)authorizationController:(ASAuthorizationController *)controller didCompleteWithAuthorization:(ASAuthorization *)authorization API_AVAILABLE(ios(13.0)) {
        if ([authorization.credential isKindOfClass:[ASAuthorizationAppleIDCredential class]]) {
            ASAuthorizationAppleIDCredential *apple = authorization.credential;
            ///将返回得到的user 存储起来
            NSString *userIdentifier = apple.user;
            NSPersonNameComponents *fullName = apple.fullName;
            NSString *email = apple.email;
            //用于后台像苹果服务器验证身份信息
            NSData *identityToken = apple.identityToken;
            NSLog(@"====> %@, %@, %@, %@", userIdentifier, fullName, email, identityToken);
            
        }
        else if ([authorization.credential isKindOfClass:[ASPasswordCredential class]])
        {   /// Sign in using an existing iCloud Keychain credential.
            ASPasswordCredential *pass = authorization.credential;
            NSString *username = pass.user;
            NSString *passw = pass.password;
            NSLog(@"====> %@, %@, %@", username, passw, pass);
            
        }
}

///回调失败
-(void)authorizationController:(ASAuthorizationController *)controller didCompleteWithError:(NSError *)error API_AVAILABLE(ios(13.0)){
    NSLog(@"%@",error);
}


#pragma mark -----------------
///
- (void)on_apple
{
    
}

- (void)on_1231231231_2onCeshi
{
    SearchVC *csVC = [[SearchVC alloc] init];
    [self pushViewController:csVC];
}

- (void)on_saomaosssssa:(UIButton *)button
{
    UIButton *btt = [self.view viewWithTag:button.tag];
    
    if ([self.player isPlaying])
    {
        [btt setTitle:@"pause" forState:(UIControlStateNormal)];
        [self.player pause];
    }
    else
    {
        [btt setTitle:@"play" forState:(UIControlStateNormal)];
        [self.player play];
    }
    // 声音
//    XPFPlaySystemRing *aa = [[XPFPlaySystemRing alloc] initActionAVAudioPlayer:@"" mp3:@"mp3"];
    //[aa onPrepareToPlayMp3];
}

- (void)on_saomaosssssa222222222:(UIButton *)button
{
    LuckDraw *csVC = [[LuckDraw alloc] init];
    [self pushViewController:csVC];
}

- (void)on_12312312312
{
    HomeCs2UIViewController *csVC = [[HomeCs2UIViewController alloc] init];
    [self pushViewController:csVC];
}

- (void)on_222222
{
    ZoomViewController *vc = [[ZoomViewController alloc] init];
    vc.title = @"测试中";
    vc.isNeedHeader = YES;
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)on_333333
{
    XPFUploadProductVC *vc = [[XPFUploadProductVC alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)on_3333333333333333333333
{
    [self.jectView showAlertView];
}

- (XPFEjectBaseView *)jectView
{
    if (!_jectView) {
        _jectView = [[XPFEjectBaseView alloc] initShowAlertViewSuperView:nil];
    }
    return _jectView;
}

- (void)on_444444
{
    // 二维码
    XPFScanVC *vc = [[XPFScanVC alloc] init];
    vc.type = @"01";
    vc.hasScan = ^(NSString *codeInfo) {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:codeInfo message:@"" delegate:nil cancelButtonTitle:@"好的" otherButtonTitles:nil];
        [alertView show];
        
    };
    vc.modalPresentationStyle = UIModalPresentationFullScreen;
    [self presentViewController:vc animated:YES completion:nil];
}

- (void)on_55555
{
    // 条形码
    XPFScanVC *vc = [[XPFScanVC alloc] init];
    vc.type = @"02";
    vc.hasScan = ^(NSString *codeInfo) {
        
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:codeInfo message:@"" delegate:nil cancelButtonTitle:@"好的" otherButtonTitles:nil];
        [alertView show];
        
    };
    vc.modalPresentationStyle = UIModalPresentationFullScreen;
    [self presentViewController:vc animated:YES completion:nil];
    
}


/**
 * 测试 搜索看 vc
 */
- (void)on_addBtnCeshi_C {
    
    UIButton *buttonCS = [[UIButton alloc] init];
    [buttonCS setTitle:@"测试...search" forState:(UIControlStateNormal)];
    [buttonCS setBackgroundColor:[UIColor redColor]];
    [buttonCS addTarget:self action:@selector(on_1231231231_2onCeshi) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:buttonCS];
    [buttonCS mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(100);
        make.left.mas_equalTo(130);
        make.width.mas_equalTo(180);
        make.height.mas_equalTo(80);
    }];
}
/**
 *
 */
- (void)on_addBtnapple {
    
    UIButton *buttonCS = [[UIButton alloc] init];
    [buttonCS setTitle:@"apple" forState:(UIControlStateNormal)];
    [buttonCS setBackgroundColor:[UIColor redColor]];
    [buttonCS addTarget:self action:@selector(on_apple) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:buttonCS];
    [buttonCS mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(200);
        make.left.mas_equalTo(130);
        make.width.height.mas_equalTo(80);
    }];
}
/**
 *
 */
- (void)on_addBtn {
    
    UIButton *buttonCS = [[UIButton alloc] init];
    [buttonCS setTitle:@"测试" forState:(UIControlStateNormal)];
    [buttonCS setBackgroundColor:[UIColor redColor]];
    [buttonCS addTarget:self action:@selector(on_12312312312) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:buttonCS];
    [buttonCS mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(200);
        make.left.mas_equalTo(130);
        make.width.height.mas_equalTo(80);
    }];
}
/**
 *
 */
- (void)on_addBtnsasa {
    
    
    UIButton *buttonCS = [[UIButton alloc] init];
    [buttonCS setTitle:@"提示音" forState:(UIControlStateNormal)];
    [buttonCS setBackgroundColor:[UIColor redColor]];
    buttonCS.tag = 1123123;
    [buttonCS addTarget:self action:@selector(on_saomaosssssa:) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:buttonCS];
    [buttonCS mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(200);
        make.left.mas_equalTo(230);
        make.width.height.mas_equalTo(80);
    }];
}

- (void)on_addBtnsasa22222
{
    
    UIButton *buttonCS = [[UIButton alloc] init];
    [buttonCS setTitle:@"转盘" forState:(UIControlStateNormal)];
    [buttonCS setBackgroundColor:[UIColor redColor]];
    buttonCS.tag = 1123123;
    [buttonCS addTarget:self action:@selector(on_saomaosssssa222222222:) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:buttonCS];
    [buttonCS mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(300);
        make.left.mas_equalTo(230);
        make.width.height.mas_equalTo(80);
    }];
}


- (void)on_addBtn222 {
    
    UIButton *buttonCS = [[UIButton alloc] init];
    [buttonCS setTitle:@"测试2" forState:(UIControlStateNormal)];
    [buttonCS setBackgroundColor:[UIColor redColor]];
    [buttonCS addTarget:self action:@selector(on_222222) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:buttonCS];
    [buttonCS mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(300);
        make.left.mas_equalTo(130);
        make.width.height.mas_equalTo(80);
    }];
}

- (void)on_addBtn3333 {
    
    UIButton *buttonCS = [[UIButton alloc] init];
    [buttonCS setTitle:@"发布" forState:(UIControlStateNormal)];
    [buttonCS setBackgroundColor:[UIColor redColor]];
    [buttonCS addTarget:self action:@selector(on_333333) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:buttonCS];
    [buttonCS mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(400);
        make.left.mas_equalTo(130);
        make.width.height.mas_equalTo(80);
    }];
    
}

- (void)on_addBtn333333333333333333333333333333333333 {
    
    UIButton *buttonCS = [[UIButton alloc] init];
    [buttonCS setTitle:@"提示view" forState:(UIControlStateNormal)];
    [buttonCS setBackgroundColor:[UIColor redColor]];
    [buttonCS addTarget:self action:@selector(on_3333333333333333333333) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:buttonCS];
    [buttonCS mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(400);
        make.left.mas_equalTo(230);
        make.width.height.mas_equalTo(80);
    }];
    
}

- (void)on_addBtn444444 {
    
    UIButton *buttonCS = [[UIButton alloc] init];
    [buttonCS setTitle:@"扫描01" forState:(UIControlStateNormal)];
    [buttonCS setBackgroundColor:[UIColor redColor]];
    [buttonCS addTarget:self action:@selector(on_444444) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:buttonCS];
    [buttonCS mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(500);
        make.left.mas_equalTo(130);
        make.width.height.mas_equalTo(80);
    }];
    
}

- (void)on_addBtn55555 {
    
    UIButton *buttonCS = [[UIButton alloc] init];
    [buttonCS setTitle:@"扫描02" forState:(UIControlStateNormal)];
    [buttonCS setBackgroundColor:[UIColor redColor]];
    [buttonCS addTarget:self action:@selector(on_55555) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:buttonCS];
    [buttonCS mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(500);
        make.left.mas_equalTo(230);
        make.width.height.mas_equalTo(80);
    }];
    
}

@end
