// 

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface XPFTabBar : UITabBar
///
@property (nonatomic, assign) NSInteger tabBarNumber;
///
@property (nonatomic, copy) void(^didMiddBtn)(void);

@end

NS_ASSUME_NONNULL_END
