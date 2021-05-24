// 

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
/*
  需求
    第一种 右侧 没有内容
    第二种 右侧 可以点击 并且修改 右侧分类内容
    第三种 左侧 有个星号 必填 和选填的图片
*/

typedef NS_ENUM(NSInteger, TitleType) {
    TitleType_None = 0, // 右侧 没有内容
    TitleType_View = 1, // 右侧 可以点击 并且修改 右侧分类内容
};
/// 左侧 可以点击事件
typedef void(^TopHeadTitleViewRBtnClickBlock)(NSInteger index);

@interface XPFTopHeadTitleView : UIView
/// whether（左侧有个星号必填/选填的图片) type（第一种右侧没有内容，第二种右侧可以点击并且修改右侧分类内容）
- (instancetype)initWithFrame:(CGRect)frame mustImg:(BOOL)whether titleName:(NSString *)titleStr type:(TitleType)type;
///
@property (nonatomic, strong) TopHeadTitleViewRBtnClickBlock RBtnClickBlock;
/// 切换选中的分类
- (void)x_modifySelectClassification:(NSString *)select;

@end

NS_ASSUME_NONNULL_END
