/*
 移动应用
 微信文档: https://developers.weixin.qq.com/doc/oplatform/Mobile_App/Share_and_Favorites/iOS.html
*/

#import <Foundation/Foundation.h>
#import <WXApi.h> //微信SDK

NS_ASSUME_NONNULL_BEGIN

@interface XShareSend : NSObject <WXApiDelegate>

/// 检查微信是否已被用户安装
+ (BOOL)toWXAppInstalled;
/// 判断当前微信的版本是否支持OpenApi
+ (BOOL)toWXAppSupportApi;
/// 文字类型分享示例
+ (void)toWXSendSceneSessionText:(NSString *)textStr;
/// 图片类型分享示例
+ (void)toWXSendMessageImg:(UIImage *)img filePath:(NSString *)filePathStr;
/// 音乐类型分享示例
+ (void)toWXSendMusicURL:(NSString *)musicUrl musicDataUrl:(NSString *)musicDataUrl musicTitle:(NSString *)musicText musicdes:(NSString *)desStr thumbimg:(NSString *)thumbimgstr;
///视频类型分享示例
+ (void)toWXSendvideoUrl:(NSString *)videoUrlStr videoLowBandUrl:(NSString *)videoLowBandUrlStr title:(NSString *)videoText des:(NSString *)desStr thumbimg:(NSString *)thumbimgStr;
/// 网页类型分享示例
+ (void)toWXSendWebpageUrl:(NSString *)webpageUrlStr title:(NSString *)textStr des:(NSString *)desStr thumbimg:(NSString *)thumbimgstr;
/// 小程序类型分享示例
+ (void)toWXSendWebpageUrl:(NSString *)webpageUrlStr userName:(NSString *)userNameStr path:(NSString *)pathStr hdimgdata:(NSData *)hdImageData withShareTicket:(BOOL)withShareTicket miniProgramType:(WXMiniProgramType)programType title:(NSString *)textStr des:(NSString *)desStr;


@end

NS_ASSUME_NONNULL_END
