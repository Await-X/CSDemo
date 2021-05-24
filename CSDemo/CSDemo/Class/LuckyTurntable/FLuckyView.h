// 底部view 承载

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface FLuckyView : UIView
/// 
@property (nonatomic, strong) NSArray *modelItemsArr;

@end

NS_ASSUME_NONNULL_END


#pragma mark ----- 使用方法
/*
 
 FLuckyView *luckyView = [[FLuckyView alloc] init];
 [self.view addSubview:luckyView];
 [luckyView mas_makeConstraints:^(MASConstraintMaker *make) {
     make.left.right.mas_equalTo(0);
     make.top.mas_equalTo(RATIOA(100));
     make.height.mas_equalTo(SW);
 }];
 luckyView.backgroundColor = [UIColor orangeColor];
 
 */
