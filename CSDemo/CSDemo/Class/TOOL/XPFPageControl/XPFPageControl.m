//
//  XPFPageControl.m
//  CSDemo
//
//  Created by apple on 2021/1/14.
//  Copyright © 2021 CS. All rights reserved.
//

#import "XPFPageControl.h"

#define dotW 10
#define activeDotW 12
#define margin 10

@implementation XPFPageControl


- (void)layoutSubviews
{
    [super layoutSubviews]; 
    //计算圆点间距
    CGFloat marginX = margin + 5;
    //计算整个pageControll的宽度
    CGFloat newW = (self.subviews.count) * marginX;
    //设置新frame
    self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, newW, self.frame.size.height);
    //设置居中
    CGPoint center = self.center;
    center.x = self.superview.center.x;
    self.center = center;
    //遍历subview,设置圆点frame
    for (int i = 0; i < [self.subviews count]; i++) {
        UIImageView *dot = [self.subviews objectAtIndex:i];
        [dot setFrame:CGRectMake(i * marginX, dot.frame.origin.y, dotW*2, dotW)];
    }
}

////重写setCurrentPage方法，可设置圆点大小
//- (void)setCurrentPage:(NSInteger)page {
//    [super setCurrentPage:page];
//    
//    for (NSUInteger subviewIndex = 0; subviewIndex < [self.subviews count]; subviewIndex++)
//    {
//        UIImageView *subview = [self.subviews objectAtIndex:subviewIndex];
//        CGSize size;
//        size.height = 5;
//        size.width = 5;
//        [subview setFrame:CGRectMake(subview.frame.origin.x, subview.frame.origin.y, size.width,size.height)];
//    }
//}

@end
