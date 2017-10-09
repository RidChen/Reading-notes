//
//  MainCollectionViewFlowLayout.h
//  DummyTao
//
//  Created by 陈宇 on 2017/3/23.
//  Copyright © 2017年 陈宇. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MainCollectionViewFlowLayout : UICollectionViewFlowLayout
@property (nonatomic, copy) NSArray* cellSize;
@property (nonatomic, copy) NSMutableArray* cellRow;
@property (nonatomic, strong) NSMutableArray* attributes;
-(instancetype)initWithSectionSize:(NSArray*)sizes;
@end
