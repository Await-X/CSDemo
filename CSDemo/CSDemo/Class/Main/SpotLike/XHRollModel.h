//
//  XHRollModel.h
//  CSDemo
//
//  Created by apple on 2021/3/16.
//  Copyright © 2021 CS. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface XHRollModel : NSObject
/// 用户名称
@property (nonatomic, strong) NSString *name;
/// 类型名称 - 金豆、钱、 这样的文字
@property (nonatomic, strong) NSString *typeName;
/// 类型图片
@property (nonatomic, strong) NSString *typeImg;
/// 获得 数量
@property (nonatomic, strong) NSString *numbers;
/// 宽度
@property (nonatomic, assign) CGFloat widths;
/// 宽度 数量
@property (nonatomic, assign) CGFloat numberwidths;
/// 宽度 图片
@property (nonatomic, assign) CGFloat typeImgwidths;
/// lable.attributenText 富文本展示
@property (nonatomic, strong) NSMutableAttributedString *attributedtexts;
/// 文字
@property (nonatomic, strong) NSString *nameContText;

@end

NS_ASSUME_NONNULL_END
