//
//  WalletChongzhiTixianViewController.m
//  wat
//
//  Created by 123 on 2018/6/11.
//  Copyright © 2018年 wat0801. All rights reserved.
//

#import "WalletChongzhiTixianViewController.h"

@interface WalletChongzhiTixianViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong)UITableView *tableView;
@property (nonatomic, strong)UITextField *moneyTF;
@end

@implementation WalletChongzhiTixianViewController
- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, MyTopHeight, MyKScreenWidth, MyKScreenHeight - MyTopHeight) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        //_tableView.contentInset = UIEdgeInsetsMake(220, 0, 0, 0);
        _tableView.backgroundColor = WatBackColor;
    }
    return _tableView;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    [self addTableView];
    
}
- (void)addTableView {
    [self.view addSubview:self.tableView];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;//隐藏分割线 tableViewCell
    
    UIButton *kefuBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, self.tableView.frame.size.height - 55, MyKScreenWidth, 45)];
    [kefuBtn setTitle:@"联系客服" forState: UIControlStateNormal];
    [kefuBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [kefuBtn addTarget:self action:@selector(kefuBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.tableView addSubview:kefuBtn];
    
    
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell"];
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        cell.backgroundColor = WatBackColor;
        
        UIView *bgv = [[UIView alloc]initWithFrame:CGRectMake(10, 5, MyKScreenWidth - 20, 210)];
        bgv.backgroundColor = [UIColor whiteColor];
        [cell addSubview:bgv];
        
        UILabel *nameLab = [[UILabel alloc]initWithFrame:CGRectMake(10, 15, 100, 20)];
        if ([self.type isEqualToString:@"0"]) {
            nameLab.text = @"充值金额";
        } else{
            nameLab.text = @"提现金额";
        }
        nameLab.textAlignment = NSTextAlignmentLeft;
        nameLab.textColor = [UIColor blackColor];
        nameLab.font = commenAppFont(15);
        [bgv addSubview:nameLab];
        
        UILabel *renmingbiLogoLab = [[UILabel alloc]initWithFrame:CGRectMake(15, 74, 24, 27)];
        renmingbiLogoLab.text = @"¥";
        renmingbiLogoLab.textColor = [UIColor darkTextColor];
        renmingbiLogoLab.font = commenAppFont(36);
        renmingbiLogoLab.textAlignment = NSTextAlignmentLeft;
        [bgv addSubview:renmingbiLogoLab];
        
        UITextField *moneyTF = [[UITextField alloc]initWithFrame:CGRectMake(40, 74, MyKScreenWidth - 15 - 24 - 15 - 30, 27)];
        self.moneyTF = moneyTF;
        self.moneyTF.clearButtonMode = UITextFieldViewModeWhileEditing;
        self.moneyTF.keyboardType = UIKeyboardTypeDecimalPad;//带小数点的键盘
        moneyTF.placeholder = @"请输入金额";
        moneyTF.textAlignment = NSTextAlignmentRight;
        moneyTF.borderStyle = UITextBorderStyleNone;
        [bgv addSubview:moneyTF];
        
        UIView *lineV = [[UIView alloc]initWithFrame:CGRectMake(15, moneyTF.frame.size.height + moneyTF.frame.origin.y
                                                                + 10, MyKScreenWidth - 15 - 15 - 30, 0.5)];
        lineV.backgroundColor = [UIColor blackColor];
        [bgv addSubview:lineV];
        
        UIButton *sureBtn = [[UIButton alloc]initWithFrame:CGRectMake(15, lineV.frame.origin.y + 35, MyKScreenWidth - 60, 45)];
        sureBtn.backgroundColor = CommonAppColor;
        if ([self.type isEqualToString:@"0"]) {
            [sureBtn setTitle:@"确认充值" forState: UIControlStateNormal];
            sureBtn.tag = 0;
        } else{
            [sureBtn setTitle:@"确认提现" forState: UIControlStateNormal];
            sureBtn.tag = 1;
        }
        [sureBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [sureBtn addTarget:self action:@selector(sureBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [bgv addSubview:sureBtn];
    }
    
    
    return cell;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 220;
}
- (void)sureBtnClick: (UIButton *)sender {
    
    if (!ValidStr(self.moneyTF.text)) {
        [[ZWHHelper sharedHelper]addAlertViewControllerToView:[ZWHHelper rootTabbarViewController] withClickBlock:^(int clickInt) {
            
        } title:@"请输入正确的金额" content:@"" cancleStr:@"" confirmStr:@"确定"];
    } else{
        if (sender.tag == 0) {
            NSArray *chooses = @[@"微信支付"];;
            
            [[ZWHHelper sharedHelper]alertActionSheet:chooses AndView:self withClickBlock:^(int clickInt, NSString *message) {
                if (clickInt == 0)
                {
                    
                    
                }if (clickInt == 1)
                {
                    
                    
                }
                
            }];
            
            
        }else if (sender.tag == 1){
            NSArray *chooses = @[@"提现至微信",@"提现至银行卡"];;
            
            [[ZWHHelper sharedHelper]alertActionSheet:chooses AndView:self withClickBlock:^(int clickInt, NSString *message) {
                if (clickInt == 0)
                {
                    
                    
                }if (clickInt == 1)
                {
                    
                    
                }
                
            }];
            
        }
    }

}
- (void)kefuBtnClick {
    
    NSLog(@"点击了客服电话");
    
    NSMutableString * str=[[NSMutableString alloc] initWithFormat:@"tel:%@",@"010-8464612"];
    UIWebView * callWebview = [[UIWebView alloc] init];
    [callWebview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:str]]];
    [self.view addSubview:callWebview];
}
@end
