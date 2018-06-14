//
//  MeSettingViewController.m
//  wat
//
//  Created by 123 on 2018/6/11.
//  Copyright © 2018年 wat0801. All rights reserved.
//

#import "MeSettingViewController.h"
#import "MeSettingTableViewCell.h"
#import "JHUploadImage.h"
@interface MeSettingViewController ()<UITableViewDelegate,UITableViewDataSource,JHUploadImageDelegate>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *messageArr;//cell数据源
@property (nonatomic, strong) UIImage *headerViewImg;
@end

@implementation MeSettingViewController
- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, MyTopHeight, MyKScreenWidth, MyKScreenHeight - MyTopHeight)style:UITableViewStyleGrouped];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        //_tableView.contentInset = UIEdgeInsetsMake(10, 0, 0, 0);
    }
    
    return _tableView;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.rightTitles = @[@"保存"];
    
    //页面数据
    //界面加载数据
    NSString *path= [[NSBundle mainBundle]pathForResource:@"meSet" ofType:@"plist"];
    _messageArr = [NSArray arrayWithContentsOfFile:path];
    
    
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
    
    return _messageArr.count;
}
- (NSInteger )tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
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
    static NSString *ID = @"Cell";
    MeSettingTableViewCell  *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[[NSBundle mainBundle]loadNibNamed:@"MeSettingTableViewCell" owner:self options:nil]firstObject];
    }
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];// （这种是没有点击后的阴影效果)
    
    
    NSArray *arr = _messageArr[indexPath.section];
    NSDictionary *dic = arr[indexPath.row];
    
    cell.cellNameLab.text = [dic valueForKey:@"cellName"];
    
    if (indexPath.section == 0) {
        if ([self.navTitle isEqualToString:@"购买信息"]) {
            
        }else{
            cell.cellNameLab.hidden = NO;
            cell.cellrightBtn.hidden = NO;
            
            cell.cellNameLab.frame = CGRectMake(15, 0, MyKScreenWidth, 73);
            cell.cellrightBtn.frame = CGRectMake(MyKScreenWidth - 50, (73 - 40) / 2, 40, 40);
            if (!self.headerViewImg) {
                
            }else{
                
                [cell.cellrightBtn setImage:self.headerViewImg forState:UIControlStateNormal];
            }
        }
        
        
    }else{
        cell.cellNameLab.hidden = NO;
        cell.cellRightTextField.hidden = NO;
        
    }
    

    
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0 && indexPath.row == 0) {
        [JHUPLOAD_IMAGE showActionSheetInFatherViewController:self delegate:self];
    }
    
}

/**
 头像选取

 @param image 原图
 @param originImage 缩略图
 */
-(void)uploadImageToServerWithImage:(UIImage *)image OriginImage:(UIImage *)originImage
{
    NSLog(@"%@\n%@",originImage,image);
    self.headerViewImg = originImage;
    [self.tableView reloadData];
}

- (CGFloat )tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        if ([self.navTitle isEqualToString:@"购买信息"]) {
            return 0;
        }else{
            return 73;
        }
    }else{
        return 44;
        
    }
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if ([self.navTitle isEqualToString:@"购买信息"]) {
        if (section==0) {
            return 0.01;
        }else{
            return 10;
        }
    }else{
        return 10;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    return 0.01;
}
-(void)rightBtnsAction:(UIButton *)button{
    [[ZWHHelper sharedHelper]addAlertViewControllerToView:self withClickBlock:^(int clickInt) {
        if (clickInt == 1) {
            [self.navigationController popViewControllerAnimated:YES];
        }
    } title:@"保存成功" content:@"" cancleStr:@"" confirmStr:@"确定"];
    
}

@end
