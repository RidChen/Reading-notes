//
//  CheepGoods.m
//  DummyTao
//
//  Created by 陈宇 on 2017/3/24.
//  Copyright © 2017年 陈宇. All rights reserved.
//

#import "CheepGoods.h"

@implementation CheepGoods
-(instancetype)initWithCheepGoodsInfo:(NSString*)mainTitle subTitle:(NSString*)subTitle imagePath:(NSString*)image type:(CheepGoodsType)type {
    if (self = [super init]) {
        _mainTitle = mainTitle;
        _subTile = subTitle;
        _mainImage = image;
        _type = type;
    }
    return self;
}
@end
