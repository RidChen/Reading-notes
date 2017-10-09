//
//  DataModel
//  DummyTao
//
//  Created by 陈宇 on 2017/3/27.
//  Copyright © 2017年 陈宇. All rights reserved.
//

#import <Foundation/Foundation.h>
#include "UserInformation.h"

static id _dataInstance;

typedef NS_ENUM(NSInteger, DataType) {
    DataTypeAppVersion,
    DataTypeUserInfomation
};


@interface DataModel : NSObject

@property (nonatomic,strong) UserInformation* userInfo;

+ (instancetype)sharedInstance;
+ (instancetype)allocWithZone:(struct _NSZone *)zone;
-(DataResultType) loadData:(DataType)type withDictionary:(NSMutableDictionary*) dict;
-(DataResultType) saveData:(DataType)type andDictionary:(NSDictionary*) dict;
@end
