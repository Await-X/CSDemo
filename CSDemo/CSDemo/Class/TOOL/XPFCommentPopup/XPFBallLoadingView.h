// 

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface XPFBallLoadingView : UIView

+ (instancetype)loadingViewInView:(UIView *)view;

- (void)startLoadingWithProgress:(CGFloat)progress;

- (void)startLoading;
- (void)stopLoading;

@end

NS_ASSUME_NONNULL_END
