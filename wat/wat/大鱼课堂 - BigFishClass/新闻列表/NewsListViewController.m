//
//  NewsListViewController.m
//  wat
//
//  Created by 123 on 2018/6/8.
//  Copyright © 2018年 wat0801. All rights reserved.
//

#import "NewsListViewController.h"
#import "HomeNewsDetailTableViewCell.h"
@interface NewsListViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@end

@implementation NewsListViewController
- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, MyTopHeight, MyKScreenWidth, MyKScreenHeight - 6-MyStatusBarHeight) style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
    }
    return _tableView;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navTitle = @"内参新闻";
    
    [self.view addSubview:self.tableView];
    UIView *headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, MyKScreenWidth, 6)];
    self.tableView.tableHeaderView = headerView;
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 20;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *identifer = @"Cell";
    HomeNewsDetailTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifer];
    if (!cell) {
        cell = [[[NSBundle mainBundle]loadNibNamed:@"HomeNewsDetailTableViewCell" owner:self options:nil]firstObject];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return  115;
}

@end
