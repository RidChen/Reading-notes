//
//  GoodsCategory.h
//  DummyTao
//
//  Created by 陈宇 on 2017/3/22.
//  Copyright © 2017年 陈宇. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GoodsCategory : NSObject
@property (nonatomic, copy) NSString* title;
@property (nonatomic, copy) NSString* imageName;
- (instancetype) initGoodsCategory:(NSString*)title imageNamed:(NSString*)imageName;
@end
