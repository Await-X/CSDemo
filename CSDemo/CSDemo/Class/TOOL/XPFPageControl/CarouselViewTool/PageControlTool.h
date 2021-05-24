// 

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface PageControlTool : UIView 
/// 数量 “点”
@property (nonatomic, assign) int numberOfPages;
/// 选中的那个 “点”
@property (nonatomic, assign) int currentPage;
/// 未选中的颜色
@property (nonatomic, strong) UIColor *otherDotColor;
/// 选中的颜色
@property (nonatomic, strong) UIColor *currentDotColor;
/// 全部点的 圆角
@property (nonatomic, assign) CGFloat cornerRadius;
/// 选中的 “点” 宽
@property (nonatomic, assign) CGFloat currentDotWidth;
/// 未选中的  “点” 宽
@property (nonatomic, assign) CGFloat otherDotWidth;
/// 所有 “点” 高
@property (nonatomic, assign) CGFloat dotHeight;
/// “点” 与 “点” 间距
@property (nonatomic, assign) CGFloat dotSpace;

@end

NS_ASSUME_NONNULL_END

/*
#import "PageControlTool.h"
 
 
 
 */
