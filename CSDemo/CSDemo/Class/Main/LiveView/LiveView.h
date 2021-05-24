//
//  LiveView.h
//  CSDemo
//
//  Created by apple on 2021/4/29.
//  Copyright © 2021 CS. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol NTESLikeViewProtocol;

@interface LiveView : UIView

@property (nonatomic, weak) id <NTESLikeViewProtocol> delegate;

- (void)hiddenButton:(BOOL)isHidden;

- (void)fireLike;

@end

@protocol NTESLikeViewProtocol <NSObject>

- (void)likeViewSendZan:(LiveView *)likeView;

@end

NS_ASSUME_NONNULL_END
