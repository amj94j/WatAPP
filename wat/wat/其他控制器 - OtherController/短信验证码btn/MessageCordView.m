//
//  MessageCordView.m
//  wat
//
//  Created by 123 on 2018/5/23.
//  Copyright © 2018年 wat0801. All rights reserved.
//

#import "MessageCordView.h"
#import "yanzhengmaBtnView.h"

static int countDownTime = 60;
@implementation MessageCordView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        UIView *rechargeView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        rechargeView.backgroundColor = [UIColor whiteColor];
        rechargeView.layer.borderWidth = 0;
        rechargeView.layer.cornerRadius = 25;
        rechargeView.layer.masksToBounds = YES;
        [self addSubview:rechargeView];
        

        
        UIImageView *phoneNBImV = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"ren"]];
        phoneNBImV.frame = CGRectMake(0, 0, 17, 24);
        phoneNBImV.contentMode = UIViewContentModeScaleAspectFit;
        UIView *v = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 60, 47)];
        phoneNBImV.center = v.center;
        [v addSubview:phoneNBImV];
        [rechargeView addSubview:v];
        
        _rechargeField = [[UITextField alloc] initWithFrame:CGRectMake(60, 10, frame.size.width * 0.6, frame.size.height - 20)];
        _rechargeField.font = [UIFont systemFontOfSize:14];
        _rechargeField.clearButtonMode = UITextFieldViewModeWhileEditing;
        _rechargeField.placeholder = @"请输入手机号";
        _rechargeField.keyboardType = UIKeyboardTypePhonePad;
        _rechargeField.borderStyle = UITextBorderStyleNone;
        [rechargeView addSubview:_rechargeField];
        
        _button = [yanzhengmaBtnView creatButtonWithFrame:CGRectMake(frame.size.width - 90, frame.size.height*0.25*0.05 + 12.5, 68, 25) title:@"获取验证码" tag:1000 tintColor:[UIColor whiteColor] backgroundColor:CommonAppColor];
        _button.layer.borderWidth = 0;
        _button.layer.cornerRadius = 12.5;
        _button.layer.masksToBounds = YES;
        _button.titleLabel.font = [UIFont systemFontOfSize:14];
        _button.titleLabel.adjustsFontSizeToFitWidth = YES;
        [_button addTarget:self action:@selector(getVerificationCode) forControlEvents:UIControlEventTouchUpInside];
        [rechargeView addSubview:_button];
    }
    return self;
}

- (void)getVerificationCode
{
    
    
    if (![[ZWHHelper sharedHelper]isPhoneByMobileNum:self.rechargeField.text]) {
        [[ZWHHelper sharedHelper]addAlertViewControllerToView:[ZWHHelper rootTabbarViewController] withClickBlock:^(int clickInt) {
            
        } title:@"您填写的手机号格式有误!" content:@"请输入正确的手机号码" cancleStr:@"" confirmStr:@"确定"];
    }else{
        _label = [[UILabel alloc]initWithFrame:self.button.bounds];
        
        _timer = [[NSTimer alloc]init];
        _timer= [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(countDown) userInfo:nil repeats:YES];
        [_timer setFireDate:[NSDate distantPast]];
        //请求服务器发送短信验证码
        //......
        //NSLog(@"点击了发送验证码按钮");
        
        
        NSMutableDictionary *dic = [NSMutableDictionary dictionary];
        [dic setObject:self.rechargeField.text forKey:@"phone"];
        [dic setObject:@"login" forKey:@"type"];
        [Request GET:@"/api/public/send-sms" parameters:dic success:^(id responseObject) {
            
            
        } failure:^(NSError *error) {
            
        }];
        
    }
}

- (void)countDown
{
    countDownTime--;
    if (countDownTime<=0||countDownTime ==60) {
        _label.hidden = YES;
        _button.hidden = NO;
        _button.userInteractionEnabled = YES;
        [_timer setFireDate:[NSDate distantFuture]];
        countDownTime =60;
    }else{
        _label.hidden = NO;
        _label.text = [NSString stringWithFormat:@"(%ds)重新获取",countDownTime];
        _label.font = [UIFont systemFontOfSize:12];
        _label.adjustsFontSizeToFitWidth = YES;//文字自适应大小
        _label.backgroundColor = CommonAppColor;
        _label.layer.cornerRadius = 8;
        _label.clipsToBounds = YES;
        _label.textAlignment = NSTextAlignmentCenter;
        _label.textColor= [UIColor whiteColor];
        [_button addSubview:_label];
        _button.userInteractionEnabled = NO;
    }
}

@end
