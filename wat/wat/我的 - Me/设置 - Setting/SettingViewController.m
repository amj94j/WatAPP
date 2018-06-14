//
//  SettingViewController.m
//  wat
//
//  Created by 123 on 2018/5/29.
//  Copyright © 2018年 wat0801. All rights reserved.
//

#import "SettingViewController.h"
#import "AboutUsViewController.h"
#import "WatLoginViewController.h"
@interface SettingViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *messageArr;//cell数据源

@property (nonatomic, strong)NSString *moneyStr;
@end

@implementation SettingViewController
-(UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, MyTopHeight, MyKScreenWidth, MyKScreenHeight - MyTopHeight) style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        //_tableView.contentInset = UIEdgeInsetsMake(160, 0, 0, 0);
    }
    return _tableView;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = WatBackColor;
    self.navTitle = @"设置";
    
    
    
    //界面加载数据
    NSString *path= [[NSBundle mainBundle]pathForResource:@"set" ofType:@"plist"];
    _messageArr = [NSArray arrayWithContentsOfFile:path];
    
    
    [self addTableView];
    
    
}

- (void) addTableView {
    [self.view addSubview:self.tableView];
    self.tableView.backgroundColor = [UIColor clearColor];
    
    
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
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator; //显示最右边的箭头
    NSArray *arr = _messageArr[indexPath.section];
    NSDictionary *dic = arr[indexPath.row];
    
    cell.textLabel.text = [dic valueForKey:@"cellName"];
    cell.textLabel.font = commenAppFont(16);
    cell.textLabel.textColor = [UIColor darkGrayColor];
    
    
    
    UIView *fengeView = [[UIView alloc]initWithFrame:CGRectMake(0, cell.frame.size.height - 0.5, MyKScreenWidth, 0.5)];
    fengeView.backgroundColor = [UIColor grayColor];
    fengeView.alpha = 0.2;
    [cell addSubview:fengeView];
    
    
    
    
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0 && indexPath.row == 0) {
        NSLog(@"%ld++++%ld",indexPath.section,indexPath.row);
        [[ZWHHelper sharedHelper]addAlertViewControllerToView:[ZWHHelper rootTabbarViewController] withClickBlock:nil title:@"清空缓存成功!" content:@"" cancleStr:nil confirmStr:@"确定"];
    
    }else if (indexPath.section == 0 && indexPath.row == 1){
        NSLog(@"%ld++++%ld",indexPath.section,indexPath.row);
        AboutUsViewController *aboutUsVC = [[AboutUsViewController alloc]init];
        [self.navigationController pushViewController:aboutUsVC animated:YES];
    }else if (indexPath.section == 1 && indexPath.row == 0){
        NSLog(@"%ld++++%ld",indexPath.section,indexPath.row);
        WatLoginViewController *loginVc = [WatLoginViewController new];
        [self.navigationController pushViewController:loginVc animated:YES];
    }else{
        NSLog(@"%ld++++%ld",indexPath.section,indexPath.row);
        [self.navigationController popViewControllerAnimated:YES];
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 10;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    return 0.01;
}

@end


