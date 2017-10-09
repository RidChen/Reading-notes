//
//  MainCollectionViewFlowLayout.m
//  DummyTao
//
//  Created by 陈宇 on 2017/3/23.
//  Copyright © 2017年 陈宇. All rights reserved.
//

#import "MainCollectionViewFlowLayout.h"

@implementation MainCollectionViewFlowLayout


-(instancetype)initWithSectionSize:(NSArray*)sizes {
    if (self = [super init]) {
        _cellSize = sizes;
        _cellRow = [NSMutableArray array];
        _attributes = [NSMutableArray array];
    }
    return self;
}

// The total size of contentsize
-(void)prepareLayout {
    [super prepareLayout];
    NSInteger sectionCount = [[self collectionView] numberOfSections];
    for (NSInteger i = 0; i < sectionCount; i++) {
        NSInteger rowCount = [[self collectionView] numberOfItemsInSection:i];
        NSInteger row = rowCount * [_cellSize[i] CGSizeValue].width / self.collectionView.frame.size.width;
        [_cellRow addObject:[NSNumber numberWithInteger:row]];
        for (NSInteger j = 0; j < rowCount; j++) {
            NSIndexPath* indexPath = [NSIndexPath indexPathForItem:j inSection:i];
            [_attributes addObject:[self layoutAttributesForItemAtIndexPath:indexPath]];
        }
    }
}

//-(CGSize)collectionViewContentSize {
//    return [self collectionView].frame.size;
//}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    UIEdgeInsets insets;
    
    switch (section) {
        case 0:
            insets = UIEdgeInsetsMake(0, 0, 10, 0);
            break;
            
        default:
            insets = UIEdgeInsetsMake(10, 0, 10, 0);
            break;
    }
    
    return insets;
}

// If using customized layout, it must be true(YES)
-(BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds {
    return YES;
}

// return the layout attribute of each cell
- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewLayoutAttributes* attrs = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
    
    attrs.size = [_cellSize[indexPath.section] CGSizeValue];
    CGFloat screeenWidth = self.collectionView.frame.size.width;
    CGFloat attributeWidth = attrs.size.width;
    CGFloat attributeHeight = attrs.size.height;

    CGFloat point_x = attributeWidth * (indexPath.row + 0.5);
    int row = (point_x / screeenWidth);
    point_x -= row * screeenWidth;
    CGFloat point_y = (row + 0.5) * attributeHeight;
    for (NSInteger i = 0; i < indexPath.section; i++) {
        point_y += [_cellSize[i] CGSizeValue].height * [_cellRow[i] integerValue];
    }
    attrs.center = CGPointMake(point_x, point_y);
    
    return attrs;
}

-(NSArray*)indexPathsOfItemsInRect:(CGRect)rect {
    NSArray* attributes = [self layoutAttributesForElementsInRect:rect];
    UICollectionViewLayoutAttributes* layout = nil;
    for (NSInteger i = 0; i < attributes.count; i++) {
        layout = attributes[i];
        layout.size = [_cellSize[layout.indexPath.section] CGSizeValue];
    }
    
    return attributes;
}

-(NSArray*)layoutAttributesForElementsInRect:(CGRect)rect {
    return _attributes;
}

//- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
//
//}
//
//- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
//    
//}
//
//- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
//
//}
//
//- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
//
//}
//
//- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
//
//}
//
//- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section {
//}

@end
