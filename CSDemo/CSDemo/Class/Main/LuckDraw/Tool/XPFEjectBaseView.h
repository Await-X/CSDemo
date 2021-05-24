//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface XPFEjectBaseView : UIView

/// 预先创建一个弹出View
/// @param superView 创建在父试图上，可以为nil  为nil创建在window上
- (instancetype)initShowAlertViewSuperView:(nullable UIView *)superView;

/// 展示View
- (void)showAlertView;

/// 隐藏View
- (void)hiddenAlertView;

@end

NS_ASSUME_NONNULL_END
