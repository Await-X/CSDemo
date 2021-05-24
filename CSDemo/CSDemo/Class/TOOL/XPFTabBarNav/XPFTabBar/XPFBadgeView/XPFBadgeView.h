
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

IB_DESIGNABLE
@interface XPFBadgeView : UIView

@property (nonatomic, strong) IBInspectable UIColor *bgColor;
@property (nonatomic, strong) IBInspectable NSString *badgeValue;
@property (nonatomic, strong) IBInspectable UIColor *textColor;
@property (nonatomic, strong) IBInspectable UIFont *textFont;

@end

NS_ASSUME_NONNULL_END


/*
 XPFBadgeView *badgeView = [[XPFBadgeView alloc] initWithFrame:CGRectMake(100, 100, 0, 0)];
 badgeView.badgeValue = @"111";
 badgeView.textColor  = [UIColor blackColor];
 badgeView.textFont   = [UIFont systemFontOfSize:14];
 badgeView.bgColor    = [UIColor redColor];
 [badgeView sizeToFit];
 [self.view addSubview:badgeView];
 */
