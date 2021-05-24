//
//  PagingViewTableHeaderView.h
//  JXCategoryView
//
//  Created by jiaxin on 2018/8/27.
//  Copyright © 2018年 jiaxin. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^ImageButtonClickBlock)(NSInteger index);

@interface PagingViewTableHeaderView : UIView
/// 按钮点击 图片 做事情
@property (nonatomic,strong) ImageButtonClickBlock clickBlock;
///
@property (nonatomic, strong) UIImageView *imageView;
///
@property (nonatomic, strong) UIButton *btn;
///
@property (nonatomic, strong) UILabel *nickLabel;

- (void)scrollViewDidScroll:(CGFloat)contentOffsetY;

@end
