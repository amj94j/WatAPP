//
//  AboutUsViewController.m
//  wat
//
//  Created by 123 on 2018/5/29.
//  Copyright © 2018年 wat0801. All rights reserved.
//

#import "AboutUsViewController.h"

#import "ZWHCountingLabel.h"//label 数字滚动
@interface AboutUsViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *messageArr;//cell数据源

@property (nonatomic, strong)NSString *moneyStr;
@end

@implementation AboutUsViewController
-(UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, MyTopHeight, MyKScreenWidth, MyKScreenHeight - MyTopHeight) style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.contentInset = UIEdgeInsetsMake(160, 0, 0, 0);
    }
    return _tableView;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = WatBackColor;
    self.navTitle = @"关于我们";
    
    
    
    //界面加载数据
    NSString *path= [[NSBundle mainBundle]pathForResource:@"aboutUs" ofType:@"plist"];
    _messageArr = [NSArray arrayWithContentsOfFile:path];
    
    
    [self addTableView];
    
    UILabel *banquanLab = [[UILabel alloc]initWithFrame:CGRectMake(0, MyKScreenHeight - 160 - 200, MyKScreenWidth, 100)];
    banquanLab.textAlignment = NSTextAlignmentCenter;
    banquanLab.numberOfLines = 0;
    banquanLab.text = @"北京瓦特新媒网络科技有限公司\n版权所有";
    banquanLab.font = commenAppFont(15);
    banquanLab.textColor = [UIColor darkGrayColor];
    [self.tableView addSubview:banquanLab];
}

- (void) addTableView {
    [self.view addSubview:self.tableView];
    self.tableView.backgroundColor = [UIColor clearColor];
    
    UIView *headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, MyKScreenWidth, 0.1)];
    self.tableView.tableHeaderView = headerView;
    
    UIImageView *imgView = [[UIImageView alloc]initWithFrame:CGRectMake(0, -160, MyKScreenWidth, 160)];
    imgView.backgroundColor = [UIColor clearColor];
    imgView.contentMode = 3;
    [self.tableView addSubview:imgView];
    
    UIImageView *jinbiImgView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 60, 60)];
    jinbiImgView.image = [UIImage imageNamed:@"logo-big"];
    jinbiImgView.center = Center(imgView.center.x, 65);
    [imgView addSubview:jinbiImgView];
    
    
    
    UILabel *miaoshuLab = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, MyKScreenWidth, 14)];
    miaoshuLab.center = Center(imgView.center.x, jinbiImgView.frame.size.height + jinbiImgView.frame.origin.y + 20);
    miaoshuLab.textAlignment = NSTextAlignmentCenter;
    miaoshuLab.text = @"餐饮老板严选 V1.0";
    miaoshuLab.textColor = [UIColor darkGrayColor];
    miaoshuLab.font = commenAppFont(12);
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
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell"];
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        cell.backgroundColor = [UIColor whiteColor];
        
    }
    
    NSArray *arr = _messageArr[indexPath.section];
    NSDictionary *dic = arr[indexPath.row];
    
    cell.textLabel.text = [dic valueForKey:@"cellName"];
    cell.textLabel.font = commenAppFont(16);
    cell.textLabel.textColor = [UIColor darkGrayColor];
    
    cell.detailTextLabel.text = [dic valueForKey:@"cellDetail"];
    cell.detailTextLabel.font = commenAppFont(16);
    cell.detailTextLabel.textColor = [UIColor darkGrayColor];
    cell.detailTextLabel.adjustsFontSizeToFitWidth = YES;
    
    UIView *fengeView = [[UIView alloc]initWithFrame:CGRectMake(0, cell.frame.size.height - 0.5, MyKScreenWidth, 0.5)];
    fengeView.backgroundColor = [UIColor grayColor];
    fengeView.alpha = 0.2;
    [cell addSubview:fengeView];
    
    
    
    
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0 && indexPath.row == 0) {
        NSArray *arr = _messageArr[indexPath.section];
        NSDictionary *dic = arr[indexPath.row];
        NSMutableString * str=[[NSMutableString alloc] initWithFormat:@"tel:%@",[dic valueForKey:@"cellDetail"]];
        UIWebView * callWebview = [[UIWebView alloc] init];
        [callWebview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:str]]];
        [self.view addSubview:callWebview];
        
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 0.01;
}


@end
