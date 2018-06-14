//
//  WatLoginViewController.m
//  wat
//
//  Created by 123 on 2018/5/22.
//  Copyright © 2018年 wat0801. All rights reserved.
//

#import "WatLoginViewController.h"
#import "MessageCordView.h"

@interface WatLoginViewController ()<UIScrollViewDelegate>
@property (nonatomic ,strong) UIScrollView *scrollView;
@property (nonatomic, strong) UITextField *PhoneNBTF;//手机号输入框
@property (nonatomic, strong) MessageCordView *coreView;//验证码输入框
@end

@implementation WatLoginViewController
- (UIScrollView *)scrollView{
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, MyKScreenWidth, MyKScreenHeight)];
        _scrollView.delegate = self;
        _scrollView.contentSize = CGSizeMake(MyKScreenWidth, MyKScreenHeight + 1);
    }
    return _scrollView;
}



- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navTitle = @"登陆/注册";
    
    [self addScrollView];
    UIImageView *logoImgVIew = [[UIImageView alloc] initWithFrame:CGRectMake(141, MyTopHeight + 61, 92, 88)];
    logoImgVIew.layer.cornerRadius = 19;
    logoImgVIew.image = [UIImage imageNamed:@"logo-big"];
    logoImgVIew.layer.backgroundColor = [[UIColor colorWithRed:181.0f/255.0f green:181.0f/255.0f blue:181.0f/255.0f alpha:1.0f] CGColor];
    [self.scrollView addSubview:logoImgVIew];
    self.scrollView.backgroundColor = WatBackColor;
    
    //手机号输入框
    UIImageView *phoneImageV = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"shurukuangBG"]];
    phoneImageV.frame = CGRectMake(37.5, MyTopHeight + 180, 300, 50);
    [self.scrollView addSubview:phoneImageV];
    
    //验证码输入框
    UIImageView *coreBGView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"shurukuangBG"]];
    coreBGView.frame = CGRectMake(37.5, MyTopHeight + 250, 300, 50);
    [self.scrollView addSubview:coreBGView];
    
    UITextField *PhoneNBTF = [[UITextField alloc]initWithFrame:CGRectMake(40, MyTopHeight + 240, 295, 50)];//
    self.PhoneNBTF = PhoneNBTF;
    PhoneNBTF.backgroundColor = [UIColor whiteColor];
    PhoneNBTF.font = [UIFont systemFontOfSize:14];
    PhoneNBTF.textColor = [UIColor grayColor];
    PhoneNBTF.placeholder = @"请输入验证码";
    PhoneNBTF.clearButtonMode = UITextFieldViewModeWhileEditing;
    PhoneNBTF.keyboardType = UIKeyboardTypePhonePad;
    PhoneNBTF.layer.borderWidth = 0;
    PhoneNBTF.layer.cornerRadius = 25;
    PhoneNBTF.layer.masksToBounds = YES;
    PhoneNBTF.backgroundColor = [UIColor whiteColor];
    [self.scrollView addSubview:PhoneNBTF];

    UIImageView *phoneNBImV = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"suozi"]];
    phoneNBImV.frame = CGRectMake(0, 0, 17, 24);
    phoneNBImV.contentMode = UIViewContentModeScaleAspectFit;
    UIView *v = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 60, 47)];
    phoneNBImV.center = v.center;
    [v addSubview:phoneNBImV];
    PhoneNBTF.leftViewMode = UITextFieldViewModeAlways;
    PhoneNBTF.leftView = v;
    
    
    
    MessageCordView *coreView =[[MessageCordView alloc]initWithFrame:CGRectMake(40, MyTopHeight + 170, 295, 50)];
    self.coreView = coreView;
    [self.scrollView addSubview:coreView];
    
    //确定按钮
    UIImageView *loginBtnBGView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"shurukuangBG"]];
    loginBtnBGView.frame = CGRectMake(37.5, MyTopHeight + 330, 300, 50);
    [self.scrollView addSubview:loginBtnBGView];
    
    UIButton *loginBtn = [[UIButton alloc]initWithFrame:CGRectMake(40, MyTopHeight + 320, 295, 50)];
    [loginBtn setBackgroundColor:CommonAppColor];
    loginBtn.layer.borderWidth = 0;
    loginBtn.layer.cornerRadius = 25;
    loginBtn.layer.masksToBounds = YES;
    [loginBtn setTitle:@"登    陆" forState:UIControlStateNormal];
    [loginBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [loginBtn setTitleColor:[UIColor yellowColor] forState:UIControlStateHighlighted];
    [loginBtn addTarget:self action:@selector(loginBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.scrollView addSubview:loginBtn];
    
    //提示按钮
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:@"温馨提示：未注册的手机号，登录时将自动注册，且代表您已同意《用户服务协议》"];
    [str addAttribute:NSForegroundColorAttributeName value:[UIColor grayColor] range:NSMakeRange(0,29)];
    [str addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"Arial-BoldItalicMT" size:12] range:NSMakeRange(0, 7)];
    [str addAttribute:NSForegroundColorAttributeName value:ColorWithRGB(3, 106, 233) range:NSMakeRange(29,str.length-29)];
    [str addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"Arial-BoldItalicMT" size:12] range:NSMakeRange(7,str.length-7)];

    UIButton *tishiBtn = [[UIButton alloc]initWithFrame:CGRectMake(40, MyTopHeight + 370, 295, 20)];
    [tishiBtn setAttributedTitle:str forState:UIControlStateNormal];
    tishiBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
    tishiBtn.titleLabel.adjustsFontSizeToFitWidth = YES;
    [self.scrollView addSubview:tishiBtn];
    //tishiBtn添加手势，进入用户协议界面
    UITapGestureRecognizer *tishiTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clickTishiLab)];
    [tishiBtn addGestureRecognizer:tishiTap];
    
    //三方登陆
    UIImageView *sanfangImageV = [[UIImageView alloc]initWithFrame:CGRectMake(40, MyTopHeight + 440, 295, 40)];
    sanfangImageV.image = [UIImage imageNamed:@"sanfangdenglu"];
    sanfangImageV.contentMode = UIViewContentModeScaleAspectFit;
    [self.scrollView addSubview:sanfangImageV];
    
    UIButton *weicahtBtn = [[UIButton alloc]initWithFrame:CGRectMake(MyKScreenWidth * 0.5 - 25, MyTopHeight + 500, 50, 50)];
    [weicahtBtn setImage:[UIImage imageNamed:@"weichat"] forState:UIControlStateNormal];
    [weicahtBtn addTarget:self action:@selector(weichatClick) forControlEvents:UIControlEventTouchUpInside];
    [self.scrollView addSubview:weicahtBtn];
    
    
    //view添加手势，取消第一响应者
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clickView)];
    [self.scrollView addGestureRecognizer:tap];
}

- (void)addScrollView {
    [self.view addSubview:self.scrollView];
    
}
- (void)loginBtnClick{
    NSLog(@"手机号:%@\n 验证码:%@",self.coreView.rechargeField.text,self.PhoneNBTF.text);
    NSLog(@"点击了确定登陆按钮");
    NSString *pNumStr = self.coreView.rechargeField.text;
    NSString * coreNum = self.PhoneNBTF.text;
    if ([[ZWHHelper sharedHelper]isPhoneByMobileNum:pNumStr] && ValidStr(coreNum)) {
        [[ZWHHelper sharedHelper]addAlertViewControllerToView:[ZWHHelper rootTabbarViewController] withClickBlock:^(int clickInt) {

        } title:@"提示" content:@"请核对信息后" cancleStr:@"" confirmStr:@"确定"];
    }else{
        NSMutableDictionary *dic = [NSMutableDictionary dictionary];
        [dic setObject:self.coreView.rechargeField.text forKey:@"phone"];
        [dic setObject:self.PhoneNBTF.text forKey:@"code"];
        [Request GET:@"/api/site/login" parameters:dic success:^(id responseObject) {


        } failure:^(NSError *error) {

        }];

    }
    
//    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
//    [dic setObject:self.coreView.rechargeField.text forKey:@"phone"];
//    [dic setObject:self.PhoneNBTF.text forKey:@"code"];
//    [Request GET:@"/api/site/login" parameters:dic success:^(id responseObject) {
//
//
//    } failure:^(NSError *error) {
//
//    }];
    
    
    
}
- (void) clickView {
    [self.PhoneNBTF resignFirstResponder];
    [self.coreView.rechargeField resignFirstResponder];
    NSLog(@"点击屏幕，取消第一响应者");
}
- (void)clickTishiLab {
    NSLog(@"点击了用户协议按钮");
    
}

- (void) weichatClick {
    
    NSLog(@"点击了三方登陆，微信");
}
@end
