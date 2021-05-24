// 

#import "DarkPink.h"

@implementation DarkPink

#pragma mark ----- shared
///
+ (DarkPink *)shared {
    static DarkPink *user;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        user = [[self alloc] init];
    });
    return user;
}


- (UIColor *)dg_BackgroundColor
{
    //return [self colorWithArray:@[@"#FFFFFF", @"#000000"]];
    return [self colorWithArray:@[@"#8B008B", @"#0000FF"]];
    
}

- (UIColor *)dg_TextColor
{
    //return [self colorWithArray:@[@"#FFFFFF", @"#000000"]];
    return [self colorWithArray:@[@"#DC143C", @"#FFB6C1"]];
    
}

#pragma mark ----- 颜色
///
- (UIColor *)colorWithArray:(NSArray *)colorArray
{
    if (colorArray == nil || colorArray.count == 0)
    {
        return [UIColor whiteColor];
    }
    
    if (@available(iOS 13.0, *)) {
        UIColor *color = [UIColor colorWithDynamicProvider:^UIColor * _Nonnull(UITraitCollection * _Nonnull traitCollection)
        {
            if (traitCollection.userInterfaceStyle == UIUserInterfaceStyleLight)
            {// 颜色模式
                return [UIColor colorWithHexString:colorArray.firstObject] ;
            }
            else if (traitCollection.userInterfaceStyle == UIUserInterfaceStyleDark)
            {// 深色模式
                return  [UIColor colorWithHexString:colorArray.lastObject];
            }
            // 读取系统颜色
            return [UIColor whiteColor];
        }];
        return color;
    }
    return [UIColor whiteColor];
}





@end
