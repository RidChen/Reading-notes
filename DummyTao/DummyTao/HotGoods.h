//
//  HotGoods.h
//  DummyTao
//
//  Created by 陈宇 on 2017/3/23.
//  Copyright © 2017年 陈宇. All rights reserved.
//

#import <Foundation/Foundation.h>

@class UIColor;

@interface HotGoods : NSObject
@property (nonatomic, copy) NSString* title;
@property (nonatomic, copy) NSString* info;
@property (nonatomic, copy) NSString* mainImagePath;
@property (nonatomic, copy) NSString* subImagePath;
@property (nonatomic, copy) NSString* subSubImagePath;
@property (nonatomic, copy) UIColor* titleColor;

-(instancetype)initHotGoods:(NSString*)title mainInfo:(NSString*)info mainImage:(NSString*)main subImage:(NSString*)subImage subSubImage:(NSString*)subSubImage titleColor:(UIColor*)titleColor;
@end
