//
//  CMAFNManager.h
//  e-BanBase
//
//  Created by CrabMan on 16/7/6.
//  Copyright © 2016年 CrabMan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking/AFNetworking.h>

typedef void (^HttpProgress)(NSProgress *progress);
//宏定义成功block 回调成功后得到的信息
typedef void (^HttpSuccess)(NSURLSessionDataTask *task, id   responseObject);
//宏定义失败block 回调失败信息
typedef void (^HttpFailure)(NSURLSessionDataTask *task, NSError *error);

//宏定义网络状态block
typedef void(^ReachabilityStatusBlock)(AFNetworkReachabilityStatus status);


@interface CMAFNManager : NSObject


/** 重新封装后的 get 请求 */
+(void)cm_getWithApi:(NSString *)api Parameters:(NSDictionary *)parameters Progerss:(HttpProgress)progress Success:(HttpSuccess)success Failure:(HttpFailure)failure;


/** 重新封装后的 post 请求 */
+(void)cm_postWithApi:(NSString *)api Parameters:(NSDictionary *)parameters Progerss:(HttpProgress)progress Success:(HttpSuccess)success Failure:(HttpFailure)failure;

/** 普通路径的上传文件*/
+(void)cm_uploadWithURL:(NSString *)url
              Params:(NSDictionary *)params
            FileData:(NSData *)filedata
                Name:(NSString *)name
            FileName:(NSString *)filename
            MimeType:(NSString *) mimeType
            Progress:(HttpProgress)progress
             Success:(HttpSuccess)success
             Failure:(HttpFailure)failure;


/**监听网络状况*/
+ (void)cm_setReachabilityStatusBlock:(ReachabilityStatusBlock)status;

/**取消所有网络请求*/
+ (void)cm_cancelAllOperations;

@end
