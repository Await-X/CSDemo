//
//  UIColor+XPF.h
//  YGVideo
//
//  Created by apple on 2019/8/26.
//  Copyright © 2019 YG. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIColor (Xpf)
    
/// 透明度固定为1，以0x开头的十六进制转换成的颜色
+ (UIColor *)colorWithHex:(long)hexColor;
/// 0x开头的十六进制转换成的颜色,透明度可调整
+ (UIColor *)colorWithHex:(long)hexColor alpha:(float)opacity;
/// 颜色转换三：iOS中十六进制的颜色（以#开头）转换为UIColor
+ (UIColor *)colorWithHexString:(NSString *)color;
+ (UIColor *)colorWithHexString:(NSString *)color alpha:(float)alpha;
    
/// 根据图片获取图片的主色调
//+ (void)mostColorWithImage:(UIImage*)image resultColor:(ObjBlock)block;
/// 获取灰色背景
+ (UIImage *)changeGrayImage:(UIImage *)oldImage;
/// 随机色
+ (UIColor*)xpf_randomColor;

@end

NS_ASSUME_NONNULL_END
