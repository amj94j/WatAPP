//
//  ViewController.h
//  wat
//
//  Created by 123 on 2018/5/22.
//  Copyright © 2018年 wat0801. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController
@property (nonatomic, strong)NSString *navTitle;//title
@property (nonatomic, strong)NSString *navBackTitle;//返回按钮文字（默认为空）
@property (nonatomic, strong)NSString *navBackImage;//返回按钮文字（默认为空）
@property (nonatomic, strong)NSString *backTitle;
@property (nonatomic, strong)NSString *backImage;

@property (nonatomic, assign)BOOL isBackTitle;//返回按钮是否显示（默认显示）
@property (nonatomic, strong)NSArray *rightTitles;//右侧按钮
@property (nonatomic, strong)NSArray *rightImages;//右侧按钮图片

-(void)backAction;// 返回按钮点击事件（默认pop）
-(void)titleAction;// title按钮点击事件

- (void)rightBtnsAction:(UIButton *)button;// 右侧按钮点击事件

//新导航
@property (nonatomic,strong)UIView *navBarView;
@property (nonatomic,strong)UILabel *titleLa;

@end

