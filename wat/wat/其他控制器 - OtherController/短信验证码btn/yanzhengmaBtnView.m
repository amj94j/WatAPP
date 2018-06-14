//
//  yanzhengmaBtnView.m
//  wat
//
//  Created by 123 on 2018/5/23.
//  Copyright © 2018年 wat0801. All rights reserved.
//

#import "yanzhengmaBtnView.h"

@implementation yanzhengmaBtnView

+(UIButton *)creatButtonWithFrame:(CGRect)frame title:(NSString *)title tag:(NSInteger)tag tintColor:(UIColor *)tintColor backgroundColor:(UIColor *)backgroundColor{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:title forState:UIControlStateNormal];
    button.tag = tag;
    button.backgroundColor  = backgroundColor;
    button.tintColor=  tintColor;
    button.frame = frame;
    [button setTitleColor:tintColor forState:UIControlStateNormal];
    return button;
}

@end
