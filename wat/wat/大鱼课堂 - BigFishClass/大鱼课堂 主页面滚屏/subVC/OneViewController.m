//
//  OneViewController.m
//  DoulScro
//
//  Created by wl on 2018/5/22.
//  Copyright © 2018年 https://github.com/orzzh. All rights reserved.
//

#import "OneViewController.h"
#import "headerCollectionReusableView.h"
#import "ClassItemCollectionViewCell.h"
#import "ClassDetailViewController.h"
//图片轮播02
#import "HorScorllView.h"


@interface OneViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,UIGestureRecognizerDelegate,HorScorllViewImageClickDelegate>
{
    NSArray *hearderTitleArray;
    NSArray *imageArray1;
    NSArray *imageArray2;
    NSArray *sectionNumArr;
    
    //课程轮播数据
    NSMutableArray *_homeImageArray;
    NSMutableArray *_homeTitleArray;
    HorScorllView *_horScorllView;
    UILabel *_textLabel;
    
}
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) UILabel *label1;
@end

@implementation OneViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    
    hearderTitleArray = @[@"独家课程",@"精品课程"];
    imageArray1 = @[@"1234567890",@"1234567891",@"1234567892",@"1234567890",@"1234567891",@"1234567892"];
    imageArray2 = @[@"1234567892",@"1234567890",@"1234567891",@"1234567890",@"1234567891",@"1234567892",@"1234567890",@"1234567891",@"1234567892"];
    sectionNumArr = [NSArray arrayWithObjects:imageArray1,imageArray2, nil];
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc]init];
    
    [flowLayout setItemSize:CGSizeMake(70, 100)];//设置cell的尺寸
    
    [flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];//设置其布局方向
    
    flowLayout.sectionInset = UIEdgeInsetsMake(10, 10, 5, 10);//设置其边界
    
    //其布局很有意思，当你的cell设置大小后，一行多少个cell，由cell的宽度决定
    
    self.collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, MyKScreenWidth, MyKScreenHeight - MyTopHeight - MyTabBarHeight - 44)collectionViewLayout:flowLayout];
    
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    self.collectionView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:self.collectionView];
    
    
    
    
    [self.collectionView registerNib:[UINib nibWithNibName:@"ClassItemCollectionViewCell" bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:@"ClassItemCollectionViewCell"];
    
    
    
    
    
    //注册headerView  此处的ReuseIdentifier 必须和 cellForItemAtIndexPath 方法中 一致  均为reusableView
    [self.collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"reusableView"];
    
    
    
    [self.collectionView reloadData];
    
    
}

#pragma mark - collectionView dataSource Or delegate
//定义头部视图的高度
-(CGSize)collectionView:(UICollectionView*)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    if(section == 0)
    {
        CGSize size = {MyKScreenWidth, 160};
        return size;
    }
    else
    {
        CGSize size = {MyKScreenWidth, 40};
        return size;
    }
}
//定义头部视图内容
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {//判断 header OR footer
        UICollectionReusableView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"reusableView" forIndexPath:indexPath];
        headerView.backgroundColor =[UIColor whiteColor];
        if (headerView.subviews.count == 0) {//判断是否有子视图,来判断是否再次加载
            if (indexPath.section == 0 ) {
                
                UILabel *label1 = [[UILabel alloc] initWithFrame:CGRectMake(13, 0, headerView.frame.size.width / 2, 40)];
                self.label1 = label1;
                label1.text =  @"即将开课";
                label1.font = [UIFont systemFontOfSize:12];
                label1.textColor = [UIColor grayColor];
                // 下划线
                NSDictionary *attribtDic1 = @{NSUnderlineStyleAttributeName: [NSNumber numberWithInteger:NSUnderlineStyleSingle]};
                NSMutableAttributedString *attribtStr1 = [[NSMutableAttributedString alloc]initWithString:@"即将开课" attributes:attribtDic1];
                label1.attributedText = attribtStr1;
                [headerView addSubview:label1];
                
                UIButton *moreBtn1 = [[UIButton alloc]initWithFrame:CGRectMake(MyKScreenWidth - 43, 0, 30,40)];
                [moreBtn1 setTitle:@"更多" forState: UIControlStateNormal];
                moreBtn1.titleLabel.font = commenAppFont(12);
                moreBtn1.backgroundColor = [UIColor clearColor];
                [moreBtn1 setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
                [moreBtn1 addTarget:self action:@selector(moreBtnclick:) forControlEvents:UIControlEventTouchUpInside];
                [headerView addSubview:moreBtn1];
                
                //        UIView *collectionHeaderView = [[UIView alloc]initWithFrame:CGRectMake(0, 40, MyKScreenWidth, 160)];
                //        collectionHeaderView.backgroundColor = [UIColor purpleColor];
                //        [headerView addSubview:collectionHeaderView];
                
                _horScorllView = [[HorScorllView alloc] initWithFrame:CGRectMake(0, 40, MyKScreenWidth, 80)];
                _horScorllView.images = @[@"1234567890",@"1234567891",@"1234567892",@"1234567890",@"1234567891",@"1234567892"];
                _horScorllView.delegate = self;
                
                
                [headerView addSubview:_horScorllView];
                
                //        _textLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, [UIScreen mainScreen].bounds.size.height / 2, [UIScreen mainScreen].bounds.size.width, 30)];
                //
                //        _textLabel.textAlignment = NSTextAlignmentCenter;
                //        _textLabel.font = [UIFont systemFontOfSize:18];
                //        [collectionHeaderView addSubview:_textLabel];
                
                
                
                
                UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(13, 120, headerView.frame.size.width / 2, 40)];
                label.text =  hearderTitleArray[indexPath.section];
                label.font = [UIFont systemFontOfSize:12];
                label.textColor = [UIColor grayColor];
                // 下划线
                NSDictionary *attribtDic = @{NSUnderlineStyleAttributeName: [NSNumber numberWithInteger:NSUnderlineStyleSingle]};
                NSMutableAttributedString *attribtStr = [[NSMutableAttributedString alloc]initWithString:hearderTitleArray[indexPath.section] attributes:attribtDic];
                label.attributedText = attribtStr;
                [headerView addSubview:label];
                
                UIButton *moreBtn = [[UIButton alloc]initWithFrame:CGRectMake(MyKScreenWidth - 43, 120, 30,40)];
                [moreBtn setTitle:@"更多" forState: UIControlStateNormal];
                moreBtn.titleLabel.font = commenAppFont(12);
                moreBtn.backgroundColor = [UIColor clearColor];
                [moreBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
                [moreBtn addTarget:self action:@selector(moreBtnclick:) forControlEvents:UIControlEventTouchUpInside];
                [headerView addSubview:moreBtn];
            }else{
                UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(13, 0, headerView.frame.size.width / 2, headerView.frame.size.height)];
                label.text =  hearderTitleArray[indexPath.section];
                label.font = [UIFont systemFontOfSize:12];
                label.textColor = [UIColor grayColor];
                // 下划线
                NSDictionary *attribtDic = @{NSUnderlineStyleAttributeName: [NSNumber numberWithInteger:NSUnderlineStyleSingle]};
                NSMutableAttributedString *attribtStr = [[NSMutableAttributedString alloc]initWithString:hearderTitleArray[indexPath.section] attributes:attribtDic];
                label.attributedText = attribtStr;
                [headerView addSubview:label];
                
                UIButton *moreBtn = [[UIButton alloc]initWithFrame:CGRectMake(MyKScreenWidth - 43, 0, 30, headerView.frame.size.height)];
                [moreBtn setTitle:@"更多" forState: UIControlStateNormal];
                moreBtn.titleLabel.font = commenAppFont(12);
                moreBtn.backgroundColor = [UIColor clearColor];
                [moreBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
                [moreBtn addTarget:self action:@selector(moreBtnclick:) forControlEvents:UIControlEventTouchUpInside];
                [headerView addSubview:moreBtn];
                
            }
        }
        
        
        
        
        return headerView;
    }else{
        
        return nil;
    }
    
    
}
- (void)moreBtnclick:(NSInteger *)scetion{
    
    NSLog(@"%ld",scetion);
}

//定义展示的Section的个数
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return sectionNumArr.count;
}
//定义展示的UICollectionViewCell的个数

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    NSInteger num = 0;
    NSArray *arr = sectionNumArr[section];
    num = arr.count;
    return num;
    
}


//每个UICollectionView展示的内容
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    ClassItemCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"ClassItemCollectionViewCell" forIndexPath:indexPath];
    
    if (!cell) {
        cell = [[ClassItemCollectionViewCell alloc]init];
    }
    if (indexPath.section == 0) {
        cell.imgView.image = [UIImage imageNamed:imageArray1[indexPath.row]];
    }else{
        
        cell.imgView.image = [UIImage imageNamed:imageArray2[indexPath.row]];
    }
    
    
    
    return cell;
    
    
}
#pragma mark --UICollectionViewDelegateFlowLayout
//定义每个UICollectionView 的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(MyKScreenWidth/2 - 13 - 10, 44 + 97);
}
//定义每个UICollectionView 的 margin
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(10, 13, 5, 13);
}
#pragma mark --UICollectionViewDelegate
//UICollectionView被选中时调用的方法
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    //    UICollectionViewCell * cell = (UICollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
    //    cell.backgroundColor = [UIColor orangeColor];
    ClassDetailViewController *detailVC = [ClassDetailViewController new];
    [detailVC setHidesBottomBarWhenPushed:YES];
    [self.navigationController pushViewController:detailVC animated:YES];
}
//返回这个UICollectionView是否可以被选择
-(BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

//点击书籍滚动图的代理点击方法 delegate
- (void)horImageClickAction:(NSInteger)tag {
    NSLog(@"你点击的按钮tag值为：%ld",tag);
}




@end

























////#import "MJRefresh.h"
//
//@interface OneViewController ()<UITableViewDelegate,UITableViewDataSource>
//
//@property (nonatomic,strong)UITableView  *tableView;
//
//@end
//
//@implementation OneViewController
//
//- (void)viewDidLoad {
//    [super viewDidLoad];
//    // Do any additional setup after loading the view.
//
//    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, scr_wid, scr_hei - MyTopHeight - MyTabBarHeight - 44) style:UITableViewStylePlain];
//
//    self.tableView.delegate = self;
//    self.tableView.dataSource = self;
//
//    self.tableView.estimatedRowHeight = 0;
//    self.tableView.estimatedSectionHeaderHeight = 0;
//    self.tableView.estimatedSectionFooterHeight = 0;
//    self.tableView.tableFooterView = [[UIView alloc] init];
//    self.tableView.bounces = YES;
//    [self.view addSubview:self.tableView];
//
////    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(headerRereshing)];
////    header.automaticallyChangeAlpha = YES;
////    header.lastUpdatedTimeLabel.hidden = YES;
////    header.stateLabel.hidden = YES;
////    self.tableView.mj_header = header;
//}
//
////- (void)headerRereshing{
////    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
////        [self.tableView.mj_header endRefreshing];
////    });
////}
//
//
//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
//    return 1;
//}
//- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
//    return 20;
//}
//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
//    return 50;
//}
//- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
//    return 0.01;
//}
//- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
//    return 0.01;
//}
//
//
//- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell1"];
//    if (!cell) {
//        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell1"];
//        CGFloat r = arc4random()%255;
//        CGFloat g = arc4random()%255;
//        CGFloat b = arc4random()%255;
//        cell.backgroundColor = [UIColor colorWithRed:r/255 green:g/255 blue:b/255 alpha:1];
//    }
//    return cell;
//}
//
//
//- (void)didReceiveMemoryWarning {
//    [super didReceiveMemoryWarning];
//    // Dispose of any resources that can be recreated.
//}
//
///*
//#pragma mark - Navigation
//
//// In a storyboard-based application, you will often want to do a little preparation before navigation
//- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
//    // Get the new view controller using [segue destinationViewController].
//    // Pass the selected object to the new view controller.
//}
//*/
//
//@end
