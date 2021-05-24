//
//  XPFStrNil.h
//  YGVideo
//
//  Created by apple on 2019/9/10.
//  Copyright © 2019 YG. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface XPFStrNil : NSObject

/// 返回 str  入参 原值 返回 @"--"
+ (NSString *)xpf_strOriginalValue:(NSString *)str;
/// 返回 @" "
+ (NSString *)xpf_strReturn0:(NSString *)str;
/// 判断内容是否全部为空格 (yes 全部为空格) (no 不是)
+ (BOOL)xpf_isEmptyStr:(NSString *)str;
/// 判断是否有内容 (yes 没有) (no 有)
+ (BOOL)xpf_isEmptyStrlength0:(NSString *)str;
/// 计算文字的高度
+ (CGFloat)x_getSizeForLabString:(NSString *)labStr font:(UIFont *)fontInt width:(CGFloat)width;
+ (CGFloat)x_getSizeForLabString:(NSString *)labStr font:(UIFont *)fontInt height:(CGFloat)height;

@end

NS_ASSUME_NONNULL_END
