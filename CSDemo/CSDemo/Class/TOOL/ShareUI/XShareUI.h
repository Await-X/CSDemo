/*
 WeakSelf;
 NSArray *titleAry = @[@"好友", @"朋友圈", @"群"];
 NSArray *iconAry = @[@"icon_heart_1", @"icon_heart_2", @"icon_heart_3"];
 XShareUI *shareV = [[XShareUI alloc] initWithTitles:titleAry iconNames:iconAry];
 [shareV showActionSharePopupChoiceWithClickBlock:^(int btnIndex) {
     //
     NSLog(@" ==这个按钮== %d", btnIndex);
 } cancelBlock:^{
     //
 }];
 */

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

///
typedef void(^ClickBlock)(int btnIndex);
///
typedef void(^CancelBlock)(void);
///
@interface XShareUI : UIWindow
///
- (instancetype)initWithTitles:(NSArray *)titles iconNames:(NSArray *)iconNames;
///
- (void)showActionSharePopupChoiceWithClickBlock:(ClickBlock)clickBlock cancelBlock:(CancelBlock)cancelBlock;

@end

NS_ASSUME_NONNULL_END
