// 

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface XYouthView : UIView

/// 预先创建一个弹出View
/// @param superView 创建在父试图上，可以为nil  为nil创建在window上
- (instancetype)initShowYouthAlertViewSuperView:(nullable UIView *)superView;

/// 展示View
- (void)showAlertView;

/// 隐藏View
- (void)hiddenAlertView;

@end

NS_ASSUME_NONNULL_END
