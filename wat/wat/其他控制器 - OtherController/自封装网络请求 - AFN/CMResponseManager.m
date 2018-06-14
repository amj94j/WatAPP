//
//  CMResponseManager.m
//  KaMi
//
//  Created by 智借iOS on 2018/5/22.
//  Copyright © 2018年 CrabMan. All rights reserved.
//

#import "CMResponseManager.h"
@implementation CMResponseManager

CM_SINGLETON_IMP(CMResponseManager);

- (void)cm_resolveApi:(NSString *)api Params:(NSDictionary *)params ReponseData:(NSDictionary *)response {

    NSLog(@"API:%@\nParams:%@\nResponse:%@",api,params,response);
    
    [self resolveUserInfoWithApi:api Response:response];
   
    
}

- (void)resolveUserInfoWithApi:(NSString *)api Response:(NSDictionary *)response {
    

    
}

@end
