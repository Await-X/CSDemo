// 

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN


@protocol XPFTopHeadImgVideoDelegate <NSObject>
/// 高度
- (void)onTopHeadImgVideoViewH:(CGFloat)frame;
/// 数据
- (void)onTopHeadImgAry:(NSArray *)imgAry video:(NSArray *)videoAry;

@optional

@end

@interface XPFTopHeadImgVideoView : UIView
/// 
- (instancetype)initWithFrame:(CGRect)frame SelectImgMax:(CGFloat)ImgMax SelectVideoMax:(CGFloat)VideoMax;
///
@property (nonatomic, weak) id<XPFTopHeadImgVideoDelegate> delegateImgVideo;

@end

NS_ASSUME_NONNULL_END
