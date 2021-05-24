//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface XPFSlidePopupView : UIView

+ (instancetype)popupViewWithFrame:(CGRect)frame contentView:(UIView *)contentView;

- (instancetype)initWithFrame:(CGRect)frame contentView:(UIView *)contentView;

- (void)showFrom:(UIView *)fromView completion:(void (^)(void))completion;

- (void)dismiss;

@end

NS_ASSUME_NONNULL_END
