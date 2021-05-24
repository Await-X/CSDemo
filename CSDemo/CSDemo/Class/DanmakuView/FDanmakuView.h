//

#import <UIKit/UIKit.h>
#import "FDanmakuModelProtocol.h"

@protocol FDanmakuViewProtocol <NSObject>
/// 
@property (nonatomic, readonly) NSTimeInterval currentTime;
/// 方便扩展视图
- (UIView *)danmakuViewWithModel:(id<FDanmakuModelProtocol>)model;
/// 点击回调
- (void)danmuViewDidClick:(UIView *)danmuView at:(CGPoint)point model:(id<FDanmakuModelProtocol>)model;

@end

@interface FDanmakuView : UIView
///
@property (nonatomic, weak) id<FDanmakuViewProtocol> delegate;
///
@property (nonatomic, strong) NSMutableArray <id <FDanmakuModelProtocol>> *modelsArr;
/// 设置弹幕行数
@property (nonatomic, assign) int kDandaoCountSs;
/// 暂停
- (void)pause;
/// 继续
- (void)resume;

@end
