//
//  ByClassViewController.m
//  wat
//
//  Created by 123 on 2018/6/11.
//  Copyright © 2018年 wat0801. All rights reserved.
//

#import "ByClassViewController.h"
#import "ByClassViewController.h"
#import "MeSettingViewController.h"
@interface ByClassViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@end

@implementation ByClassViewController
- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, MyTopHeight, MyKScreenWidth, MyKScreenHeight - MyTopHeight) style:UITableViewStyleGrouped];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.contentInset = UIEdgeInsetsMake(10, 0, 0, 0);
    }
    
    return _tableView;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    [self addTableView];
    
    UIButton *bottomBtn = [[UIButton alloc]initWithFrame:CGRectMake(13, MyKScreenHeight - MyTabBarHeight, MyKScreenWidth - 26, 42)];
    [bottomBtn setTitle:@"确认付款" forState: UIControlStateNormal];
    bottomBtn.backgroundColor = CommonAppColor;
    [bottomBtn addTarget:self action:@selector(bottomBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:bottomBtn];
}
- (void)addTableView {
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor = WatBackColor;
    self.tableView.sectionHeaderHeight = 0;
    self.tableView.sectionFooterHeight = 8.0;
    [self.view addSubview:self.tableView];
    
    //在iOS 11上运行tableView向下偏移64px或者20px，因为iOS 11废弃了automaticallyAdjustsScrollViewInsets，而是给UIScrollView增加了contentInsetAdjustmentBehavior属性。避免这个坑的方法是要判断
    if (@available(iOS 11.0, *)) {
        _tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }else {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    
}
#pragma UITableView 三问一答
- (NSInteger )numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 3;
}
- (NSInteger )tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSInteger sectionNum;
    if (section == 0) {
        sectionNum = 2;
    }else if (section == 1){
        sectionNum = 3;
    }else{
        sectionNum = 1;
    }
    return sectionNum;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ///<1.>设置标识符
    static NSString * str = @"cellStr";
    ///<2.>复用机制:如果一个页面显示7个cell，系统则会创建8个cell,当用户向下滑动到第8个cell时，第一个cell进入复用池等待复用。
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:str];
    
    ///<3.>新建cell
    if (cell == nil) {
        //副标题样式
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:str];
        if (indexPath.section == 0) {
            if (indexPath.row == 0) {
                cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator; //显示最右边的箭头
                UILabel *classNameLab = [[UILabel alloc]initWithFrame:CGRectMake(13, 15, MyKScreenWidth, 15)];
                classNameLab.font = commenAppFont(15);
                classNameLab.text = @"个人信息";
                [cell addSubview:classNameLab];
                
                UIView *lineV = [[UIView alloc]initWithFrame:CGRectMake(0, cell.frame.size.height - 1, MyKScreenWidth, 1)];
                lineV.backgroundColor = CommonAppColor;
                [cell addSubview:lineV];
                
            }else{
                //cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator; //显示最右边的箭头
                
                UIImageView *imgView = [[UIImageView alloc]initWithFrame:CGRectMake(13, 12, 76, 59)];
                imgView.image = [UIImage imageNamed:@"1234567890"];
                [cell addSubview:imgView];
                
                UILabel *titleLab = [[UILabel alloc]initWithFrame:CGRectMake(imgView.frame.origin.x + imgView.frame.size.width + 22, imgView.frame.origin.y, MyKScreenWidth - imgView.frame.origin.x + imgView.frame.size.width - 30, 20)];
                titleLab.text = @"王牌店长特训营XXXXX|第一期  北京站....";
                titleLab.font = commenAppFont(13);
                titleLab.textColor = [UIColor blackColor];
                [cell addSubview:titleLab];
                
                UILabel *timeLab = [[UILabel alloc]initWithFrame:CGRectMake(titleLab.frame.origin.x, titleLab.frame.size.height + titleLab.frame.origin.y + 7, titleLab.frame.size.width * 0.5, 9)];
                timeLab.font = commenAppFont(9);
                timeLab.textColor = [UIColor grayColor];
                timeLab.text = @"开课时间：6月10日-6月12日";
                [cell addSubview:timeLab];
                
                UILabel *moneyLab = [[UILabel alloc]initWithFrame:CGRectMake(timeLab.frame.origin.x, timeLab.frame.origin.y + timeLab.frame.size.height + 10, 100, 12)];
                moneyLab.text = @"￥599.00";
                moneyLab.font = commenAppFont(12);
                moneyLab.textColor = [UIColor blackColor];
                [cell addSubview:moneyLab];
            }
            
        }else if (indexPath.section == 1) {
//            if (indexPath.row == 0) {
//                UILabel *tingkemaLab = [[UILabel alloc]initWithFrame:CGRectMake(13, 0, MyKScreenWidth - 13, cell.frame.size.height)];
//                tingkemaLab.text = @"听课码:73982056569";
//                tingkemaLab.font = commenAppFont(12);
//                [cell addSubview:tingkemaLab];
//            }else if (indexPath.row == 1) {
//                UILabel *orderNumLab = [[UILabel alloc]initWithFrame:CGRectMake(13, 5, MyKScreenWidth - 13, cell.frame.size.height * 0.5)];
//                orderNumLab.text = @"订单编号：73982056569";
//                orderNumLab.font = commenAppFont(12);
//                [cell addSubview:orderNumLab];
//
//                UILabel *orderTimeLab = [[UILabel alloc]initWithFrame:CGRectMake(13, cell.frame.size.height/2 + 5, MyKScreenWidth - 13, cell.frame.size.height * 0.5)];
//                orderTimeLab.text = @"下单时间：2018-05-18 00：01：45";
//                orderTimeLab.font = commenAppFont(12);
//                [cell addSubview:orderTimeLab];
//
//            }else {
//                UILabel * payTypeLab = [[UILabel alloc]initWithFrame:CGRectMake(13, 5, MyKScreenWidth - 13, cell.frame.size.height * 0.5)];
//                payTypeLab.text = @"支付方式:微信支付";
//                payTypeLab.font = commenAppFont(12);
//                [cell addSubview:payTypeLab];
//
//                UILabel *payTimeLab = [[UILabel alloc]initWithFrame:CGRectMake(13, cell.frame.size.height/2 + 5, MyKScreenWidth - 13, cell.frame.size.height * 0.5)];
//                payTimeLab.text = @"支付时间：2018-05-18 00：02：18";
//                payTimeLab.font = commenAppFont(12);
//                [cell addSubview:payTimeLab];
//            }
        }else{
            cell.backgroundColor = [UIColor clearColor];
            UIImageView *bgImgView = [[UIImageView alloc]initWithFrame:CGRectMake(-13, 0, MyKScreenWidth + 26, 170)];
            bgImgView.image = [UIImage imageNamed:@"多边形1094"];
            //bgImgView.contentMode = 3;
            [cell addSubview:bgImgView];
            
            UILabel *nameLab = [[UILabel alloc]initWithFrame:CGRectMake(13, 15, 200, 11)];
            nameLab.text = @"商品总额";
            nameLab.font = commenAppFont(12);
            [cell addSubview:nameLab];
            
            UILabel *numLab = [[UILabel alloc]initWithFrame:CGRectMake(13, 15 + 11 + 15, 200, 11)];
            numLab.text = @"购买数量";
            numLab.font = commenAppFont(12);
            [cell addSubview:numLab];
            
            UILabel *yunfeiLab = [[UILabel alloc]initWithFrame:CGRectMake(13, 15 + 11 + 15 +11 + 15, 200, 11)];
            yunfeiLab.text = @"运费";
            yunfeiLab.font = commenAppFont(12);
            [cell addSubview:yunfeiLab];
            
            UILabel *name2Lab = [[UILabel alloc]initWithFrame:CGRectMake(MyKScreenWidth - 200 - 13, nameLab.frame.origin.y, 200, 11)];
            name2Lab.text = @"¥599.0";
            name2Lab.font = commenAppFont(12);
            name2Lab.textAlignment = NSTextAlignmentRight;
            [cell addSubview:name2Lab];
            
            UILabel *num2Lab = [[UILabel alloc]initWithFrame:CGRectMake(MyKScreenWidth - 200 - 13, numLab.frame.origin.y,200, 11)];
            num2Lab.text = @"1个";
            num2Lab.font = commenAppFont(12);
            num2Lab.textAlignment = NSTextAlignmentRight;
            [cell addSubview:num2Lab];
            
            UILabel *yunfei2Lab = [[UILabel alloc]initWithFrame:CGRectMake(MyKScreenWidth - 200 - 13, yunfeiLab.frame.origin.y, 200, 11)];
            yunfei2Lab.text = @"¥0.00";
            yunfei2Lab.font = commenAppFont(12);
            yunfei2Lab.textAlignment = NSTextAlignmentRight;
            [cell addSubview:yunfei2Lab];
            
            UILabel *fengexianLab = [[UILabel alloc]initWithFrame:CGRectMake(0, yunfei2Lab.frame.origin.y + yunfei2Lab.frame.size.height + 15, MyKScreenWidth, 0.2)];
            fengexianLab.backgroundColor = [UIColor grayColor];
            fengexianLab.alpha = 0.3;
            [cell addSubview:fengexianLab];
            
            UILabel *shijiMoney = [[UILabel alloc]initWithFrame:CGRectMake(13, fengexianLab.frame.origin.y + fengexianLab.frame.size.height + 15, 200, 16)];
            shijiMoney.text = @"实际付款";
            shijiMoney.font = commenAppFont(16);
            [cell addSubview:shijiMoney];
            
            UILabel *shijiMoney2 = [[UILabel alloc]initWithFrame:CGRectMake(MyKScreenWidth - 200 - 13, shijiMoney.frame.origin.y, 200, 16)];
            shijiMoney2.text = @"¥599.00";
            shijiMoney2.textAlignment = NSTextAlignmentRight;
            shijiMoney2.textColor = CommonAppColor;
            shijiMoney2.font = commenAppFont(16);
            [cell addSubview:shijiMoney2];
            
//            UIImageView *shuiyingImgV = [[UIImageView alloc]initWithFrame:CGRectMake(100, 40, 88, 88)];
//            shuiyingImgV.contentMode = 2;
//            shuiyingImgV.image = [UIImage imageNamed:@"已使用"];
//            [cell addSubview:shuiyingImgV];
            
        }
    }
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];// （这种是没有点击后的阴影效果)
    
    ///<4.>设置单元格上显示的文字信息
    
    
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0 && indexPath.row == 0) {
        MeSettingViewController *vc = [MeSettingViewController new];
        vc.navTitle = @"购买信息";
        [self.navigationController pushViewController:vc animated:YES];
        
        
    }else{
        
        
    }
    
    
}
- (CGFloat )tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    CGFloat heightNum;
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            heightNum = 45;
        }else{
            heightNum = 81;
        }
    }else if (indexPath.section == 1) {
//        if (indexPath.row == 0) {
//            heightNum = 44;
//        }else if (indexPath.row == 1) {
//            heightNum = 50;
//        }else {
//            heightNum = 60;
//        }
        return 0;
    }else{
        heightNum = 145;
    }
    
    return heightNum;
}
- (  CGFloat )tableView:(  UITableView *)tableView heightForHeaderInSection:( NSInteger )section
{
    return 0.01 ;
}
- (void) bottomBtnClick{
    NSLog(@"点击了购买课程按钮");
    NSArray *chooses = @[@"微信支付"];;
    
    [[ZWHHelper sharedHelper]alertActionSheet:chooses AndView:self withClickBlock:^(int clickInt, NSString *message) {
        if (clickInt == 0)
        {
            
            
        }if (clickInt == 1)
        {
            
            
        }
        
    }];
    
}

@end
