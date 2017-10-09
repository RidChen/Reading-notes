//
//  UserInformation.m
//  DummyTao
//
//  Created by 陈宇 on 2017/3/27.
//  Copyright © 2017年 陈宇. All rights reserved.
//

#import "UserInformation.h"

@implementation UserInformation

-(void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject:_userName forKey:@"username"];
    [aCoder encodeObject:_userId forKey:@"userId"];
    [aCoder encodeObject:_siteName forKey:@"siteName"];
    [aCoder encodeObject:_siteId forKey:@"siteId"];
    [aCoder encodeObject:_token forKey:@"token"];
    [aCoder encodeObject:_auth forKey:@"auth"];
}

-(instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super init]) {
        _userName = [aDecoder decodeObjectForKey:@"username"];
        _userId = [aDecoder decodeObjectForKey:@"userId"];
        _siteName = [aDecoder decodeObjectForKey:@"siteName"];
        _siteId = [aDecoder decodeObjectForKey:@"siteId"];
        _token = [aDecoder decodeObjectForKey:@"token"];
        _auth = [aDecoder decodeObjectForKey:@"auth"];
    }
    return self;
}

@end
