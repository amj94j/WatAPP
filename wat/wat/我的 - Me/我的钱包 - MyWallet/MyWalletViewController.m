//
//  MyWalletViewController.m
//  wat
//
//  Created by 123 on 2018/5/29.
//  Copyright © 2018年 wat0801. All rights reserved.
//

#import "MyWalletViewController.h"
#import "ZWHCountingLabel.h"//label 数字滚动
#import "WalletDetailViewController.h"
#import "WalletChongzhiTixianViewController.h"
@interface MyWalletViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *messageArr;//cell数据源

@property (nonatomic, strong)NSString *moneyStr;
@end

@implementation MyWalletViewController
-(UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, MyTopHeight, MyKScreenWidth, MyKScreenHeight - MyTopHeight) style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.contentInset = UIEdgeInsetsMake(200, 0, 0, 0);
    }
    return _tableView;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = WatBackColor;
    self.navTitle = @"我的钱包";
    self.rightTitles = @[@"明细"];
    //界面加载数据
    NSString *path= [[NSBundle mainBundle]pathForResource:@"MEWalletList" ofType:@"plist"];
    _messageArr = [NSArray arrayWithContentsOfFile:path];
    
    
    [self addTableView];
}

- (void) addTableView {
    [self.view addSubview:self.tableView];
    UIView *headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, MyKScreenWidth, 0.1)];
    self.tableView.tableHeaderView = headerView;
    self.tableView.backgroundColor = WatBackColor;
    
    
    UIImageView *imgView = [[UIImageView alloc]initWithFrame:CGRectMake(0, -200, MyKScreenWidth, 200)];
    imgView.image = [UIImage imageNamed:@"钱包背景图"];
    imgView.contentMode = 3;
    [self.tableView addSubview:imgView];
    
    UIImageView *jinbiImgView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 60, 60)];
    jinbiImgView.image = [UIImage imageNamed:@"64-金币-2"];
    jinbiImgView.center = Center(imgView.center.x, 60);
    [imgView addSubview:jinbiImgView];
    
    
    /**
     数字滚动
     */
    //_moneyStr
    
    ZWHCountingLabel *myLabel = [[ZWHCountingLabel alloc] initWithFrame:CGRectMake(40, 100, imgView.frame.size.width - 80, 40)];
    myLabel.font = [UIFont fontWithName:@"Avenir Next" size:28];
    myLabel.textColor = [UIColor whiteColor];
    myLabel.textAlignment = NSTextAlignmentCenter;
    [imgView addSubview:myLabel];
    //设置文本样式
    //整数
    myLabel.format = @"%d";
    //浮点数样式数字
    myLabel.format = @"%.2f";
    //设置变化范围及动画时间
    //整数
    [myLabel countFrom:0 to:100 withDuration:3.0f];
    //浮点数
    [myLabel countFrom:0.00 to:4324.12 withDuration:3.0f];
    myLabel.positiveFormat = @"###,##0.00";
    myLabel.adjustsFontSizeToFitWidth=YES;
    
    UILabel *miaoshuLab = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, MyKScreenWidth, 12)];
    miaoshuLab.center = Center(imgView.center.x, myLabel.frame.size.height + myLabel.frame.origin.y + 2);
    miaoshuLab.textAlignment = NSTextAlignmentCenter;
    miaoshuLab.text = @"钱包余额(元)";
    miaoshuLab.textColor = [UIColor whiteColor];
    miaoshuLab.font = commenAppFont(9);
    miaoshuLab.adjustsFontSizeToFitWidth = YES;
    [imgView addSubview:miaoshuLab];
}
#pragma 三问一答
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return _messageArr.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    NSArray *arr;
    for (int i = 0; i < _messageArr.count; i++) {
        if (section == i) {
            arr = _messageArr[i];
        }
    }
    //NSLog(@"--------%ld",arr.count);
    return arr.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *identifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        cell.backgroundColor = [UIColor whiteColor];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;//显示箭头
    }
    
    NSString *imgName;
    NSArray *arr = _messageArr[indexPath.section];
    NSDictionary *dic = arr[indexPath.row];
    imgName = [dic valueForKey:@"cellIconName"];
    UIImage *image = [UIImage imageNamed:imgName];
    cell.imageView.image = image;
    
    cell.textLabel.text = [dic valueForKey:@"cellName"];
    cell.textLabel.font = commenAppFont(16);
    cell.textLabel.textColor = [UIColor grayColor];
    
    CGSize itemSize = CGSizeMake(20, 20);
    UIGraphicsBeginImageContextWithOptions(itemSize, NO, UIScreen.mainScreen.scale);
    CGRect imageRect = CGRectMake(0.0, 0.0, itemSize.width, itemSize.height);
    [cell.imageView.image drawInRect:imageRect];
    cell.imageView.image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    cell.imageView.contentMode = 2;
    
    UIView *fengeView = [[UIView alloc]initWithFrame:CGRectMake(0, cell.frame.size.height - 0.5, MyKScreenWidth, 0.5)];
    fengeView.backgroundColor = [UIColor grayColor];
    fengeView.alpha = 0.2;
    [cell addSubview:fengeView];
    
    
    
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    WalletChongzhiTixianViewController *vc = [WalletChongzhiTixianViewController new];
    [self.navigationController pushViewController:vc animated:YES];
    if (indexPath.row == 0) {
        vc.type = @"0";
        vc.navTitle = @"充值";
    }else{
        vc.type = @"1";
        vc.navTitle = @"提现";
        
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 0.01;
}

- (void)rightBtnsAction:(UIButton *)button{
    WalletDetailViewController *vc = [WalletDetailViewController new];
    [self.navigationController pushViewController:vc animated:YES];
    
}
@end
