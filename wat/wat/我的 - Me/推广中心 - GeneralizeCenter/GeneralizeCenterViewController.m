//
//  GeneralizeCenterViewController.m
//  wat
//
//  Created by 123 on 2018/5/29.
//  Copyright © 2018年 wat0801. All rights reserved.
//

#import "GeneralizeCenterViewController.h"
#import "GeneralizeTableViewCell.h"
@interface GeneralizeCenterViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@end

@implementation GeneralizeCenterViewController
- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, MyTopHeight, MyKScreenWidth, MyKScreenHeight - MyTopHeight)];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.contentInset = UIEdgeInsetsMake(10, 0, 0, 0);
        
    }
    return _tableView;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = WatBackColor;
    self.navTitle = @"推广中心";
    [self addTableView];
}

- (void)addTableView {
    //self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;//隐藏分割线
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
    GeneralizeTableViewCell  *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[[NSBundle mainBundle]loadNibNamed:@"GeneralizeTableViewCell" owner:self options:nil]firstObject];
    }
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];// （这种是没有点击后的阴影效果)
    return cell;
}

- (CGFloat )tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 81;
}

@end
