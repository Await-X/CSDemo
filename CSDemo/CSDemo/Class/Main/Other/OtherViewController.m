// 

#import "OtherViewController.h"
#import <AuthenticationServices/AuthenticationServices.h>

#import "SignInApple.h"
#import "Other2Vc.h"

#import "XYouthView.h"

#import "Person.h"
#import "DrawFanPictureView.h"

#import "FLuckyView.h"


@interface OtherViewController ()
///
@property (nonatomic, strong) NSMutableArray *contAry;
@property (nonatomic, strong) UIScrollView *bgScrollView;
///
@property (nonatomic, strong) XYouthView *youthView;

@end

@interface OtherViewController ()

// 防止被释放，回调方法不会走，或者也可以把SignInApple这个类写成单例
@property (nonatomic, strong) SignInApple *signInApple;

// 循环播放
@property (nonatomic, strong) UIImageView *imageView;

@end

@implementation OtherViewController

#pragma mark ----- 度转弧度
-(float)huDuFromdu:(float)du
{
    return M_PI/(180/du);
}

- (BOOL)compareVesionWithServerVersion:(NSString *)version
{
    NSArray *versionArray = [version componentsSeparatedByString:@"."];//服务器返回版
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    NSString *app_Version = [infoDictionary objectForKey:@"CFBundleShortVersionString"];
    NSArray *currentVesionArray = [app_Version componentsSeparatedByString:@"."];//当前版本
    NSInteger a = (versionArray.count > currentVesionArray.count) ? currentVesionArray.count : versionArray.count;
    XPFLog(@"=====> %ld, %@, %@", a, versionArray, currentVesionArray);
    for (int i = 0; i < a; i++) {
        NSInteger a = [versionArray[i] integerValue];
        NSInteger b = [currentVesionArray[i] integerValue];
        if (a > b)
        {
            NSLog(@"有新版本");
            return YES;
        }
        else if (a < b)
        {
            return NO;
        }
    }
    return NO;
}

#pragma mark -----

- (void)presentPreviewPhotoWith_yy_Url
{
    NSMutableArray *tempArr = [NSMutableArray array];
    
    NSURL *urlwebp = [NSURL URLWithString:@"http://source.yuange66.cn/FoVC064IWGHPKNr41p5SmuP2IVH9-imgW640"];
    NSURL *url = [NSURL URLWithString:@"http://source.yuange66.cn/FhVRqEn1RGb-aoEPUdbfe7u59dYV-imgW640"];
    
    // 创建队列组，可以使多个网络请求异步执行，执行完之后再进行操作
    dispatch_group_t group = dispatch_group_create();
    //创建全局队列
    dispatch_queue_t queue = dispatch_get_global_queue(0, 0);
    dispatch_group_async(group, queue, ^{
        for (int i = 0; i < 4; i++)
        {
            dispatch_semaphore_t semaphore = dispatch_semaphore_create(0);
            YYWebImageManager *manager = [YYWebImageManager sharedManager];
            NSString *key = [manager cacheKeyForURL:urlwebp];
            YYImageCache *cache = [YYImageCache sharedCache];
            UIImage *image = [cache getImageForKey:key];
            if (image)
            {
                HXCustomAssetModel *models = [HXCustomAssetModel assetWithLocalImage:image selected:YES];
                models.localImage = image;
                [tempArr addObject:models];
                dispatch_semaphore_signal(semaphore);
            }
            else
            {
                [[YYWebImageManager sharedManager] requestImageWithURL:urlwebp options:YYWebImageOptionAvoidSetImage progress:^(NSInteger receivedSize, NSInteger expectedSize) {
                        
                } transform:^UIImage * _Nullable(UIImage * _Nonnull image, NSURL * _Nonnull url) {
                    return image;
                } completion:^(UIImage * _Nullable image, NSURL * _Nonnull url, YYWebImageFromType from, YYWebImageStage stage, NSError * _Nullable error) {
                    XPFLog(@"%@", image);
                    if (!error) {
                        HXCustomAssetModel *models = [HXCustomAssetModel assetWithLocalImage:image selected:YES];
                        models.localImage = image;
                        [tempArr addObject:models];
                        dispatch_semaphore_signal(semaphore);
                    }
                }];
            }
        }
        
    });

    // 当所有队列执行完成之后
    dispatch_group_notify(group, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        // 返回主线程进行界面上的修改
        dispatch_async(dispatch_get_main_queue(), ^{
            
            HXPhotoManager *photoManager = [HXPhotoManager managerWithType:HXPhotoManagerSelectedTypePhotoAndVideo];
            photoManager.configuration.saveSystemAblum = YES;
            photoManager.configuration.photoMaxNum = 0;
            photoManager.configuration.videoMaxNum = 0;
            photoManager.configuration.maxNum = 10;
            photoManager.configuration.selectTogether = YES;
            photoManager.configuration.photoCanEdit = NO;
            photoManager.configuration.videoCanEdit = NO;
            [photoManager addCustomAssetModel:tempArr];

            [self hx_presentPreviewPhotoControllerWithManager:photoManager previewStyle:HXPhotoViewPreViewShowStyleDark currentIndex:0 photoView:nil];
        });
    });
}


///
- (void)presentPreviewPhotoWithUrl
{
    NSMutableArray *tempArr = [NSMutableArray array];
    
    NSURL *urlwebp = [NSURL URLWithString:@"http://source.yuange66.cn/FoVC064IWGHPKNr41p5SmuP2IVH9-imgW640"];
    NSURL *url = [NSURL URLWithString:@"http://source.yuange66.cn/FhVRqEn1RGb-aoEPUdbfe7u59dYV-imgW640"];
    for (int i = 0; i < 4; i++) {
        HXCustomAssetModel *models = [HXCustomAssetModel assetWithNetworkImageURL:urlwebp selected:YES];
        //models.networkImageURL = [NSURL URLWithString:@"http://source.yuange66.cn/FhVRqEn1RGb-aoEPUdbfe7u59dYV-imgW640"];
        [tempArr addObject:models];
    }

    HXPhotoManager *photoManager = [HXPhotoManager managerWithType:HXPhotoManagerSelectedTypePhotoAndVideo];
    photoManager.configuration.saveSystemAblum = YES;
    photoManager.configuration.photoMaxNum = 0;
    photoManager.configuration.videoMaxNum = 0;
    photoManager.configuration.maxNum = 10;
    photoManager.configuration.selectTogether = YES;
    photoManager.configuration.photoCanEdit = NO;
    photoManager.configuration.videoCanEdit = NO;
    [photoManager addCustomAssetModel:tempArr];

    [self hx_presentPreviewPhotoControllerWithManager:photoManager previewStyle:HXPhotoViewPreViewShowStyleDark currentIndex:0 photoView:nil];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    
    //
    [self presentPreviewPhotoWith_yy_Url];
    //
//    [self presentPreviewPhotoWithUrl];
}


#pragma mark -----

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"消息";
    //[self imgadd];
    //[self onAddPushPOP];
    
    //self.view.backgroundColor = [XPFDarkMode shared].x_TextWhite;
    
    
    return;
    [self addLuckyViewUI];
    
}

#pragma mark ----- ----- -----


- (void)addLuckyViewUI
{
    FLuckyView *luckyView = [[FLuckyView alloc] init];
    [self.view addSubview:luckyView];
    [luckyView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.top.mas_equalTo(RATIOA(100));
        make.height.mas_equalTo(SW);
    }];
    luckyView.backgroundColor = [UIColor orangeColor];
    
//    [self onActionUI];
    
}


- (void)onActionUI
{
    
    CGRect labelFrame1 = CGRectMake(SW/2, SW + RATIOA(120), 140, 40);
    UILabel *text1 = [[UILabel alloc] initWithFrame:labelFrame1];
    text1.transform = CGAffineTransformMakeRotation(0 * M_PI / 180);
    text1.backgroundColor = [UIColor clearColor];
    text1.text = @"Home1";
    [self.view addSubview:text1];
    [self.view bringSubviewToFront:text1];
    
    CGRect labelFrame2 = CGRectMake(SW/2 + 100, SW + RATIOA(120), 140, 40);
    UILabel *text2 = [[UILabel alloc] initWithFrame:labelFrame2];
    text2.transform = CGAffineTransformMakeRotation(45 * M_PI / 180);
    text2.backgroundColor = [UIColor clearColor];
    text2.text = @"Home2";
    [self.view addSubview:text2];
    [self.view bringSubviewToFront:text2];
}





#pragma mark ----- ----- -----

- (void)didPushPOP
{
    Other2Vc *vc = [[Other2Vc alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
    //[self.navigationController presentViewController:vc animated:YES completion:nil];
    
}

- (void)ssssss {
    return;
    
    
    NSURL *url = [NSURL URLWithString:@"App-Prefs:root=General"];

    // 最好加上   ⭐️判断条件⭐️
    if ([[UIApplication sharedApplication] canOpenURL:url])
    {   // 看是否 允许跳转
        [[UIApplication sharedApplication] openURL:url];
        
    }
    
    
    NSLog(@"cos: %f, %f, %F", cos(360/10), cos(36), [self huDuFromdu:36]);
    
    if ([self compareVesionWithServerVersion:@"1.0.3"]) {
        XPFLog(@" yes ");
        UserDef_setboolforkey(YES, KHideVersion);
    }
    else
    {
        XPFLog(@" no ");
        UserDef_setboolforkey(NO, KHideVersion);
    }
    BOOL boolVersion = UserDef_boolforkey(KHideVersion);
    if (boolVersion)
    {
        XPFLog(@"UserDef_boolforkey yes ");
    }
    else
    {
        XPFLog(@"UserDef_boolforkey no ");
    }
    return;
    
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    NSString *app_Version = [infoDictionary objectForKey:@"CFBundleShortVersionString"];
    NSArray *currentVesionArray = [app_Version componentsSeparatedByString:@"."];//当前版本
    
    XPFLog(@" ==== >  %@", currentVesionArray);
    
    return;

    NSString *versionStr = [NSString stringWithFormat:@"2901"];
    NSString *appVersion_NewStr = [versionStr stringByReplacingOccurrencesOfString:@"." withString:@""];
    
    XPFLog(@"===> %@", appVersion_NewStr);
    
    
    return;
    
    DrawFanPictureView *view1 = [[DrawFanPictureView alloc] initWithFrame:CGRectMake(100, 100, 100, 100)];
    view1.dataDict = @{@"100":[UIColor redColor],@"50":[UIColor blueColor],@"160":[UIColor orangeColor]};
    [self.view addSubview:view1];
        
    DrawFanPictureView *view = [[DrawFanPictureView alloc] initWithFrame:CGRectMake(100, 250, 100, 100)];
    view.dataDict = @{@"100":[UIColor redColor],@"50":[UIColor blueColor],@"160":[UIColor orangeColor]};
    view.startDegres = -M_PI*1/2;//调整起始弧度
    [self.view addSubview:view];
    
    
    return;
    
    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:CGPointMake(100, 100) radius:25 startAngle:0 endAngle:M_PI/2 clockwise:YES];
    CGPoint center = CGPointMake(100, 100);
    //添加一根线到圆心
    [path addLineToPoint:center];
    //关闭路径，是从终点到起点
    [path closePath];
    [path stroke];

    //使用填充，默认就会自动关闭路径，（终点到起点）这样就可以不写[path closePath];
    [path fill];
    
    
    return;
    
    
    
    UIBezierPath *bezierPath = [UIBezierPath bezierPath];
    //画圆弧 逆时针半圈
    [bezierPath addArcWithCenter:self.view.center radius:50 startAngle:0 endAngle:-M_PI clockwise:NO];
    [bezierPath setLineWidth:2];
    
    //画圆弧 顺时针半圈
    [bezierPath addArcWithCenter:CGPointMake(100, 100) radius:50 startAngle:0 endAngle:M_PI clockwise:YES];
    
    //如果没有闭合，只会显示弧线。
    [bezierPath addLineToPoint:CGPointMake(100, 100)];
    [bezierPath closePath];
    //  设置颜色（颜色设置也可以放在最上面，只要在绘制前都可以）
    //[color196FFA setStroke];
    //[colorClear setFill];
    // 描边和填充
    [bezierPath stroke];
    [bezierPath fill];
    
    CAShapeLayer *layer = [CAShapeLayer layer];
    layer.path = bezierPath.CGPath;
    layer.strokeColor = [UIColor redColor].CGColor;
    layer.fillColor = [UIColor grayColor].CGColor;
    layer.backgroundColor = [UIColor blueColor].CGColor;
    
    CABasicAnimation *strokeEndAni = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    strokeEndAni.fromValue = @0;
    strokeEndAni.toValue = @(1);
    strokeEndAni.duration = 10.0f;
    strokeEndAni.repeatCount = 10; // 重复次数
    [layer addAnimation:strokeEndAni forKey:@"ani"];
    
    [self.view.layer addSublayer:layer];
    
    CAKeyframeAnimation *pathAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    pathAnimation.removedOnCompletion = NO;
    pathAnimation.duration = 10;//完成动画的时间
    //让循环连续演示
    pathAnimation.repeatCount = 10;
    pathAnimation.path = bezierPath.CGPath;
    UIImageView *circleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"icon_logo"]];
    circleView.frame = CGRectMake(1, 1, 40, 40);
    [self.view addSubview:circleView];
    
    //添加动画circleView——一旦你添加动画层,动画开始
    [circleView.layer addAnimation:pathAnimation
                            forKey:@"movecycle"];

    
    
    
    return;
    
    [[Person new] sendMessage:@"hello"];
    
    
    
    //objc_msgSend([Person new], @selector(sendMessage:), @"person");
        
    [self onAdd];
    return;
    

    NSString *str = [[NSString alloc] initWithBytes:@"1234567890" length:9 encoding:(NSUTF8StringEncoding)];
    XPFLog(@" =====>  %@", str);
    
    [self up:@"https://ss0.bdstatic.com/94oJfD_bAAcT8t7mm9GUKT-xh_/timg?image&quality=100&size=b4000_4000&sec=1597822872&di=7ba3bf7fcaf1086f0e7e5a5feae22199&src=http://a1.att.hudong.com/62/02/01300542526392139955025309984.jpg"];
    
    //
    NSInteger aaa = 0;
    for (int i = 0; i < 10; i++) {
        aaa = i;
        if (i == 3) {
            break;
        }
    }
    XPFLog(@"===>  %ld, %f, %f, %f, %f", aaa, sqrt(3)/2, cos(sqrt(3)/2), 300*M_PI, 300*M_PI/4 / 150 / M_PI); // sqrt 开根号
    XPFLog(@" ===> %d, %d, %d", 30%60, 20%60, 60%60);
    // 弧度 = 弧长 / 半径
    
    [self.view addSubview:self.bgScrollView];
    [self.bgScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.mas_equalTo(100);
        make.width.height.mas_equalTo(200);
    }];
    
    UIView *adView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 100, 300)];
    adView.backgroundColor = [UIColor blackColor];
    [self.bgScrollView addSubview:adView];
    
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:adView.bounds byRoundingCorners:(UIRectCornerTopRight) cornerRadii:CGSizeMake(3, 3)];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = adView.bounds;
    maskLayer.path = maskPath.CGPath;
    adView.layer.mask = maskLayer;
    
    self.bgScrollView.contentSize = CGSizeMake(200, 500);
    
}

///
- (void)up:(NSString *)urlString
{
//    NSString *urlString = @"https://ss0.bdstatic.com/94oJfD_bAAcT8t7mm9GUKT-xh_/timg?image&quality=100&size=b4000_4000&sec=1597822872&di=7ba3bf7fcaf1086f0e7e5a5feae22199&src=http://a1.att.hudong.com/62/02/01300542526392139955025309984.jpg";
    NSData *data = [NSData dataWithContentsOfURL:[NSURL  URLWithString:urlString]];
    UIImage *image = [UIImage imageWithData:data]; // 取得图片

    [self sss:image]; 
}

- (void)sss:(UIImage *)img
{
    //参数1:图片对象
    //参数2:成功方法绑定的target
    //参数3:成功后调用方法
    //参数4:需要传递信息(成功后调用方法的参数)
    UIImageWriteToSavedPhotosAlbum(img, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);

}
#pragma mark -- <保存到相册>
-(void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo
{
    NSString *msg = nil ;
    if (error)
    {
        msg = @"保存图片失败" ;
    }
    else
    {
        msg = @"保存图片成功" ;
    }
}


- (UIScrollView *)bgScrollView
{
    if (!_bgScrollView) {
        _bgScrollView = [[UIScrollView alloc] init];
//        _bgScrollView.showsVerticalScrollIndicator = NO;
//        _bgScrollView.showsHorizontalScrollIndicator = NO;
        _bgScrollView.backgroundColor = [UIColor redColor];
        //_bgScrollView.scrollEnabled = YES;//这个属性，标识着是否允许滚动，要言设成yes
    }
    return _bgScrollView;
}



- (UIImageView *)imageView
{
    if (!_imageView) {
        _imageView = [[UIImageView alloc] init];
    }
    return _imageView;
}

- (void)imgadd
{
    [self.view addSubview:self.imageView];
    self.imageView.backgroundColor = [UIColor orangeColor];
    [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(30);
        make.top.mas_equalTo(100);
        make.width.height.mas_equalTo(300);
    }];
    
    UIImage *image1 = [UIImage imageNamed:@"icon_heart_1"];
    UIImage *image2 = [UIImage imageNamed:@"icon_heart_2"];
    UIImage *image3 = [UIImage imageNamed:@"icon_heart_3"];
    NSArray *imagesArray = @[image1, image2, image3];
    
    self.imageView.animationImages = imagesArray;
    self.imageView.animationDuration = [imagesArray count];
    //循环次数
    self.imageView.animationRepeatCount = 66;
    [self.imageView startAnimating];

}

- (void)add
{

        /*
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(100, 100, 100, 100)];
        [self.view addSubview:view];
    //    [view mas_makeConstraints:^(MASConstraintMaker *make) {
    //        make.top.left.mas_equalTo(100);
    //        make.width.height.mas_equalTo(100);
    //
    //    }];
        view.backgroundColor = [UIColor redColor];
        
        UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:view.bounds byRoundingCorners:UIRectCornerBottomRight cornerRadii:CGSizeMake(100, 0)];
        CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
        maskLayer.frame = view.bounds;
        maskLayer.path = maskPath.CGPath;
        view.layer.mask = maskLayer;
        
        */
        
        self.contAry = [NSMutableArray arrayWithObjects:@"0", @"1",
                                @"2", @"3",
                                @"4", @"5",
                                @"6", @"7",
                                @"8", @"9", nil];
        
        //[contAry exchangeObjectAtIndex:contAry.count-1 withObjectAtIndex:0];
        
        for (int i = 0; i < 5; i++) {
            NSString *str = [self.contAry lastObject];
            [self.contAry insertObject:str atIndex:0];
            [self.contAry removeObjectAtIndex:self.contAry.count-1];
        }
        
        
        
        for (int i = 1; i < self.contAry.count+1; i++)
        {
            if (i % 2 == 0)
            { // 取整
                NSLog(@" 取整 %d", i);
            }
            else
            { // 取余
                NSLog(@" 取余 %d", i);
            }
        }
        
        //[self configUI];
        [self onAdd];
        
      
}


- (XYouthView *)youthView
{
    if (!_youthView) {
        _youthView = [[XYouthView alloc] initShowYouthAlertViewSuperView:nil];
    }
    return _youthView;
}

- (void)didBtnClicked
{
    XPFLog(@" -------------- ");
    
    [self.youthView showAlertView];
    
    return;
    Other2Vc *vc = [[Other2Vc alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)onAdd
{   //
    UIButton *addBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    addBtn.frame = CGRectMake(30, 80, self.view.bounds.size.width - 60, 44);
    addBtn.backgroundColor = [UIColor orangeColor];
    [addBtn setTitle:@" 青少年模式 " forState:UIControlStateNormal];
    [addBtn addTarget:self action:@selector(didBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:addBtn];
}

- (void)onAddPushPOP
{   //
    UIButton *addBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    addBtn.frame = CGRectMake(30, 80, self.view.bounds.size.width - 60, 44);
    addBtn.backgroundColor = [UIColor orangeColor];
    [addBtn setTitle:@" PushPOP " forState:UIControlStateNormal];
    [addBtn addTarget:self action:@selector(didPushPOP) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:addBtn];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
//    [self perfomExistingAccount];
}

- (void)configUI
{
    // 使用系统提供的按钮，要注意不支持系统版本的处理
    if (@available(iOS 13.0, *)) {
        // Sign In With Apple Button
        ASAuthorizationAppleIDButton *appleIDBtn = [ASAuthorizationAppleIDButton buttonWithType:ASAuthorizationAppleIDButtonTypeDefault style:ASAuthorizationAppleIDButtonStyleWhite];
        appleIDBtn.frame = CGRectMake(30, self.view.bounds.size.height - 180, self.view.bounds.size.width - 60, 100);
        //    appleBtn.cornerRadius = 22.f;
        [appleIDBtn addTarget:self action:@selector(didAppleIDBtnClicked) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:appleIDBtn];
    }
    
    // 或者自己用UIButton实现按钮样式
    UIButton *addBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    addBtn.frame = CGRectMake(30, 80, self.view.bounds.size.width - 60, 44);
    addBtn.backgroundColor = [UIColor orangeColor];
    [addBtn setTitle:@"Sign in with Apple" forState:UIControlStateNormal];
    [addBtn addTarget:self action:@selector(didCustomBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:addBtn];
}

// 自己用UIButton按钮调用处理授权的方法
- (void)didCustomBtnClicked{
    // 封装Sign In with Apple 登录工具类，使用这个类时要把类对象设置为全局变量，或者直接把这个工具类做成单例，如果使用局部变量，和IAP支付工具类一样，会导致苹果回调不会执行
    self.signInApple = [[SignInApple alloc] init];
    [self.signInApple handleAuthorizationAppleIDButtonPress];
}

// 使用系统提供的按钮调用处理授权的方法
- (void)didAppleIDBtnClicked{
    // 封装Sign In with Apple 登录工具类，使用这个类时要把类对象设置为全局变量，或者直接把这个工具类做成单例，如果使用局部变量，和IAP支付工具类一样，会导致苹果回调不会执行
    self.signInApple = [[SignInApple alloc] init];
    [self.signInApple handleAuthorizationAppleIDButtonPress];
}

// 如果存在iCloud Keychain 凭证或者AppleID 凭证提示用户
- (void)perfomExistingAccount{
    // 封装Sign In with Apple 登录工具类，使用这个类时要把类对象设置为全局变量，或者直接把这个工具类做成单例，如果使用局部变量，和IAP支付工具类一样，会导致苹果回调不会执行
    self.signInApple = [[SignInApple alloc] init];
    [self.signInApple perfomExistingAccountSetupFlows];
}

@end
