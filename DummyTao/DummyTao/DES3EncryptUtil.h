//
//  DES3EncryptUtil.h
//  WSJ
//
//  Created by NightOwl on 2017/1/16.
//  Copyright © 2017年 郑晓龙. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DES3EncryptUtil : NSObject
// 加密方法
+ (NSString*)encrypt:(NSString*)plainText;

// 解密方法
+ (NSString*)decrypt:(NSString*)encryptText;
@end
