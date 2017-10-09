//
//  CheepGoods.h
//  DummyTao
//
//  Created by 陈宇 on 2017/3/24.
//  Copyright © 2017年 陈宇. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, CheepGoodsType) {
    CheepGoodsTypeSmall = 0,
    CheepGoodsTypeBig
};

@interface CheepGoods : NSObject
@property (nonatomic, copy) NSString* mainTitle;
@property (nonatomic, copy) NSString* subTile;
@property (nonatomic, copy) NSString* mainImage;
@property (nonatomic, assign) CheepGoodsType type;
-(instancetype)initWithCheepGoodsInfo:(NSString*)mainTitle subTitle:(NSString*)subTitle imagePath:(NSString*)image type:(CheepGoodsType)type;
@end
