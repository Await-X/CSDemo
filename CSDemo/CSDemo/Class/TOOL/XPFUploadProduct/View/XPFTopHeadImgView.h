// 

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol XPFTopHeadImgDelegate <NSObject>
/// 高度
- (void)onTopHeadImgViewH:(CGFloat)frame;
/// 数据
- (void)onTopHeadImgAryS:(NSArray *)imgAry;

@optional

@end

@interface XPFTopHeadImgView : UIView
///
- (instancetype)initWithFrame:(CGRect)frame SelectImgMax:(CGFloat)ImgMax;
///
@property (nonatomic, weak) id<XPFTopHeadImgDelegate> delegateImg;

@end

NS_ASSUME_NONNULL_END
