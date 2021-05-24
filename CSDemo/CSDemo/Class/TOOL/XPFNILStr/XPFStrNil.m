//
//  XPFStrNil.m
//  YGVideo
//
//  Created by apple on 2019/9/10.
//  Copyright © 2019 YG. All rights reserved.
//

#import "XPFStrNil.h"

static NSString *str0 = @"";
static NSString *str1 = @"";

@implementation XPFStrNil

/// 返回 @" "
+ (NSString *)xpf_strReturn0:(NSString *)str {
    return [self modifyStr:str1 originalStr:str];
}

/// 返回 str  入参 原值{
+ (NSString *)xpf_strOriginalValue:(NSString *)str {
    return [self modifyStr:str0 originalStr:str];
}

/// str 是 要修改的字符串  ， original 原值
+ (NSString *)modifyStr:(NSString *)original originalStr:(NSString *)str {
    if ([str isEqualToString:@" "]) {
        return original;
    }
    if ([str isEqualToString:@""]) {
        return original;
    }
    if ([str isEqualToString:@"nil"]) {
        return original;
    }
    if ([str isEqualToString:@"<nill>"]) {
        return original;
    }
    if ([str isEqualToString:@"(null)"]) {
        return original;
    }
    if ([str isEqualToString:@"null"]) {
        return original;
    }
    if (str == nil) {
        return original;
    }
    if (str == Nil) {
        return original;
    }
    if (str == NULL) {
        return original;
    }
    if ([str isEqual:[NSNull null]]) {
        return original;
    }
    if ([str isKindOfClass:[NSNull class]]) {
        return original;
    }
    return str;
}

/// 判断是否有内容 (yes 没有) (no 有)
+ (BOOL)xpf_isEmptyStrlength0:(NSString *)str
{
    if (str.length != 0) {
        return NO;
    }
    return YES;
}


/// 判断内容是否全部为空格 (yes 全部为空格) (no 不是)
+ (BOOL)xpf_isEmptyStr:(NSString *)str
{
    if (!str)
    {
        return true;
    }
    else
    {
        //A character set containing only the whitespace characters space (U+0020) and tab (U+0009) and the newline and next line characters (U+000A–U+000D,U+0085).
        NSCharacterSet *set = [NSCharacterSet whitespaceAndNewlineCharacterSet];
        //Returns a new string made by removing from both ends of the receiver characters contained in a given character set.
        NSString *trimedString = [str stringByTrimmingCharactersInSet:set];
        if ([trimedString length] == 0)
        {
            return true;
        }
        else
        {
            return false;
        }
    }
}

#pragma mark ----- 计算文字的高度
+ (CGFloat)x_getSizeForLabString:(NSString *)labStr font:(UIFont *)fontInt width:(CGFloat)width
{
    NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc]initWithString:labStr];
    NSRange allRange = [labStr rangeOfString:labStr];
    [attrStr addAttribute:NSFontAttributeName value:fontInt range:allRange];
    CGFloat titleHeight;
    NSStringDrawingOptions options = NSStringDrawingUsesLineFragmentOrigin |NSStringDrawingUsesFontLeading;
    CGRect rect = [attrStr boundingRectWithSize:CGSizeMake(width, CGFLOAT_MAX) options:options context:nil];
    titleHeight = ceilf(rect.size.height);
    return titleHeight; //加两个像素,防止emoji被切掉.
}

+ (CGFloat)x_getSizeForLabString:(NSString *)labStr font:(UIFont *)fontInt height:(CGFloat)height
{
    NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc]initWithString:labStr];
    NSRange allRange = [labStr rangeOfString:labStr];
    [attrStr addAttribute:NSFontAttributeName value:fontInt range:allRange];
    CGFloat titleWidth;
    NSStringDrawingOptions options = NSStringDrawingUsesLineFragmentOrigin |NSStringDrawingUsesFontLeading;
    CGRect rect = [attrStr boundingRectWithSize:CGSizeMake(CGFLOAT_MAX, height) options:options context:nil];
    titleWidth = ceilf(rect.size.width);
    return titleWidth; //加两个像素,防止emoji被切掉.
}


@end
