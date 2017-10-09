//
//  DataModel.m
//  DummyTao
//
//  Created by 陈宇 on 2017/3/27.
//  Copyright © 2017年 陈宇. All rights reserved.
//

#import "DataModel.h"
#import "sys/utsname.h"
#import <UIKit/UIKit.h>

@implementation DataModel


+ (instancetype)sharedInstance {
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        _dataInstance = [[self alloc] init];
    });
    
    return _dataInstance;
}

+ (instancetype)allocWithZone:(struct _NSZone *)zone {
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        _dataInstance = [super allocWithZone:zone];
    });
    return _dataInstance;
}

- (id)copyWithZone:(NSZone *)zone {
    return _dataInstance;
}

+ (NSString*)deviceVersion
{
    // 需要#import "sys/utsname.h"
    struct utsname systemInfo;
    uname(&systemInfo);
    NSString *platform = [NSString stringWithCString:systemInfo.machine encoding:NSUTF8StringEncoding];
    
    if ([platform isEqualToString:@"iPhone1,1"]) return @"iPhone 2G (A1203)";
    if ([platform isEqualToString:@"iPhone1,2"]) return @"iPhone 3G (A1241/A1324)";
    if ([platform isEqualToString:@"iPhone2,1"]) return @"iPhone 3GS (A1303/A1325)";
    if ([platform isEqualToString:@"iPhone3,1"]) return @"iPhone 4 (A1332)";
    if ([platform isEqualToString:@"iPhone3,2"]) return @"iPhone 4 (A1332)";
    if ([platform isEqualToString:@"iPhone3,3"]) return @"iPhone 4 (A1349)";
    if ([platform isEqualToString:@"iPhone4,1"]) return @"iPhone 4S (A1387/A1431)";
    if ([platform isEqualToString:@"iPhone5,1"]) return @"iPhone 5 (A1428)";
    if ([platform isEqualToString:@"iPhone5,2"]) return @"iPhone 5 (A1429/A1442)";
    if ([platform isEqualToString:@"iPhone5,3"]) return @"iPhone 5c (A1456/A1532)";
    if ([platform isEqualToString:@"iPhone5,4"]) return @"iPhone 5c (A1507/A1516/A1526/A1529)";
    if ([platform isEqualToString:@"iPhone6,1"]) return @"iPhone 5s (A1453/A1533)";
    if ([platform isEqualToString:@"iPhone6,2"]) return @"iPhone 5s (A1457/A1518/A1528/A1530)";
    if ([platform isEqualToString:@"iPhone7,1"]) return @"iPhone 6 Plus (A1522/A1524)";
    if ([platform isEqualToString:@"iPhone7,2"]) return @"iPhone 6 (A1549/A1586)";
    //iPhone 6s
    if ([platform isEqualToString:@"iPhone8,1"]) return @"iPhone 6s (A1700)";
    //iPhone 6s plus
    if ([platform isEqualToString:@"iPhone8,2"]) return @"iPhone 6s Plus (A1699)";
    //iPhone 7
    if ([platform isEqualToString:@"iPhone9,1"]) return @"iPhone 7";
    //iPhone 7 plus
    if ([platform isEqualToString:@"iPhone9,2"]) return @"iPhone 7 Plus";
    
    if ([platform isEqualToString:@"iPod1,1"])   return @"iPod Touch 1G (A1213)";
    if ([platform isEqualToString:@"iPod2,1"])   return @"iPod Touch 2G (A1288)";
    if ([platform isEqualToString:@"iPod3,1"])   return @"iPod Touch 3G (A1318)";
    if ([platform isEqualToString:@"iPod4,1"])   return @"iPod Touch 4G (A1367)";
    if ([platform isEqualToString:@"iPod5,1"])   return @"iPod Touch 5G (A1421/A1509)";
    
    if ([platform isEqualToString:@"iPad1,1"])   return @"iPad 1G (A1219/A1337)";
    
    if ([platform isEqualToString:@"iPad2,1"])   return @"iPad 2 (A1395)";
    if ([platform isEqualToString:@"iPad2,2"])   return @"iPad 2 (A1396)";
    if ([platform isEqualToString:@"iPad2,3"])   return @"iPad 2 (A1397)";
    if ([platform isEqualToString:@"iPad2,4"])   return @"iPad 2 (A1395+New Chip)";
    if ([platform isEqualToString:@"iPad2,5"])   return @"iPad Mini 1G (A1432)";
    if ([platform isEqualToString:@"iPad2,6"])   return @"iPad Mini 1G (A1454)";
    if ([platform isEqualToString:@"iPad2,7"])   return @"iPad Mini 1G (A1455)";
    
    if ([platform isEqualToString:@"iPad3,1"])   return @"iPad 3 (A1416)";
    if ([platform isEqualToString:@"iPad3,2"])   return @"iPad 3 (A1403)";
    if ([platform isEqualToString:@"iPad3,3"])   return @"iPad 3 (A1430)";
    if ([platform isEqualToString:@"iPad3,4"])   return @"iPad 4 (A1458)";
    if ([platform isEqualToString:@"iPad3,5"])   return @"iPad 4 (A1459)";
    if ([platform isEqualToString:@"iPad3,6"])   return @"iPad 4 (A1460)";
    
    if ([platform isEqualToString:@"iPad4,1"])   return @"iPad Air (A1474)";
    if ([platform isEqualToString:@"iPad4,2"])   return @"iPad Air (A1475)";
    if ([platform isEqualToString:@"iPad4,3"])   return @"iPad Air (A1476)";
    if ([platform isEqualToString:@"iPad4,4"])   return @"iPad Mini 2G (A1489)";
    if ([platform isEqualToString:@"iPad4,5"])   return @"iPad Mini 2G (A1490)";
    if ([platform isEqualToString:@"iPad4,6"])   return @"iPad Mini 2G (A1491)";
    
    if ([platform isEqualToString:@"i386"])      return @"iPhone Simulator";
    if ([platform isEqualToString:@"x86_64"])    return @"iPhone Simulator";
    return platform;
}

-(DataResultType) loadData:(DataType)type withDictionary:(NSMutableDictionary*) dict{
    DataResultType result = DataResultTypeUnknownError;
    NSString* foderPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,
                                                               NSUserDomainMask,
                                                               YES)
                           firstObject];
    
    switch(type) {
        case DataTypeAppVersion: {
            NSDictionary* systemInfo =
            @{
              @"system":@"02",
              @"imei":@"06B69882-8F8F-42EA-B025-B87016412E64",
              @"currentVersion":[NSString stringWithFormat:@"%@",[[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"]],
              @"systemVersion":[[UIDevice currentDevice] systemVersion],
              @"model":[DataModel deviceVersion],
              @"sig":@"0000000000",
              @"inteVersion":@"1.2.3"
              };
            [dict addEntriesFromDictionary:systemInfo];
            result = DataResultTypeSuccess;
        }
            break;

        case DataTypeUserInfomation:
            [dict setDictionary:[NSKeyedUnarchiver unarchiveObjectWithFile:
                         [foderPath stringByAppendingString:DATA_PATH_USER_INFO]]];
            result = DataResultTypeSuccess;
            break;
            
        default:
            break;
    }
    return result;
}

-(DataResultType) saveData:(DataType)type andDictionary:(NSDictionary*) dict {
    DataResultType result = DataResultTypeUnknownError;
    NSString* dataPath = nil;

    switch (type) {
        case DataTypeAppVersion: {
            dataPath = DATA_PATH_APP_VERSION;
        }
            break;
        
        case DataTypeUserInfomation: {
            dataPath = DATA_PATH_USER_INFO;
            [self updateUserInformation:[NSMutableDictionary dictionaryWithDictionary:dict]];
        }
            break;
            
        default:
            break;
    }
    
    if (dataPath) {
        NSString* docPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
        [NSKeyedArchiver archiveRootObject:dict toFile:[docPath stringByAppendingString:dataPath]];
    }
    return result;
}

-(void)updateUserInformation:(NSMutableDictionary*) dict {
    if (nil != _userInfo && nil != dict && dict.count > 0) {
        _userInfo = [[UserInformation alloc] init];
        _userInfo.userName = dict[@"username"];
        _userInfo.userId = dict[@"userId"];
        _userInfo.siteName = dict[@"userName"];
        _userInfo.siteId = dict[@"siteId"];
        _userInfo.token = dict[@"token"];
        _userInfo.auth = dict[@"auth"];
    }
}

-(UserInformation*)userInfo {
    if (!_userInfo) {
        _userInfo = [[UserInformation alloc] init];
        NSMutableDictionary* dict = [NSMutableDictionary dictionary];
        if (DataResultTypeSuccess == [self loadData:DataTypeUserInfomation withDictionary:dict]) {
            [self updateUserInformation:dict];
        }
    }
    
    return _userInfo;
}

@end
