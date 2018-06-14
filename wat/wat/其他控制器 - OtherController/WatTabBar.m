//
//  WatTabBar.m
//  wat
//
//  Created by 123 on 2018/5/22.
//  Copyright © 2018年 wat0801. All rights reserved.
//

#import "WatTabBar.h"

@implementation WatTabBar

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(instancetype)initWithFrame:(CGRect)frame{
    
    
    if (self =[super initWithFrame:frame]) {
        UIView *v = [[UIView alloc]initWithFrame:CGRectMake(0, 0, MyKScreenWidth, MyTabBarHeight)];
        v.backgroundColor = [UIColor whiteColor];
        [self addSubview:v];
        if (KIsiPhoneX) {
            //NSLog(@"%lf",MyTabBarHeight);
        }
    }
    return self;
}

@end
