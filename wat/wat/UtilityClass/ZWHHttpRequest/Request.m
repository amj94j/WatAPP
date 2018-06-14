//
//  Request.m
//  ahaTravel
//
//  Created by ah on 2018/6/6.
//  Copyright © 2018年 gwd. All rights reserved.
//

#import "Request.h"
#import<CommonCrypto/CommonDigest.h>
@implementation Request

- (instancetype)init
{
    self = [super init];
    if(self){
        NSSet *set = [NSSet setWithObject:@"text/html"];
        [self.responseSerializer setAcceptableContentTypes:set];
        self.requestSerializer=[AFHTTPRequestSerializer serializer];
    }
    return self;
}

-(AFSecurityPolicy *)debugSecurityPolicy{
    AFSecurityPolicy *securityPolicy = [AFSecurityPolicy defaultPolicy];
    securityPolicy.allowInvalidCertificates = YES;
    securityPolicy.validatesDomainName = NO;
    return securityPolicy;
}

- (NSURLSessionDataTask *)dataTaskWithHTTPMethod:(NSString *)method
                                       URLString:(NSString *)URLString
                                      parameters:(id)parameters
                                  uploadProgress:(nullable void (^)(NSProgress *uploadProgress)) uploadProgress
                                downloadProgress:(nullable void (^)(NSProgress *downloadProgress)) downloadProgress
                                         success:(void (^)(NSURLSessionDataTask *, id))success
                                         failure:(void (^)(NSURLSessionDataTask *, NSError *))failure
{
    NSError *serializationError = nil;
    NSMutableURLRequest *request = [self.requestSerializer requestWithMethod:method URLString:[[NSURL URLWithString:URLString relativeToURL:self.baseURL] absoluteString] parameters:parameters error:&serializationError];
    //[request setValue:RSAPI_VERSION forHTTPHeaderField:@"version"];
    [request setValue:@"111" forHTTPHeaderField:@"version"];
    if (serializationError) {
        if (failure) {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wgnu"
            dispatch_async(self.completionQueue ?: dispatch_get_main_queue(), ^{
                failure(nil, serializationError);
            });
#pragma clang diagnostic pop
        }
        
        return nil;
    }
    
    
    //用GET方式请求时  可打印request.URL  将链接在网页上打开直接查看数据
    NSLog(@"request.URL start %@",request.URL);
    
    __block NSURLSessionDataTask *dataTask = nil;
    
   
    
    
    //@rs_weakify(self);
    
    dataTask = [self dataTaskWithRequest:request
                          uploadProgress:uploadProgress
                        downloadProgress:downloadProgress
                       completionHandler:^(NSURLResponse * __unused response, id responseObject, NSError *error) {
                           
                           NSLog(@"request.URL end %@",request.URL);
                           
                           
                           if (error) {
                               //DDLogError(@"error = %@",error);
                               NSError *customError = [NSError errorWithDomain:error.domain code:error.code userInfo:@{NSLocalizedDescriptionKey:@"服务器访问失败~"}];
                               if (failure) {
                                   failure(dataTask, customError);
                               }
                           } else {
                               if (success) {
                                   success(dataTask, responseObject);
                               }
                           }
                           
                       }];
    
    return dataTask;
}

+(void)GET:(NSString *)relativePath
parameters:(id)parameters
   success:(successCallback)success
   failure:(failureCallback)failure{
    
    NSString *fullURL = [NSString stringWithFormat:@"http://api.watcn.com%@",relativePath];
    
    NSDate* dat = [NSDate dateWithTimeIntervalSinceNow:0];
    NSTimeInterval a=[dat timeIntervalSince1970]*1000;
    NSString *timeString = [NSString stringWithFormat:@"%f", a];
    NSString *timeStr10Wei = [timeString substringToIndex:10];
    NSMutableDictionary *parm = [NSMutableDictionary dictionaryWithDictionary:parameters];
    [parm setObject:timeStr10Wei forKey:@"timestamp"];
    NSString *device_code = @"device_code";
    [parm setObject:device_code forKey:@"device_code"];
    
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    if (parameters) {
        //[dic setObject:parm forKey:@"parme"];
        dic = parm;
    }
    
    
    
    
    NSString *sign =  [self md5:[NSString stringWithFormat:@"sha1(113)%@",timeStr10Wei]];
    [dic setObject:sign forKey:@"sign"];
    
    
    Request *manager = [[Request alloc] init];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/json",@"text/html",@"application/json",@"text/plain",nil];
    [manager GET:fullURL parameters:dic progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
        if(success) success(responseObject);
        //[HUD hideAnimated:YES];
        NSLog(@"成功了+++++++%@",responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if(failure) failure(error);
        
    }];
    
}


+(void)POST:(NSString *)relativePath
parameters:(id)parameters
   success:(successCallback)success
   failure:(failureCallback)failure{
    
    NSString *fullURL = [NSString stringWithFormat:@"http://api.watcn.com%@",relativePath];
    
    NSDate* dat = [NSDate dateWithTimeIntervalSinceNow:0];
    NSTimeInterval a=[dat timeIntervalSince1970]*1000;
    
    NSString *timeString = [NSString stringWithFormat:@"%f", a];
    NSString *timeStr10Wei = [timeString substringToIndex:10];
    NSMutableDictionary *parm = [NSMutableDictionary dictionaryWithDictionary:parameters];
    [parm setObject:timeStr10Wei forKey:@"timestamp"];
    NSString *device_code = @"device_code";
    [parm setObject:device_code forKey:@"device_code"];
    
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    if (parameters) {
        [dic setObject:parm forKey:@"parme"];
    }
    
    
    
   
    NSString *sign =  [self md5:[NSString stringWithFormat:@"sha1(113)%@",timeStr10Wei]];
    [dic setObject:sign forKey:@"sign"];
    
    
    Request *manager = [[Request alloc] init];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/json",@"text/html",@"application/json",@"text/plain",nil];
    [manager POST:fullURL parameters:dic progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
        if(success) success(responseObject);
        //[HUD hideAnimated:YES];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if(failure) failure(error);
        
    }];
    
}


//md5加密
+ (NSString *) md5:(NSString *) input {
    const char *cStr = [input UTF8String];
    unsigned char digest[CC_MD5_DIGEST_LENGTH];
    CC_MD5( cStr, strlen(cStr), digest ); // This is the md5 call
    
    NSMutableString *output = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    
    for(int i = 0; i < CC_MD5_DIGEST_LENGTH; i++)
        [output appendFormat:@"%02x", digest[i]];
    
    return  output;
}

@end
