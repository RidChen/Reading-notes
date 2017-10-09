//
//  DataTransferManagement.m
//  DummyTao
//
//  Created by 陈宇 on 2017/3/27.
//  Copyright © 2017年 陈宇. All rights reserved.
//

#import "DataTransferManagement.h"
#import "AFHTTPSessionManager.h"

static id _dataManagementInstance;

@implementation DataTransferManagement

+ (instancetype)sharedInstance {
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        _dataManagementInstance = [[self alloc] init];
    });
    
    return _dataManagementInstance;
}

-(NSString*) prepareUrlString:(DataRequestType)type withToken:(NSString*)token{
    NSString* urlStr = nil;
    const NSArray* dataPath = [[NSArray alloc] initWithObjects:
                                HTTP_PATH_GET_APP_VERSION,
                                HTTP_PATH_LOGIN,
                                HTTP_PATH_AUTO_LOGIN,
                                HTTP_PATH_GET_ORDER_LIST,
                                nil];
    if (DataRequestTypeLogin == type) {
        urlStr = [NSString stringWithFormat:@"%@%@",
                  HTTP_PATH_ROOT,
                  dataPath[type]];
    } else if (type < DataRequestTypeTotal && type >= DataRequestTypeGetAppVersion) {
        urlStr = [NSString stringWithFormat:@"%@%@?token=%@",
                  HTTP_PATH_ROOT,
                  dataPath[type],
                  token];
    }
     return urlStr;
}

-(DataResultType)sendRequest:(DataRequestType)type
              withParameters:(DataTransferRequest*)parameters
                 andResponse:(DataTransferResponseBlock)responseBlock {
#if 1
    DataResultType result = DataResultTypeUnknownError;
    
    if (nil == _responseBlock) {
        NSString* urlStr = [self prepareUrlString:type withToken:parameters.token];
        if (urlStr) {
            _responseBlock = responseBlock;
            NSData* jsonData = [NSJSONSerialization dataWithJSONObject:parameters.dict
                                                               options:NSJSONWritingPrettyPrinted
                                                                 error:nil];
            
            NSURL* url = [[NSURL alloc] initWithString:urlStr];
            NSMutableURLRequest* request = [NSMutableURLRequest requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:10];
            if (![request valueForHTTPHeaderField:@"Content-Type"]) {
                [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
            }
            [request setHTTPMethod:@"POST"];
            [request setHTTPBody:jsonData];

            /*
             * 1. Phase out, because NSURLConnection/sendAsynchronousRequest was deprecated in iOS 9
             */
            //            [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse * _Nullable response, NSData * _Nullable data, NSError * _Nullable connectionError) {
            //                if (!connectionError) {
            //                    NSLog(@"response:%@", response);
            //                    NSLog(@"data:%@",[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding]);
            //                    NSLog(@"Error:%@",connectionError);
            //                }
            //            }];
            //
            //            NSLog(@"%@", url);
            
            /*
             * 2. Use block to handle the response from the Network, it is easy to use.
             */
            //            NSURLSession* session = [NSURLSession sharedSession];
            //
            //            NSURLSessionTask* dataTask = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
            //                if (!error) {
            //                    NSLog(@"Response:%@", response);
            //                    NSLog(@"Data:%@",[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding]);
            //                    NSLog(@"Result:%@", error);
            //                } else {
            //                    NSLog(@"ERROR:%@", error);
            //                }
            //            }];
            //            [dataTask resume];
            /*
             * 3. implement NSURLSessionDataDelegate
             */
            NSURLSession* session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration] delegate:self delegateQueue:[NSOperationQueue mainQueue]];
            
            NSURLSessionDataTask* task = [session dataTaskWithRequest:request];
            [task resume];
            [session finishTasksAndInvalidate];
        }
    }
    return result;
#else
    DataResultType result = DataResultTypeUnknownError;
    
    NSString* urlStr = [self prepareUrlString:type withToken:parameters.token];
    if (urlStr) {
        AFHTTPSessionManager* manager = [AFHTTPSessionManager manager];
        manager.responseSerializer = [AFJSONResponseSerializer serializer];
        manager.requestSerializer = [AFJSONRequestSerializer serializer];

        [manager POST:urlStr parameters:parameters.dict progress:^(NSProgress * _Nonnull uploadProgress) {
            
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            DataTransferResponse* response = [[DataTransferResponse alloc] initWithDictionary:responseObject];
            NSInteger errorCode = [response.dict[@"code"] integerValue];
            DataResultType result = DataResultTypeUnknownError;

            switch (errorCode) {
                case 0:
                    result = DataResultTypeSuccess;
                    break;

                case 2:
                    result = DataResultTypeUnknownError;
                    break;
                    
                case 5:
                    result = DataResultTypeInvalidAccount;
                    break;
                    
                default:
                    result = DataResultTypeUnknownError;
                    break;
            }
            responseBlock(result, response);

        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            responseBlock(DataResultTypeSessionError, nil);
        }];
    }
    
    return result;
#endif
}

// 1.接收到服务器的响应
- (void)URLSession:(NSURLSession *)session
          dataTask:(NSURLSessionDataTask *)dataTask
didReceiveResponse:(NSURLResponse *)response
 completionHandler:(void (^)(NSURLSessionResponseDisposition))completionHandler {
    // 允许处理服务器的响应，才会继续接收服务器返回的数据
//    NSLog(@"response:%@",response);
    _responseData = [NSMutableData data];
    completionHandler(NSURLSessionResponseAllow);
}

// 2.接收到服务器的数据（可能调用多次）
- (void)URLSession:(NSURLSession *)session
          dataTask:(NSURLSessionDataTask *)dataTask
    didReceiveData:(NSData *)data {
    // 处理每次接收的数据
    [_responseData appendData:data];
//    NSLog(@"data:%@", [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding]);
}

// 3.请求成功或者失败（如果失败，error有值）
- (void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task didCompleteWithError:(NSError *)error {
    // 请求完成,成功或者失败的处理
    if (_responseBlock) {
        DataTransferResponse* response = nil;
        DataResultType result;
        
        if (error) {
            // TODO: according to the error code, assgin the correct error type;
            NSLog(@"%@",error);
            
            result = DataResultTypeSessionError;
        } else {
            response = [[DataTransferResponse alloc] initWithData:_responseData];
            NSInteger errorCode = [response.dict[@"code"] integerValue];
            switch (errorCode) {
                case 0:
                    result = DataResultTypeSuccess;
                    break;

                case 2:
                    result = DataResultTypeUnknownError;
                    break;
                    
                case 5:
                    result = DataResultTypeInvalidAccount;
                    break;
                    
                default:
                    result = DataResultTypeUnknownError;
                    break;
            }
        }
        
        _responseBlock(result, response);
        _responseBlock = nil;
    }
//    NSLog(@"error:%@", error);
}

@end
