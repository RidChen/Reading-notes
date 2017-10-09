//
//  GoodsCategory.m
//  DummyTao
//
//  Created by 陈宇 on 2017/3/22.
//  Copyright © 2017年 陈宇. All rights reserved.
//

#import "GoodsCategory.h"

@implementation GoodsCategory
- (instancetype) initGoodsCategory:(NSString*)title imageNamed:(NSString*)imageName {
    if (self = [super init]) {
        _title = title;
        _imageName = imageName;
    }
    return self;
}
@end
