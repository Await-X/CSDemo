//
//  BaseWateCollectionLayout.m
//  YiShare
//
//  Created by zhang on 2019/6/10.
//  Copyright © 2019 zhangqiang. All rights reserved.
//

/** 默认的列数*/
static const NSInteger WSLDefaultColumeCount = 2;
/** 默认的行数*/
static const NSInteger WSLDefaultRowCount = 0;
/** 每一列之间的间距*/
static const NSInteger WSLDefaultColumeMargin = 0;
/** 每一行之间的间距*/
static const CGFloat WSLDefaultRowMargin = 0;
/** 边缘之间的间距*/
static const UIEdgeInsets WSLDefaultEdgeInset = {0, 0, 0, 0};

#import "BaseWateCollectionLayout.h"

@interface BaseWateCollectionLayout ()
/** 存放所有cell的布局属性*/
@property (strong, nonatomic) NSMutableArray *attrsArray;

/** 存放每一列的最大y值*/
@property (nonatomic, strong) NSMutableArray *columnHeights;
/** 存放每一行的最大x值*/
@property (nonatomic, strong) NSMutableArray *rowWidths;

/** 内容的高度*/
@property (nonatomic, assign) CGFloat maxColumnHeight;

@property (nonatomic,assign) CGFloat containerHeight;

/** 列数*/
-(NSInteger)columnCount;
/** 行数*/
-(NSInteger)rowCount;

/** 每一行之间的间距*/
-(CGFloat)rowMargin;
/** 每一列之间的间距*/
-(CGFloat)columnMargin;
/** 边缘之间的间距*/
-(UIEdgeInsets)edgeInsets;
@end

@implementation BaseWateCollectionLayout

-(CGFloat)columnMargin {
    if ([self.delegate respondsToSelector:@selector(columnMarginInWaterFlowLayout:)]) {
        return [self.delegate columnMarginInWaterFlowLayout:self];
    } else {
        return  WSLDefaultColumeMargin;
    }
}

-(CGFloat)rowMargin {
    if ([self.delegate respondsToSelector:@selector(rowMarginInWaterFlowLayout:)]) {
        return [self.delegate rowMarginInWaterFlowLayout:self];
    } else {
        return WSLDefaultRowMargin;
    }
}

-(NSInteger)columnCount {
    if ([self.delegate respondsToSelector:@selector(columnCountInWaterFlowLayout:)]) {
        return [self.delegate columnCountInWaterFlowLayout:self];
    } else {
        return  WSLDefaultColumeCount;
    }
}

-(NSInteger)rowCount{
    
    if ([self.delegate respondsToSelector:@selector(rowCountInWaterFlowLayout:)]) {
        return [self.delegate rowCountInWaterFlowLayout:self];
    } else {
        return  WSLDefaultRowCount;
    }
}

-(UIEdgeInsets)edgeInsets {
    if ([self.delegate respondsToSelector:@selector(edgeInsetInWaterFlowLayout:)]) {
        return [self.delegate edgeInsetInWaterFlowLayout:self];
    } else {
        return  WSLDefaultEdgeInset;
    }
}

#pragma mark - 懒加载
- (NSMutableArray *)columnHeights {
    if (!_columnHeights) {
        _columnHeights = [NSMutableArray array];
    }
    return _columnHeights;
}
- (NSMutableArray *)rowWidths {
    if (!_rowWidths) {
        _rowWidths = [NSMutableArray array];
    }
    return _rowWidths;
}

-(NSMutableArray *)attrsArray {
    if (_attrsArray == nil) {
        _attrsArray = [NSMutableArray array];
    }
    return _attrsArray;
}

#pragma mark - 重写系统方法

/** 初始化 生成每个视图的布局信息*/
-(void)prepareLayout {
    
    [super prepareLayout];
    
    //清除以前计算的所有高度
    self.maxColumnHeight = 0;
    // 记录非瀑布流的高度
    self.containerHeight = 0;
    [self.columnHeights removeAllObjects];
    for (NSInteger i = 0; i < self.columnCount; i++) {
        [self.columnHeights addObject:@(self.edgeInsets.top)];
    }
    
    //清除之前数组
    [self.attrsArray removeAllObjects];
    
    //开始创建每一组cell的布局属性
    NSInteger sectionCount =  [self.collectionView numberOfSections];
    for(NSInteger section = 0; section < sectionCount; section++){
        //开始创建组内的每一个cell的布局属性
        NSInteger rowCount = [self.collectionView numberOfItemsInSection:section];
        for (NSInteger row = 0; row < rowCount; row++) {
            //创建位置
            NSIndexPath *indexPath = [NSIndexPath indexPathForItem:row inSection:section];
            //获取indexPath位置cell对应的布局属性
            UICollectionViewLayoutAttributes *attrs = [self layoutAttributesForItemAtIndexPath:indexPath];
            [self.attrsArray addObject:attrs];
        }
    }
}

/** 决定一段区域所有cell和头尾视图的布局属性*/
-(NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect {
    return self.attrsArray;
}

/** 返回indexPath位置cell对应的布局属性*/
-(UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath {
    //设置布局属性
    UICollectionViewLayoutAttributes *attrs = [UICollectionViewLayoutAttributes  layoutAttributesForCellWithIndexPath:indexPath];
    
    attrs.frame = [self itemFrameOfVerticalWaterFlow:indexPath];
    
    return attrs;
}

//返回内容高度
-(CGSize)collectionViewContentSize {
    
    return CGSizeMake(0, self.maxColumnHeight + self.edgeInsets.bottom + self.containerHeight);
}

#pragma mark - Help Methods

//竖向瀑布流 item等宽不等高
- (CGRect)itemFrameOfVerticalWaterFlow:(NSIndexPath *)indexPath{
    
    //collectionView的宽度
    CGFloat collectionW = self.collectionView.frame.size.width;
    //设置布局属性item的frame
    CGFloat w = (collectionW - self.edgeInsets.left - self.edgeInsets.right - (self.columnCount - 1) * self.columnMargin) / self.columnCount;
    CGFloat h = [self.delegate waterFlowLayout:self sizeForItemAtIndexPath:indexPath].height;
    
    //找出高度最短的那一列
    NSInteger destColumn = 0;
    CGFloat minColumnHeight = [self.columnHeights[0] doubleValue];
    for (NSInteger i = 1; i < self.columnCount; i++) {
        //取出第i列
        CGFloat columnHeight = [self.columnHeights[i] doubleValue];
        if (minColumnHeight > columnHeight) {
            minColumnHeight = columnHeight;
            destColumn = i;
        }
    }
    
    CGFloat x = self.edgeInsets.left + destColumn * (w + self.columnMargin);
    CGFloat y = minColumnHeight;
    if (y != self.edgeInsets.top) {
        y += self.rowMargin;
    }
    
    //更新最短那列的高度
    self.columnHeights[destColumn] = @(CGRectGetMaxY(CGRectMake(x, y, w, h)));
    //记录内容的高度
    CGFloat columnHeight = [self.columnHeights[destColumn] doubleValue];
    if (self.maxColumnHeight < columnHeight) {
        self.maxColumnHeight = columnHeight;
    }
    
    return CGRectMake(x, y + self.containerHeight, w, h);
}

@end
