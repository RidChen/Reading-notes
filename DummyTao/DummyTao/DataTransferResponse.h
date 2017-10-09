//
//  DataTransferResponse.h
//  DummyTao
//
//  Created by 陈宇 on 2017/3/28.
//  Copyright © 2017年 陈宇. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DataTransferResponse : NSObject

@property (nonatomic, strong) NSDictionary* dict;

-(instancetype) initWithData:(NSData*)data;
-(instancetype) initWithDictionary:(NSDictionary*)dict;
@end
