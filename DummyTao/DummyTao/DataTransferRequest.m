//
//  DataTransferRequest.m
//  DummyTao
//
//  Created by 陈宇 on 2017/3/28.
//  Copyright © 2017年 陈宇. All rights reserved.
//

#import "DataTransferRequest.h"
#import "DataModel.h"

@implementation DataTransferRequest

-(instancetype)initWithToken:(NSString*) token andDictionary:(NSDictionary*)dict {
    if (self = [super init]) {
        self.token = token;
        if (dict) {
            self.dict = [[NSMutableDictionary alloc] initWithDictionary:dict];
        } else {
            self.dict = [NSMutableDictionary dictionary];
        }
        [[DataModel sharedInstance] loadData:DataTypeAppVersion withDictionary:self.dict];
    }
    return self;
}

@end
