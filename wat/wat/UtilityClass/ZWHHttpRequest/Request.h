//
//  Request.h
//  ahaTravel
//
//  Created by ah on 2018/6/6.
//  Copyright © 2018年 gwd. All rights reserved.
//

#import <AFNetworking/AFNetworking.h>

@interface Request : AFHTTPSessionManager
typedef void(^successCallback)(id responseObject);
typedef void(^failureCallback)(NSError *error); 
+(void)GET:(NSString *)relativePath
parameters:(id)parameters
   success:(successCallback)success
   failure:(failureCallback)failure;
+(void)POST:(NSString *)relativePath
 parameters:(id)parameters
    success:(successCallback)success
    failure:(failureCallback)failure;

@end
