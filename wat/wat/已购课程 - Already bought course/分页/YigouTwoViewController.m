//
//  YigouTwoViewController.m
//  wat
//
//  Created by 123 on 2018/5/30.
//  Copyright © 2018年 wat0801. All rights reserved.
//

#import "YigouTwoViewController.h"
#import "YigouTableViewCell.h"
#import "classDetailViewController.h"
@interface YigouTwoViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@end

@implementation YigouTwoViewController
- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, MyKScreenWidth, MyKScreenHeight - MyTopHeight - 44 - MyTabBarHeight)];
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
    //在iOS 11上运行tableView向下偏移64px或者20px，因为iOS 11废弃了automaticallyAdjustsScrollViewInsets，而是给UIScrollView增加了contentInsetAdjustmentBehavior属性。避免这个坑的方法是要判断
    if (@available(iOS 11.0, *)) {
        _tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }else {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    
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
    YigouTableViewCell  *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[[NSBundle mainBundle]loadNibNamed:@"YigouTableViewCell" owner:self options:nil]firstObject];
    }
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];// （这种是没有点击后的阴影效果)
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    classDetailViewController *vc = [classDetailViewController new];
    [vc setHidesBottomBarWhenPushed:YES];
    [self.navigationController pushViewController:vc animated:YES];
    
}
- (CGFloat )tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 81;
}

@end
