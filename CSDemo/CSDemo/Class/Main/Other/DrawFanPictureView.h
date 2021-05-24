//
//  DrawFanPictureView.h
//  CSDemo
//
//  Created by apple on 2020/9/7.
//  Copyright © 2020 CS. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface DrawFanPictureView : UIView
/**
 *  扇形每部分所占比例和对应颜色dict
 *  key为比例数据     value为对应颜色值
 */
@property (nonatomic,strong)NSDictionary *dataDict;
@property (nonatomic) CGFloat startDegres;//设置起始弧度    系统默认水平右侧为0度开始弧度
@end

NS_ASSUME_NONNULL_END
