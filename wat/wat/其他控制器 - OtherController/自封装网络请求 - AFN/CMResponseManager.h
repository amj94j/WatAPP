//
//  CMResponseManager.h
//  KaMi
//
//  Created by 智借iOS on 2018/5/22.
//  Copyright © 2018年 CrabMan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CMResponseManager : NSObject

CM_SINGLETON_DEF(CMResponseManager);

- (void)cm_resolveApi:(NSString *)api Params:(NSDictionary *)params ReponseData:(NSDictionary *)response ;
@end
