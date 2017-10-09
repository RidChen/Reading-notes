//
//  UserInformation.h
//  DummyTao
//
//  Created by 陈宇 on 2017/3/27.
//  Copyright © 2017年 陈宇. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserInformation : NSObject<NSCoding>

@property (nonatomic,copy) NSString* userName;
@property (nonatomic,copy) NSString* userId;
@property (nonatomic,copy) NSString* siteName;
@property (nonatomic,copy) NSString* siteId;
@property (nonatomic,copy) NSString* token;
@property (nonatomic,copy) NSArray* auth;

-(void)encodeWithCoder:(NSCoder *)aCoder;
-(instancetype)initWithCoder:(NSCoder *)aDecoder;

@end
