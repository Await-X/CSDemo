//

#import "UIColor+XPFRandomColor.h"

@implementation UIColor (XPFRandomColor)

+ (UIColor*)xpf_randomColor
{
    CGFloat hue        = (arc4random() %256/256.0);
    CGFloat saturation = (arc4random() %128/256.0) + 0.5;
    CGFloat brightness = (arc4random() %128/256.0) + 0.5;
    UIColor *color = [UIColor colorWithHue:hue saturation:saturation brightness:brightness alpha:1];
    return color;
}

@end
