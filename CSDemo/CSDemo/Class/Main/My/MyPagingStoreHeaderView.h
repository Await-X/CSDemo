//
//  MyPagingStoreHeaderView.h
//  YGVideo
//
//  Created by apple on 2020/10/30.
//  Copyright © 2020 YG. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MyPagingStoreHeaderView : UIView
///
@property (nonatomic, strong) UIImageView *imageView;
///
@property (nonatomic, strong) UIButton *btn;
///
@property (nonatomic, strong) UIImageView *topImageView;
///
@property (nonatomic, strong) UILabel *nickLabel;

- (void)scrollViewDidScroll:(CGFloat)contentOffsetY;

@end

NS_ASSUME_NONNULL_END
