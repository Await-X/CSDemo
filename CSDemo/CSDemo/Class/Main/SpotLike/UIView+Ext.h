//
//  UIView+Ext.h
//  JiemoTimeDifference
//
//  Created by ios_dev on 2018/7/20.
//  Copyright © 2018年 ios_dev. All rights reserved.
//

#import <UIKit/UIKit.h>

CGPoint CGRectGetCenter(CGRect rect);
CGRect  CGRectMoveToCenter(CGRect rect, CGPoint center);

@interface UIView (Ext)

@property CGPoint origin;
@property CGSize size;

@property (readonly) CGPoint bottomLeft;
@property (readonly) CGPoint bottomRight;
@property (readonly) CGPoint topRight;

@property CGFloat height;
@property CGFloat width;

@property CGFloat top;
@property CGFloat left;

@property CGFloat bottom;
@property CGFloat right;

@property CGFloat centerX;
@property CGFloat centerY;

@property (nonatomic, assign) CGFloat x;
@property (nonatomic, assign) CGFloat y;


- (void)moveBy:(CGPoint)delta;
- (void)scaleBy:(CGFloat)scaleFactor;
- (void)fitInSize:(CGSize)aSize;

- (UIViewController *)viewController;

-(void)addCornerRadius:(CGFloat)value;
-(void)addCornerRadius:(CGFloat)value borderColor:(UIColor *)color borderWidth:(CGFloat)width;
@end
