//
//  DrawFanPictureView.m
//  CSDemo
//
//  Created by apple on 2020/9/7.
//  Copyright © 2020 CS. All rights reserved.
//

#import "DrawFanPictureView.h"

@interface DrawFanPictureView ()
@property (nonatomic) CGFloat pictureDataSum;//比例总和
@end
@implementation DrawFanPictureView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

- (void)setDataDict:(NSDictionary *)dataDict {
    _dataDict = dataDict;
    [self dataSum];
    //刷新view
    [self setNeedsDisplay];
}

//比例总和
- (void)dataSum {
    [_dataDict.allKeys enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        _pictureDataSum += [obj floatValue];
    }];
}
//绘图
- (void)drawRect:(CGRect)rect {
    //设置开始弧度
    CGFloat endDegres = 0+_startDegres;
    //提取比例数据
    NSArray *dataarr = _dataDict.allKeys;
    for (int i=0; i<dataarr.count; i++) {
        //求结束弧度
        endDegres += M_PI*2*((CGFloat)[dataarr[i] floatValue]/_pictureDataSum);
        
        UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:CGPointMake(self.frame.size.width/2, self.frame.size.height/2) radius:MIN(self.frame.size.width/2, self.frame.size.height/2) startAngle:_startDegres endAngle:endDegres clockwise:YES];
        [path addLineToPoint:CGPointMake(self.frame.size.width/2, self.frame.size.height/2)];
        
#if 1
        CAShapeLayer *layer = [CAShapeLayer layer];
        layer.frame = self.bounds;
        UIColor *color = _dataDict[dataarr[i]];
        layer.fillColor = [UIColor redColor].CGColor;//设置填充颜色
        layer.path = path.CGPath;
        
        [self.layer addSublayer:layer];
#else
        UIColor *color = _dataDict[dataarr[i]];
        //设置填充颜色
        [color setFill];
        //开始填充
        [path fill];
#endif
        //重新设定开始弧度
        _startDegres = endDegres;
    }
}

@end
