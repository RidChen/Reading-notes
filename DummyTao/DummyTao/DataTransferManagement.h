//
//  DataTransferManagement.h
//  DummyTao
//
//  Created by 陈宇 on 2017/3/27.
//  Copyright © 2017年 陈宇. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DataTransferRequest.h"
#import "DataTransferResponse.h"

typedef NS_ENUM(NSInteger, DataRequestType) {
    DataRequestTypeGetAppVersion,
    DataRequestTypeLogin,
    DataRequestTypeAutoLogin,
    DataRequestTypeGetOrderList,
    DataRequestTypeTotal
};

typedef void (^DataTransferResponseBlock)(DataResultType result, DataTransferResponse* response);

@interface DataTransferManagement : NSObject <NSURLSessionDataDelegate>

@property (nonatomic, copy) DataTransferResponseBlock responseBlock;
//@property (nonatomic, copy) DataTransferAFNBlock AFNBlock;
@property (nonatomic, strong) NSMutableData* responseData;

+(instancetype)sharedInstance;
-(DataResultType)sendRequest:(DataRequestType)type
              withParameters:(DataTransferRequest*)parameters
                    andResponse:(DataTransferResponseBlock)response;
@end
