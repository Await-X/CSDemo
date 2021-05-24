// 

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class CarouselViewTool;

@protocol CarouselViewDelegate <NSObject>

@optional
/**
 *  点击图片的回调事件
 */
- (void)carouselView:(CarouselViewTool *)carouselView indexOfClickedImageBtn:(NSUInteger)index;

@end

@interface CarouselViewTool : UIView

@property (nonatomic, strong) UIImageView *originIV;
/// 传入图片数组
@property (nonatomic, copy) NSArray *images;
/// pageControl颜色设置
@property (nonatomic, strong) UIColor *currentPageColor;

@property (nonatomic, strong) UIColor *pageColor;
/// 是否竖向滚动
@property (nonatomic, assign, getter=isScrollDorectionPortrait) BOOL scrollDorectionPortrait;
///
@property (nonatomic, strong) id<CarouselViewDelegate> delegate;
///
- (UIImageView *)imageViewWithIndex:(NSInteger)index;

@end

NS_ASSUME_NONNULL_END
