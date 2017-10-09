//
//  HotGoods.m
//  DummyTao
//
//  Created by 陈宇 on 2017/3/23.
//  Copyright © 2017年 陈宇. All rights reserved.
//

#import "HotGoods.h"
#import "UIKit/UIKit.h"
@implementation HotGoods

-(instancetype)initHotGoods:(NSString*)title mainInfo:(NSString*)info mainImage:(NSString*)main subImage:(NSString*)subImage subSubImage:(NSString*)subSubImage titleColor:(UIColor*)titleColor {
    if (self = [super init]) {
        _title = title;
        _info = info;
        _mainImagePath = main;
        _subImagePath = subImage;
        _subSubImagePath = subSubImage;
        _titleColor = titleColor;
    }
    
    return self;
}


@end
