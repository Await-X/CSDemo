//

#import "XShareSend.h"

@implementation XShareSend


#pragma mark ----- 检查微信是否已被用户安装
+ (BOOL)toWXAppInstalled
{
    return [WXApi isWXAppInstalled];
}

#pragma mark ----- 判断当前微信的版本是否支持OpenApi
+ (BOOL)toWXAppSupportApi
{
    return [WXApi isWXAppSupportApi];
}


#pragma mark ----- 文字类型分享示例
+ (void)toWXSendSceneSessionText:(NSString *)textStr
{
    SendMessageToWXReq *req = [[SendMessageToWXReq alloc] init];
    req.bText = YES;
    req.text = textStr;//@"分享的内容";
    req.scene = WXSceneSession;
    [WXApi sendReq:req completion:^(BOOL success) {
        
    }];
    
}

#pragma mark ----- 图片类型分享示例
+ (void)toWXSendMessageImg:(UIImage *)img filePath:(NSString *)filePathStr
{
    UIImage *image = img;//[UIImage imageNamed:@"res2.png"];
    NSData *imageData = UIImageJPEGRepresentation(image, 0.7);
    
    WXImageObject *imageObject = [WXImageObject object];
    imageObject.imageData = imageData;
    
    WXMediaMessage *message = [WXMediaMessage message];
    NSString *filePath = filePathStr;//[[NSBundle mainBundle] pathForResource:@"res5" ofType:@"jpg"];
    message.thumbData = [NSData dataWithContentsOfFile:filePath];
    message.mediaObject = imageObject;

    SendMessageToWXReq *req = [[SendMessageToWXReq alloc] init];
    req.bText = NO;
    req.message = message;
    req.scene = WXSceneTimeline;
    [WXApi sendReq:req completion:^(BOOL success) {
        
    }];
    
}

#pragma mark ----- 音乐类型分享示例

/**
 *
 * 音乐网页的url地址
 * @note 长度不能超过10K
 *
 *  音乐数据url地址
 * @note 长度不能超过10K
 *
 * 标题
 * @note 长度不能超过512字节
 *
 * 描述内容
 * @note 长度不能超过1K
 *
 * 缩略图
 * @note 大小不能超过64K
 *
 */
+ (void)toWXSendMusicURL:(NSString *)musicUrl musicDataUrl:(NSString *)musicDataUrl musicTitle:(NSString *)musicText musicdes:(NSString *)desStr thumbimg:(NSString *)thumbimgstr
{
    WXMusicObject *musicObject = [WXMusicObject object];
    musicObject.musicUrl = musicUrl;//@"音乐url";
    musicObject.musicLowBandUrl = musicObject.musicUrl;
    musicObject.musicDataUrl = musicDataUrl;//@"音乐数据url";
    musicObject.musicLowBandDataUrl = musicObject.musicDataUrl;

    WXMediaMessage *message = [WXMediaMessage message];
    message.title = musicText;//@"音乐标题";
    message.description = desStr;//@"音乐描述";
    [message setThumbImage:[UIImage imageNamed:thumbimgstr]]; //@"缩略图.jpg"
    message.mediaObject = musicObject;
    SendMessageToWXReq *req = [[SendMessageToWXReq alloc] init];
    req.bText = NO;
    req.message = message;
    req.scene = WXSceneSession;
    [WXApi sendReq:req completion:^(BOOL success) {
        
    }];
    
}


#pragma mark ----- 视频类型分享示例
/**
 *
 *  视频网页的url地址
 * @note 长度不能超过10K
 *
 *  视频lowband网页的url地址
 * @note 长度不能超过10K
 *
 *  标题
 * @note 长度不能超过512字节
 *
 *  描述内容
 * @note 长度不能超过1K
 *
 *  缩略图数据
 * @note 大小不能超过64K
 *
 */
+ (void)toWXSendvideoUrl:(NSString *)videoUrlStr videoLowBandUrl:(NSString *)videoLowBandUrlStr title:(NSString *)videoText des:(NSString *)desStr thumbimg:(NSString *)thumbimgStr
{
    WXVideoObject *videoObject = [WXVideoObject object];
    videoObject.videoUrl = videoUrlStr;//@"视频url";
    videoObject.videoLowBandUrl = videoLowBandUrlStr;//@"低分辨率视频url";
    WXMediaMessage *message = [WXMediaMessage message];
    message.title = videoText;//@"标题";
    message.description = desStr;//@"描述";
    [message setThumbImage:[UIImage imageNamed:thumbimgStr]];//@"缩略图.jpg"
    message.mediaObject = videoObject;
    SendMessageToWXReq *req = [[SendMessageToWXReq alloc] init];
    req.bText = NO;
    req.message = message;
    req.scene = WXSceneSession;
    [WXApi sendReq:req completion:^(BOOL success) {
        
    }];
    
}


#pragma mark ----- 网页类型分享示例
/**
 *  网页的url地址
 * @note 不能为空且长度不能超过10K
 *
 *  标题
 * @note 长度不能超过512字节
 *
 *  描述内容
 * @note 长度不能超过1K
 *
 *  缩略图数据
 * @note 大小不能超过64K
 *
 */
+ (void)toWXSendWebpageUrl:(NSString *)webpageUrlStr title:(NSString *)textStr des:(NSString *)desStr thumbimg:(NSString *)thumbimgstr
{
    WXWebpageObject *webpageObject = [WXWebpageObject object];
    webpageObject.webpageUrl = webpageUrlStr;//@"https://open.weixin.qq.com";
    WXMediaMessage *message = [WXMediaMessage message];
    message.title = textStr;//@"标题";
    message.description = desStr;//@"描述";
    [message setThumbImage:[UIImage imageNamed:thumbimgstr]];//@"缩略图.jpg"
    message.mediaObject = webpageObject;
    SendMessageToWXReq *req = [[SendMessageToWXReq alloc] init];
    req.bText = NO;
    req.message = message;
    req.scene = WXSceneSession;
    [WXApi sendReq:req completion:^(BOOL success) {
        
    }];
}

#pragma mark ----- 小程序类型分享示例
/**
 *  低版本网页链接
 * @attention 长度不能超过1024字节
 *  小程序username
 * @attention 小程序username
 *  小程序页面的路径
 * @attention 不填默认拉起小程序首页
 *  小程序新版本的预览图
 * @attention 大小不能超过128k
 *  小程序新版本的预览图
 * @attention 大小不能超过128k
 *  是否使用带 shareTicket 的转发
 * @attention 是否使用带 shareTicket 的转发
 *  分享小程序的版本
 * @attention （正式，开发，体验）
 *
 *  网页的url地址
 * @note 不能为空且长度不能超过10K
 *
 *  标题
 * @note 长度不能超过512字节
 *
 *  描述内容
 * @note 长度不能超过1K
 *
 *  缩略图数据
 * @note 大小不能超过64K
 *
 */
+ (void)toWXSendWebpageUrl:(NSString *)webpageUrlStr userName:(NSString *)userNameStr path:(NSString *)pathStr hdimgdata:(NSData *)hdImageData withShareTicket:(BOOL)withShareTicket miniProgramType:(WXMiniProgramType)programType title:(NSString *)textStr des:(NSString *)desStr
{
    WXMiniProgramObject *object = [WXMiniProgramObject object];
    object.webpageUrl = webpageUrlStr;//webpageUrl;
    object.userName = userNameStr;//userName;
    object.path = pathStr;//path;
    object.hdImageData = hdImageData;
    object.withShareTicket = withShareTicket;
    object.miniProgramType = programType;
    WXMediaMessage *message = [WXMediaMessage message];
    message.title = textStr;//@"小程序标题";
    message.description = desStr;//@"小程序描述";
    message.thumbData = nil;  //兼容旧版本节点的图片，小于32KB，新版本优先
                              //使用WXMiniProgramObject的hdImageData属性
    message.mediaObject = object;
    SendMessageToWXReq *req = [[SendMessageToWXReq alloc] init];
    req.bText = NO;
    req.message = message;
    req.scene = WXSceneSession;  //目前只支持会话
    [WXApi sendReq:req completion:^(BOOL success) {
        
    }];
}


#pragma mark ----- 音乐视频类型分享示例

/**
 *  该类型需要OpenSDK 1.8.9以及以上版本
 * WXMusicVideoObject 多媒体消息中包含的音乐视频数据对象
 *
 */

/*
+ (void)toWXSend
{
    WXMusicVideoObject *mvObject = [WXMusicVideoObject object];
    mvObject.musicUrl = @"音乐url";
    mvObject.musicDataUrl = @"音乐数据url";
    mvObject.singerName = @"歌手名";
    mvObject.duration = 60 * 1000; //音乐时长，毫秒
    mvObject.hdAlbumThumbData = hdAlbumThumbData; //高清专辑封面图
    mvObject.albumName = @"专辑名";
    mvObject.musicGenre = @"音乐流派";
    mvObject.issueDate = 1611116532; //发行时间Unix时间戳
    mvObject.identification = @"test-identification"; //音乐标识符

    WXMediaMessage *message = [WXMediaMessage message];
    message.title = @"歌曲名称";//必填，不能为空
    message.messageExt = @"额外信息"; //微信跳回时会带上

    [message setThumbImage:[UIImage imageNamed:@"缩略图.jpg"]];
    message.mediaObject = mvObject;
    SendMessageToWXReq *req = [[SendMessageToWXReq alloc] init];
    req.bText = NO;
    req.message = message;
    req.scene = WXSceneSession;
    [WXApi sendReq:req completion:^(BOOL success) {
        
    }];
}
#pragma mark ----- WXApiDelegate
- (void)onReq:(BaseReq *)req {
    if ([req isKindOfClass:[LaunchFromWXReq class]]) {
        LaunchFromWXReq *launchReq = (LaunchFromWXReq *)req;
        NSString* messageExt = launchReq.message.messageExt;  //分享到微信时的透传额外信息字字段
        if ([launchReq.message.mediaObject isKindOfClass:WXMusicVideoObject.class]) {
            WXMusicVideoObject *musicVideoObject = (WXMusicVideoObject *)launchReq.message.mediaObject;
            NSString *identification = musicVideoObject.identification; //分享到微信时的音乐标识符字段
            //应用可以根据messageExt和identification处理逻辑
        }
    }
}

*/

/// WXApiDelegate
- (void)onReq:(BaseReq *)req
{
    // =============== 获得的微信登录授权回调 ============
    if ([req isMemberOfClass:[SendAuthResp class]])
    {
        SendAuthResp *aresp = (SendAuthResp *)req;
        
    }
    
    // =============== 获得的微信支付回调 ============
    if ([req isKindOfClass:[PayResp class]])
    {
        
    }
    
}

@end

