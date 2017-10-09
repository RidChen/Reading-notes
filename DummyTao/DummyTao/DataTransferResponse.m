//
//  DataTransferResponse.m
//  DummyTao
//
//  Created by 陈宇 on 2017/3/28.
//  Copyright © 2017年 陈宇. All rights reserved.
//

#import "DataTransferResponse.h"

@implementation DataTransferResponse

-(instancetype) initWithData:(NSData*)data{
    if (self = [super init]) {
        if (nil != data) {
            _dict = [NSJSONSerialization JSONObjectWithData:data
                                                    options:NSJSONReadingMutableLeaves
                                                      error:nil];
        }
    }
    return self;
}

-(instancetype) initWithDictionary:(NSDictionary*)dict{
    if (self = [super init]) {
        if (nil != dict) {
            _dict = dict;
        }
    }
    return self;
}

-(NSString *)description {
    return [_dict descriptionInStringsFileFormat];
}

@end
