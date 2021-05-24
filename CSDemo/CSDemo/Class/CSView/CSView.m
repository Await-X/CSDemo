//
//  CSView.m
//  CSDemo
//
//  Created by apple on 2021/3/30.
//  Copyright © 2021 CS. All rights reserved.
//

#import "CSView.h"

@implementation CSView


- (instancetype)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}

- (void)drawRect:(CGRect)rect
{
//    [self onSanJiaoXing];
//    [self onChangFangXing];
    
    [self onTPimg];
    
}

- (void)onTPimg
{
    UIImage *img = [UIImage imageNamed:@"lufei"];
    CGImageRef image = img.CGImage;
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSaveGState(context);
    
    CGContextTranslateCTM(context, 0, 150);
    CGContextScaleCTM(context, 1, -1);
    
    //CGRect touchrect = CGRectMake(0, 0, img.size.width, img.size.height);
    CGRect touchrect = CGRectMake(0, 0, 150, 150);
    CGContextDrawImage(context, touchrect, image);
    
    CGContextRestoreGState(context);
    
}


- (void)onChangFangXing
{
    // 创建图形上下文对象
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextMoveToPoint(context, 150 + 75, 0);
    CGContextAddLineToPoint(context, 150 + 75 + 20, 0);
    CGContextAddLineToPoint(context, 150 + 75 + 20, 150);
    CGContextAddLineToPoint(context, 150 + 75, 150);
    // 添加
    CGContextClosePath(context);
    
    // 设置 黑色描边参数
    [[UIColor blackColor] setStroke];
    // 填充颜色
    [[UIColor greenColor] setFill];
    // 保存 Save
    CGContextSaveGState(context);
    // 设置红色条填充参数
    [[UIColor redColor] setFill];
    // 还原 Restore
    CGContextRestoreGState(context);
    // 绘制路径
    CGContextDrawPath(context, kCGPathFillStroke);
    
}

- (void)onSanJiaoXing
{
    
    // 创建图形上下文对象
    CGContextRef context = UIGraphicsGetCurrentContext();
    // 三角形 顶点
    CGContextMoveToPoint(context, 75, 0);
    // 三角形 左点
    CGContextAddLineToPoint(context, 0, 150);
    // 三角形 右点
    CGContextAddLineToPoint(context, 150, 150);
    // 添加
    CGContextClosePath(context);
    
    
    // 设置 黑色描边参数
    [[UIColor blackColor] setStroke];
    // 填充颜色
    [[UIColor greenColor] setFill];
    // 保存 Save
    CGContextSaveGState(context);
    // 设置红色条填充参数
    [[UIColor redColor] setFill];
    // 还原 Restore
    CGContextRestoreGState(context);
    // 绘制路径
    CGContextDrawPath(context, kCGPathFillStroke);
    
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
