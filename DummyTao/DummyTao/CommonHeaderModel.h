//
//  CommonHeaderModel.h
//  DummyTao
//
//  Created by 陈宇 on 2017/3/25.
//  Copyright © 2017年 陈宇. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CommonHeaderModel : NSObject
@property (nonatomic, copy) NSString* headerTitle;
@property (nonatomic, copy) NSString* headerIcon;

- (instancetype)initWithTitle:(NSString*)title icon:(NSString*) icon;
@end
