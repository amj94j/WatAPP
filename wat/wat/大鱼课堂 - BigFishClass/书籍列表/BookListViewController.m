//
//  BookListViewController.m
//  wat
//
//  Created by 123 on 2018/6/11.
//  Copyright © 2018年 wat0801. All rights reserved.
//

#import "BookListViewController.h"
#import "HomeNewsDetailTableViewCell.h"
#import "BookDetailViewController.h"
#import "BookListTableViewCell.h"
@interface BookListViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@end

@implementation BookListViewController
- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, MyTopHeight, MyKScreenWidth, MyKScreenHeight - 6-MyStatusBarHeight) style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;//隐藏分割线
    }
    return _tableView;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
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
    BookListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifer];
    if (!cell) {
        cell = [[[NSBundle mainBundle]loadNibNamed:@"BookListTableViewCell" owner:self options:nil]firstObject];
        
        
        
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    
    
    
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    BookDetailViewController *vc = [BookDetailViewController new];
    vc.navTitle = @"书籍详情";
    [self.navigationController pushViewController:vc animated:YES];
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return  200;
}

@end
