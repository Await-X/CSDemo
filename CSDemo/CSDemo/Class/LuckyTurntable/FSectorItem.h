// 扇形 item

#import <UIKit/UIKit.h>
#import "FItemModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface FSectorItem : UIView
//
///// 背景 颜色
//@property (nonatomic, strong) UIColor *bgColor;
///// 背景 图片
//@property (nonatomic, strong) UIImage *bgImg;

/// item 数据
@property (nonatomic, strong) NSArray *itemAry;
/// 半径
@property (nonatomic, assign) CGFloat radius;

@end

NS_ASSUME_NONNULL_END
