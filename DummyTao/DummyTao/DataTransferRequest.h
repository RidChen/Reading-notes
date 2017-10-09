//
//  DataTransferRequest.h
//  DummyTao
//
//  Created by 陈宇 on 2017/3/28.
//  Copyright © 2017年 陈宇. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DataTransferRequest : NSObject

@property (nonatomic, copy) NSString* token;
@property (nonatomic, strong) NSMutableDictionary* dict;

-(instancetype)initWithToken:(NSString*) token andDictionary:(NSDictionary*)dict;

@end
