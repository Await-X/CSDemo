//
//  MyCategoryView.m
//  CSDemo
//
//  Created by apple on 2020/10/29.
//  Copyright © 2020 CS. All rights reserved.
//

#import "MyCategoryView.h"

@implementation MyCategoryView


- (void)reloadCellAtIndex:(NSInteger)index {
    if (index < 0 || index >= self.dataSource.count) {
        return;
    }
    JXCategoryBaseCellModel *cellModel = self.dataSource[index];
    cellModel.selectedType = JXCategoryCellSelectedTypeUnknown;
    [self refreshCellModel:cellModel index:index];
    JXCategoryBaseCell *cell = (JXCategoryBaseCell *)[self.collectionView cellForItemAtIndexPath:[NSIndexPath indexPathForItem:index inSection:0]];
    [cell reloadData:cellModel];
}

@end
