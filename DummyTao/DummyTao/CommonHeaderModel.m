//
//  CommonHeaderModel.m
//  DummyTao
//
//  Created by 陈宇 on 2017/3/25.
//  Copyright © 2017年 陈宇. All rights reserved.
//

#import "CommonHeaderModel.h"

@implementation CommonHeaderModel
- (instancetype)initWithTitle:(NSString*)title icon:(NSString*) icon {
    if (self = [super init]) {
        _headerTitle = title;
        _headerIcon = icon;
    }
    return self;
}
@end
