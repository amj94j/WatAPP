//
//  OneViewController.m
//  wat
//
//  Created by 123 on 2018/5/29.
//  Copyright © 2018年 wat0801. All rights reserved.
//

#import "OrderOneViewController.h"
#import "UnUsedOrderTableViewCell.h"
#import "OrderDetailViewController.h"

@interface OrderOneViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@end

@implementation OrderOneViewController
- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, MyKScreenWidth, MyKScreenHeight - MyTopHeight - 44)];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.contentInset = UIEdgeInsetsMake(10, 0, 0, 0);
    }
    
    return _tableView;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor yellowColor];
    [self addTableView];
    
}
- (void)addTableView {
    //self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor = WatBackColor;
    [self.view addSubview:self.tableView];
    
}
#pragma UITableView 三问一答
- (NSInteger )numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}
- (NSInteger )tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 20;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *ID = @"Cell";
    UnUsedOrderTableViewCell  *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[[NSBundle mainBundle]loadNibNamed:@"UnUsedOrderTableViewCell" owner:self options:nil]firstObject];
    }
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];// （这种是没有点击后的阴影效果)
    cell.typeLabel.hidden = YES;
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    OrderDetailViewController *vc = [OrderDetailViewController new];
    [self.navigationController pushViewController:vc animated:YES];
}
- (CGFloat )tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 81;
}




















@end
