//
//  CustomNavModel.h
//  DummyTao
//
//  Created by 陈宇 on 2017/3/17.
//  Copyright © 2017年 陈宇. All rights reserved.
//

#import <Foundation/Foundation.h>

@class GoodsCategory, CommonHeaderModel;

typedef NS_OPTIONS(NSUInteger, CMResultType) {
    CMResultTypeSuccess          = 0,
    CMResultTypeFail             = 0 << 1,
    CMResultTypeUnknownError     = 0 << 2
};

@interface CustomNavModel : NSObject <NSCopying>
@property (nonatomic, strong) NSMutableArray* goodsData;
@property (nonatomic, strong) NSMutableArray* searchData;
@property (nonatomic, strong) NSArray* goodsCategory;
@property (nonatomic, strong) NSArray* hotGoods;
@property (nonatomic, assign) NSInteger hotOffset;
@property (nonatomic, strong) NSArray* footer;
@property (nonatomic, strong) NSArray* cheepGoods;
@property (nonatomic, strong) CommonHeaderModel* cheepHeader;
@property (nonatomic, strong) NSMutableDictionary* userInformation;

+ (instancetype) sharedModel;
- (void) requestRecommendedInfo:(void (^)(CMResultType result, NSArray* info)) response;
- (void) requestFooterInfomation:(void (^)(CMResultType result, NSArray* info)) response;
@end
