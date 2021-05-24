//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface XShareItem : UIButton
///
@property (nonatomic, assign) int btnIndex;
///
- (void)setTitle:(NSString *)title image:(UIImage *)image;

@end

NS_ASSUME_NONNULL_END
