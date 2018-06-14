//
//  WHScrollView.h
//  wat
//
//  Created by 123 on 2018/5/24.
//  Copyright © 2018年 wat0801. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^ImageViewClick)(NSInteger index);
@interface WHScrollView : UIView
@property (nonatomic,assign)BOOL isRunloop;//是否开启定时器 default NO
@property (nonatomic,assign)NSTimeInterval dur; //default 3
@property (nonatomic,strong)UIColor *color_pageControl;
@property (nonatomic,strong)UIColor *color_currentPageControl;
@property (nonatomic,strong)ImageViewClick click;
- (instancetype)initWithFrame:(CGRect)frame
                   withImages:(NSArray *)images
                withIsRunloop:(BOOL)isRunloop
                    withBlock:(ImageViewClick)block;

@end
