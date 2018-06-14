//
//  CMAFNManager.m
//  e-BanBase
//
//  Created by CrabMan on 16/7/6.
//  Copyright © 2016年 CrabMan. All rights reserved.
//

#import "CMAFNManager.h"
#import "CMResponseManager.h"
#import "CMResponseManager.h"


@implementation CMAFNManager

//通过AFHTTPSesxsionManager和AFURLSessionManager的单例方法，防止内存泄漏；
static AFHTTPSessionManager *manager  ;
static AFURLSessionManager *urlsession ;
static NSString *apiAddress;
static NSDictionary *resolvedParams;

NSDictionary * ResolveParams(NSDictionary *params,NSString* api) {
    
    NSMutableDictionary *mResolvedParams = [[NSMutableDictionary alloc]initWithDictionary:params];
//    [mResolvedParams setValue:USID forKey:@"usid"];

    
    return mResolvedParams;
}


NSString* ApiAddress(NSString *api) {
    
#if DEBUG
   
    
    
//    apiAddress = [[HOST_ADDRESEE_INTRANET stringByAppendingString:api] copy];
    apiAddress = @"内外正式地址前缀与 api 拼接后的字符串";

#endif
    
//    apiAddress = [[HOST_ADDRESEE_EXTRANET stringByAppendingString:api] copy];
    apiAddress = @"外网正式地址前缀与 api 拼接后的字符串";
    return apiAddress;
}



+ (void)cm_cancelAllOperations {

    [[CMAFNManager sharedHTTPSessionManager].operationQueue cancelAllOperations];

}

/**AFHTTPSessionManager 对象的单例方法 */
+(AFHTTPSessionManager *)sharedHTTPSessionManager{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [AFHTTPSessionManager manager];
        
        //将返回的类型设置为json类型，则返回的为NSDic类型
        manager.responseSerializer = [AFJSONResponseSerializer serializer];
        
        //内容类型
        manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/json",@"text/javascript",@"text/html", nil];
        
        manager.requestSerializer.timeoutInterval = 10;
       // manager.requestSerializer = [AFJSONRequestSerializer serializer];
        //设置网络请求的安全策略以支持https
       // [manager setSecurityPolicy:[self customSecurityPolicy]];
    });
    
    return manager;
}

/**AFURLSessionManager 对象的单例方法 */
+(AFURLSessionManager *)sharedURLSessionManager{
    static dispatch_once_t onceToken2;
    dispatch_once(&onceToken2, ^{
        urlsession = [[AFURLSessionManager alloc] initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    });
    return urlsession;
}



/**自定义安全策略以支持https*/
+ (AFSecurityPolicy*)customSecurityPolicy
{
    
    // /先导入证书
    NSString *cerPath = [[NSBundle mainBundle] pathForResource:@"hgcang" ofType:@"cer"];//证书的路径
    NSData *certData = [NSData dataWithContentsOfFile:cerPath];
    
    // AFSSLPinningModeCertificate 使用证书验证模式
    AFSecurityPolicy *securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
    
    // allowInvalidCertificates 是否允许无效证书（也就是自建的证书），默认为NO
    // 如果是需要验证自建证书，需要设置为YES
    securityPolicy.allowInvalidCertificates = NO;
    
    //validatesDomainName 是否需要验证域名，默认为YES；
    //假如证书的域名与你请求的域名不一致，需把该项设置为NO；如设成NO的话，即服务器使用其他可信任机构颁发的证书，也可以建立连接，这个非常危险，建议打开。
    //置为NO，主要用于这种情况：客户端请求的是子域名，而证书上的是另外一个域名。因为SSL证书上的域名是独立的，假如证书上注册的域名是www.google.com，那么mail.google.com是无法验证通过的；当然，有钱可以注册通配符的域名*.google.com，但这个还是比较贵的。
    //如置为NO，建议自己添加对应域名的校验逻辑。
    securityPolicy.validatesDomainName = NO;
    
    securityPolicy.pinnedCertificates = [NSSet setWithObject:certData];;
    
    
    return securityPolicy;
}




/**基于AFN封装好的get请求*/
+(void)cm_getWithApi:(NSString *)api Parameters:(NSDictionary *)parameters Progerss:(HttpProgress)progress Success:(HttpSuccess)success Failure:(HttpFailure)failure{
    
    //创建请求管理者
    AFHTTPSessionManager *manager = [CMAFNManager sharedHTTPSessionManager];
   
    //get请求
    [manager GET:ApiAddress(api) parameters:ResolveParams(parameters, api) progress:^(NSProgress * _Nonnull downloadProgress) {
        //数据请求的进度
        progress(downloadProgress);
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        //id dic = [self responseConfiguration:responseObject];
        [[CMResponseManager sharedInstance] cm_resolveApi:api Params:parameters ReponseData:responseObject];
        
        success(task,responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failure(task,error);
    }];
    
}

//POST请求
+(void)cm_postWithApi:(NSString *)api Parameters:(NSDictionary *)parameters Progerss:(HttpProgress)progress Success:(HttpSuccess)success Failure:(HttpFailure)failure{
    //创建请求管理者
    AFHTTPSessionManager *manager = [CMAFNManager sharedHTTPSessionManager];
    
    //post请求
    [manager POST:ApiAddress(api) parameters:ResolveParams(parameters, api) progress:^(NSProgress * _Nonnull uploadProgress) {
        //数据请求的进度
        progress(uploadProgress);
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [[CMResponseManager sharedInstance] cm_resolveApi:api Params:parameters ReponseData:responseObject];

        success(task,responseObject);

    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failure(task,error);
    }];
    
}


//网络状态的监听
+ (void)cm_setReachabilityStatusBlock:(ReachabilityStatusBlock)status {
    
    AFNetworkReachabilityManager *reachbilityManager = [AFNetworkReachabilityManager sharedManager];
    //启动监听
    [reachbilityManager startMonitoring];
    
    [reachbilityManager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        switch (status) {
            case AFNetworkReachabilityStatusReachableViaWiFi:
                NSLog(@"WIFI");
                break;
                
            case AFNetworkReachabilityStatusReachableViaWWAN:
                NSLog(@"自带网络");
                break;
                
            case AFNetworkReachabilityStatusNotReachable:
                NSLog(@"没有网络");
                break;
                
            case AFNetworkReachabilityStatusUnknown:
                NSLog(@"未知网络");
                break;
            default:
                break;
        }
        
    }];



}


//普通文件路径的上传
+(void)cm_uploadWithURL:(NSString *)url
              Params:(NSDictionary *)params
            FileData:(NSData *)filedata
                Name:(NSString *)name
            FileName:(NSString *)filename
            MimeType:(NSString *) mimeType
            Progress:(HttpProgress)progress
             Success:(HttpSuccess)success
             Failure:(HttpFailure)failure {
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    [manager POST:url parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        
        [formData appendPartWithFileData:filedata name:name fileName:filename mimeType:mimeType];
        
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
        progress(uploadProgress);
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
//        id dic = [self responseConfiguration:responseObject];
        success(task,responseObject);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        failure(task,error);
    }];
}



//
+(NSURLSessionDownloadTask *)downloadWithURL:(NSString *)url
                                SavedPathURL:(NSURL *)pathURL
                                    Progress:(HttpProgress )progress
                                     Success:(void (^)(NSURLResponse *, NSURL *))success
                                     Failure:(void (^)(NSError *))failure{
    AFHTTPSessionManager *manager = [self managerWithBaseURL:nil sessionConfiguration:YES];
    
    NSURL *urlpath = [NSURL URLWithString:url];
    NSURLRequest *request = [NSURLRequest requestWithURL:urlpath];
    
    NSURLSessionDownloadTask *downloadtask = [manager downloadTaskWithRequest:request progress:^(NSProgress * _Nonnull downloadProgress) {
        progress(downloadProgress);
        
    } destination:^NSURL * _Nonnull(NSURL * _Nonnull targetPath, NSURLResponse * _Nonnull response) {
        return [pathURL URLByAppendingPathComponent:[response suggestedFilename]];
    } completionHandler:^(NSURLResponse * _Nonnull response, NSURL * _Nullable filePath, NSError * _Nullable error) {
        
        if (error) {
            failure(error);
        }else{
            
            success(response,filePath);
        }
    }];
    
    [downloadtask resume];
    
    return downloadtask;
}

/**初始化manager*/
+(AFHTTPSessionManager *)managerWithBaseURL:(NSString *)baseURL  sessionConfiguration:(BOOL)isconfiguration{
    
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    AFHTTPSessionManager *manager =nil;
    
    NSURL *url = [NSURL URLWithString:baseURL];
    
    
    if (baseURL==nil) {
        manager = [AFHTTPSessionManager manager];
    } else {
        //baseUrl不为空
        if (isconfiguration) {
            
            manager = [[AFHTTPSessionManager alloc] initWithBaseURL:url sessionConfiguration:configuration];
        }else{
            manager = [[AFHTTPSessionManager alloc] initWithBaseURL:url];
        }
        
    }
    
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    return manager;
}





@end
