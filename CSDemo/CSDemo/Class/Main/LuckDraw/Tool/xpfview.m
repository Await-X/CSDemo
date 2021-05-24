// 

#import "xpfview.h"

@interface xpfview ()
///
@property (nonatomic, assign) NSInteger indexStr;

@end

@implementation xpfview

- (instancetype)initWithFrame:(CGRect)frame index:(NSInteger)index {
    if (self = [super initWithFrame:frame]) {
        self.indexStr = index;
        self.backgroundColor = [UIColor cyanColor];
        self.userInteractionEnabled = YES;
    }
    return self;
}
 

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event
{
    UIView *hitView = [super hitTest:point withEvent:event];
    if (hitView == self) {
        return nil;
    }
    return hitView;
}

- (void)drawRect:(CGRect)rect
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextBeginPath(context);
    /*
    CGContextMoveToPoint(context, rect.size.width*0.5, 0);//设置起始位置
    CGContextAddLineToPoint(context, 0, rect.size.height);//从起始位置到这个点连线
    CGContextAddLineToPoint(context, rect.size.width - 0, rect.size.height);
    */
    
    CGContextMoveToPoint(context, rect.size.width, 0);//设置起始位置
    CGContextAddLineToPoint(context, 0, 0);//从起始位置到这个点连线
    CGContextAddLineToPoint(context, rect.size.width*0.5, rect.size.height);
    
    CGContextClosePath(context);//结束画线..自动封闭  不写也可封闭
    
    if (self.indexStr % 2 == 0)
    { // 取整 NSLog(@" 取整 %d", i);
        [[UIColor grayColor] setFill];
    }
    else
    { // 取余 NSLog(@" 取余 %d", i);
        [[UIColor redColor] setFill];
    }
    /*
    NSInteger aRedValue = arc4random() % 255;
    NSInteger aGreenValue = arc4random() % 255;
    NSInteger aBlueValue = arc4random() % 255;
    //UIColor *randColor =
    [[UIColor colorWithRed:aRedValue / 255.0f green:aGreenValue / 255.0f blue:aBlueValue / 255.0f alpha:1.0f] setFill];
    */
    //[[UIColor redColor] setFill]; //设置填充色 不设置默认黑色
    [[UIColor clearColor] setStroke];//边框颜色，不设置默认黑色
    CGContextDrawPath(context, kCGPathFillStroke);//绘制路径
}

+ (UIColor *)RandomColor
{
    NSInteger aRedValue = arc4random() % 255;
    NSInteger aGreenValue = arc4random() % 255;
    NSInteger aBlueValue = arc4random() % 255;
    UIColor *randColor = [UIColor colorWithRed:aRedValue / 255.0f green:aGreenValue / 255.0f blue:aBlueValue / 255.0f alpha:1.0f];
    return randColor;
}

@end
