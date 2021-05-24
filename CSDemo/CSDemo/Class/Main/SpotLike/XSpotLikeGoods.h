// 点赞 漂浮 的 UI

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
// 方向
typedef NS_ENUM(NSUInteger, directionType) {
    directionType_H = 1, // 横着
    directionType_S = 2, // 竖着
};
// 货币种类
typedef NS_ENUM(NSUInteger, showImgType) {
    showImgType_Golds = 1, // 金币
    showImgType_Beans = 2, // 金豆
    showImgType_Money = 3, // 钱
};

@interface XSpotLikeGoods : UIView
///
- (instancetype)initWithFrame:(CGRect)frame directionType:(directionType)type;

#pragma mark ----- 竖滑
/// 标识 展示什么图片
@property (nonatomic, strong) NSString *showImg;
@property (nonatomic, assign) showImgType showTypeImg;
/// 获得的（金币、钱、金豆）数量
@property (nonatomic, strong) NSString *showMoney;
/// 开始播放滚动 duration 持续时间 固定3秒 可扩展
- (void)showSStartPlayDuration:(NSInteger)duration;

#pragma mark ----- 横滑
/// 开始播放滚动 duration 持续时间 固定3秒 可扩展
//- (void)showHStartPlayDuration:(NSInteger)duration;
/**
 *  添加把数据数组
 *  name
 *  typeName 点赞 金豆 金币 钱 ...
 *  typeImg 图片 地址
 *  numbers 获得数量
 */
- (void)addHDataName:(NSString *)name type:(NSString *)typeName typeImg:(NSString *)typeImg number:(NSString *)numbers;

@end

NS_ASSUME_NONNULL_END
