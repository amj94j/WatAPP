//
//  WatHomePageViewController.m
//  wat
//
//  Created by 123 on 2018/5/22.
//  Copyright © 2018年 wat0801. All rights reserved.
//

#import "WatHomePageViewController.h"
#import "WatLoginViewController.h"//测试登陆页面
#import "WatBigFishClassViewController.h"
#import "PYSearch.h"
#import "WHScrollView.h"


#import "AdvertScrollViewDetailViewController.h"
#import "NewsDetailPageViewController.h"//文章详情页
#import "ClassDetailViewController.h"//课程详情页
#import "BookDetailViewController.h"//书籍详情页
#import "HomeNewsDetailTableViewCell.h"
#import "NewsListViewController.h"
#import "BookListViewController.h"//书籍列表
#import "HomeClassTableViewCell.h"
#import "ClassListViewController.h"


#import "HorScorllView.h"//轮播图,书籍02

#import <NSObject+YYModel.h>

@interface WatHomePageViewController ()<UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate,PYSearchViewControllerDelegate,HorScorllViewImageClickDelegate>{
    
    HorScorllView *_horScorllView;
}
@property (nonatomic, strong)UIButton *loginBtn;//登陆测试按钮
@property (nonatomic, strong) UIView *navigationBarView;//自定义导航栏
@property (nonatomic, strong) UISearchBar *searchBar;//搜索栏
@property (nonatomic, assign) CGFloat oldOffset;
@property (nonatomic, assign) CGFloat backNavAlpha;
@property (nonatomic, assign) CGFloat historyY;

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UIButton *classBtn; //分类btn
@property (nonatomic, strong) NSArray *btnNameArr;

@property (nonatomic, strong) NSMutableArray *imageArray;//测试 书籍更多 图片数组
@end

static CGFloat headerScrollViewHeight; //滚动视图的高度 227
@implementation WatHomePageViewController
#pragma 懒加载
- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc]init];
    }
    return _tableView;
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:YES];
    self.navigationController.navigationBarHidden = YES;
    
}
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:YES];
    self.navigationController.navigationBarHidden = NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self callApiData];
    for(NSString *fontfamilyname in [UIFont familyNames])
    {
        NSLog(@"family:'%@'",fontfamilyname);
        for(NSString *fontName in [UIFont fontNamesForFamilyName:fontfamilyname])
        {
            NSLog(@"\tfont:'%@'",fontName);
        }
        NSLog(@"-------------");
    } 
    self.navBarView.alpha = 0.0;
    //[[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:YES];//将状态栏颜色改回白色
    [self addNavigationBar];
    self.view.backgroundColor = WatBackColor;
    
    [self addLoginBtn];
    [self addTableView];
    [self addNavigationBarView];
    [self addSearchView];

    

}
- (void) callApiData {
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    
    
    [Request POST:@"/api/site/index" parameters:dic success:^(id responseObject) {
    
 
    } failure:^(NSError *error) {
        
    }];
    
}

- (void) addSearchView {
    
   
    UIButton *logoBtn = [[UIButton alloc]initWithFrame:CGRectMake(10, MyStatusBarHeight + 5, 30, 30)];
    [logoBtn setImage:[UIImage imageNamed:@"logo-big"] forState:UIControlStateNormal];
    logoBtn.imageView.contentMode = 2;
    //logoBtn.backgroundColor = CommonAppColor;
    [self.view addSubview:logoBtn];
    
    UISearchBar *searchBar = [[UISearchBar alloc]initWithFrame:CGRectMake(40, MyStatusBarHeight, MyKScreenWidth - 40, 40)];
    self.searchBar = searchBar;
    [self.view addSubview:searchBar];
    searchBar.placeholder = @"搜索最新最热文章";
    searchBar.delegate = self;
    searchBar.searchBarStyle = 2;
    searchBar.barTintColor = [UIColor redColor];
    searchBar.tintColor = [UIColor whiteColor];
    //一下代码为修改placeholder字体的颜色和大小
    UITextField * searchField = [_searchBar valueForKey:@"_searchField"];
    [searchField setValue:[UIColor grayColor] forKeyPath:@"_placeholderLabel.textColor"];
    
    [searchBar setBackgroundImage:[UIImage new]];
    
    //
    
   
}
- (void)addNavigationBarView{
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor],UITextAttributeTextColor,nil]];
    // 设置导航栏左边的按钮
    //self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithImage:@"MainTagSubIcon" highImage:@"MainTagSubIconClick" target:self action:nil];
    // 设置背景色
    UIView *navigationBarView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, MyKScreenWidth, MyTopHeight)];
    self.navigationBarView = navigationBarView;
    navigationBarView.backgroundColor = [UIColor whiteColor];
    //self.navigationBarView.hidden = YES;
    [self.view addSubview:navigationBarView];
    UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(0, navigationBarView.frame.size.height - 0.5, MyKScreenWidth, 0.5)];
    lineView.backgroundColor = [UIColor grayColor];
    lineView.alpha = 0.2;
    [navigationBarView addSubview:lineView];
//    UILabel *navigationTitleLab = [[UILabel alloc]initWithFrame:CGRectMake(0, MyTopHeight - 44, MyKScreenWidth, 44)];
//    navigationTitleLab.text = @"广场";
//    navigationTitleLab.textAlignment = NSTextAlignmentCenter;
//    navigationTitleLab.textColor = [UIColor whiteColor];
//    [self.navigationBarView addSubview:navigationTitleLab];
}
- (void)addTableView{
    
    UITableView *tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, MyTopHeight, MyKScreenWidth, MyKScreenHeight - MyTopHeight - MyTabBarHeight)style:UITableViewStyleGrouped];
    
    self.tableView = tableView;
    self.tableView.separatorStyle = NO; //隐藏分割线
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:tableView];
    
    UIView *headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, MyKScreenWidth, 227 + 75 - 45)];
    headerView.backgroundColor = WatBackColor;
    self.tableView.tableHeaderView = headerView;

    
    //轮播图
    CGRect rect = CGRectMake(0, 0, MyKScreenWidth, 227 - 45);
    NSMutableArray *images = [NSMutableArray array];
    for (NSInteger i = 0; i < 3; i ++) {
        //[images addObject:ColorWithRGB(arc4random()%255, arc4random()%255, arc4random()%255)];
        NSInteger a = i;
        NSString *imageName = [NSString stringWithFormat:@"123456789%ld",a];
        UIImage *img = [UIImage imageNamed:imageName];
        [images addObject:img];
    }
    WHScrollView *scroll = [[WHScrollView alloc] initWithFrame:rect withImages:images withIsRunloop:YES withBlock:^(NSInteger index) {
        NSLog(@"点击了index%zd",index);
        NSString *str = [NSString stringWithFormat:@"点击的是第%zd张图",index];
        [[ZWHHelper sharedHelper]addAlertViewControllerToView:[ZWHHelper rootTabbarViewController] withClickBlock:nil title:str content:@"都是测试数据, 别着急,好戏在后面呢!" cancleStr:nil confirmStr:@"确定"];
    }];
    [headerView addSubview:scroll];
    
    
    //分类btn
    UIView *classBtnView = [[UIView alloc]initWithFrame:CGRectMake(0, scroll.frame.size.height, MyKScreenWidth, 75)];
    classBtnView.backgroundColor = [UIColor whiteColor];
    [headerView addSubview:classBtnView];
    
    
    
    _btnNameArr = @[@"内参新闻",@"大鱼餐饮学院",@"餐饮报告",@"课程报名"];
    NSArray *btnImgArr = @[@"内参新闻",@"大鱼餐饮学院",@"餐饮报告",@"品牌加盟"];
    for (int i = 0; i < _btnNameArr.count; i++) {
        UIButton *classBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        classBtn.tag = i;
        
        [classBtn addTarget:self action:@selector(classBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [classBtnView addSubview:classBtn];
        classBtn.frame = CGRectMake(i * MyKScreenWidth / 4 , 0, MyKScreenWidth / 4, classBtnView.frame.size.height);
        
        UIImageView *btnImageView = [[UIImageView alloc]initWithFrame:CGRectMake((classBtn.frame.size.width - 33)/2, 14, 33, 33)];
        btnImageView.image = [UIImage imageNamed:btnImgArr[i]];
        [classBtn addSubview:btnImageView];
        
        UILabel *btnTitleLab = [[UILabel alloc]initWithFrame:CGRectMake(0, btnImageView.frame.size.height + btnImageView.frame.origin.y , classBtn.frame.size.width, 20)];
        btnTitleLab.textColor = ColorWithRGB(153, 153, 153);
        btnTitleLab.font = commenAppFont(9);
        btnTitleLab.textAlignment = NSTextAlignmentCenter;
        btnTitleLab.text = _btnNameArr[i];
        [classBtn addSubview:btnTitleLab];
        
        
    }
    
    
    

    
    //更多书籍按钮
 
    UIView *footerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, MyKScreenWidth, 170)];
    footerView.backgroundColor = [UIColor whiteColor];
    self.tableView.tableFooterView = footerView;
    
    UILabel *headerTitleLab = [[UILabel alloc]initWithFrame:CGRectMake(18, 10, 100, 40)];
    headerTitleLab.text = @"内参主打书籍推荐";
    headerTitleLab.font = commenAppFont(12);
    headerTitleLab.textColor = [UIColor grayColor];
    [footerView addSubview:headerTitleLab];
    
    UIView *shuLineView = [[UIView alloc]initWithFrame:CGRectMake(-5, 14, 1, 12)];
    shuLineView.backgroundColor = CommonAppColor;
    [headerTitleLab addSubview:shuLineView];
    
    UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(0, 43, MyKScreenWidth, 1)];
    lineView.backgroundColor = WatBackColor;
    [footerView addSubview:lineView];
    
    UIView *fenggeLine = [[UIView alloc]initWithFrame:CGRectMake(0, 3, MyKScreenWidth, 8)];
    fenggeLine.backgroundColor = WatBackColor;
    [footerView addSubview:fenggeLine];
    
    UIButton *moreBtn = [[UIButton alloc]initWithFrame:CGRectMake(MyKScreenWidth - 50, 10, 41, 40)];
    [moreBtn setTitle:@"更多" forState: UIControlStateNormal];
    [moreBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    moreBtn.titleLabel.font = commenAppFont(10);
    moreBtn.titleLabel.textAlignment = NSTextAlignmentRight;
    [moreBtn addTarget:self action:@selector(addMoreBookClick) forControlEvents:UIControlEventTouchUpInside];
    [footerView addSubview:moreBtn];
    

    
    _horScorllView = [[HorScorllView alloc] initWithFrame:CGRectMake(0, 64, MyKScreenWidth, 92)];
    _horScorllView.images = @[@"1234567890",@"1234567891",@"1234567892",@"1234567890",@"1234567891"];
    _horScorllView.delegate = self;
    [footerView addSubview:_horScorllView];
    
}
//点击书籍滚动图的代理点击方法 delegate
- (void)horImageClickAction:(NSInteger)tag {
    NSLog(@"你点击的按钮tag值为：%ld",tag);
    
    BookDetailViewController *bookVC = [BookDetailViewController new];
    bookVC.navTitle = @"书籍详情页";
    [bookVC setHidesBottomBarWhenPushed:YES];
    [self.navigationController pushViewController:bookVC animated:YES];
}

/**
 分类 btn 点击事件

 @param sender 点击额 tag 值
 */
- (void)classBtnClick:(UIButton *)sender {
    
    UIButton *classBtn = sender;
    NSLog(@"您点击的btn.tag ====== %ld",classBtn.tag);
    if (sender.tag == 1) {
        WatBigFishClassViewController *classDetailVC = [[WatBigFishClassViewController alloc]init];
        classDetailVC.navTitle = _btnNameArr[sender.tag];
        self.navigationController.navigationBarHidden = NO;
        [classDetailVC setHidesBottomBarWhenPushed:YES];
        classDetailVC.navigationController.navigationBarHidden = NO;
        [self.navigationController pushViewController: classDetailVC animated:YES];
    }else if (sender.tag ==0){
        
        NewsListViewController *vc = [NewsListViewController new];
        [vc setHidesBottomBarWhenPushed:YES];
        [self.navigationController pushViewController:vc animated:YES]; 
    }else if (sender.tag == 3){
        
        ClassListViewController *classListVC = [ClassListViewController new];
        [classListVC setHidesBottomBarWhenPushed:YES];
        classListVC.type = @"课程报名";
        [self.navigationController pushViewController:classListVC animated:YES];
    } else if (sender.tag == 2){
        BookListViewController *bookListVC = [BookListViewController new];
        [bookListVC setHidesBottomBarWhenPushed:YES];
        bookListVC.navTitle = @"书籍报告";
        [self.navigationController pushViewController:bookListVC animated:YES];
        
    }
    
    
}

#pragma tableView 三问一达
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    if (section == 0) {
        return 3;
    }else{
        return 1;
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    static NSString * ID = @"cell";
    if (indexPath.section == 0) {
        HomeNewsDetailTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
        if (!cell) {
            cell = [[[NSBundle mainBundle]loadNibNamed:@"HomeNewsDetailTableViewCell" owner:self options:nil]firstObject];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }else{
        HomeClassTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
        if (!cell) {
            cell = [[[NSBundle mainBundle]loadNibNamed:@"HomeClassTableViewCell" owner:self options:nil]firstObject];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
      
        
        _btnNameArr = @[@"大鱼餐饮学院一期同学会限额招募!大鱼餐饮学院一期同学会限额招募!",@"大鱼餐饮学院一期同学会限额招募!大鱼餐饮学院一期同学会限额招募!",@"大鱼餐饮学院一期同学会限",@"大鱼餐饮学院一期同学会限额招募!大鱼餐饮学院一期同学会限额招募!",@"大鱼餐饮学院一期同学会限额招募!大鱼餐饮学院一期同学会限额招募!",@"大鱼餐饮学院一期同学会限额招募!大鱼餐饮学院一期同学会限额招募!"];
        NSArray *btnImgArr = @[@"classTestImg",@"classTestImg",@"classTestImg",@"classTestImg",@"classTestImg",@"classTestImg"];
        for (int i = 0; i < 6; i++) {
            UIButton *BGBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            BGBtn.tag = i;
            //BGBtn.backgroundColor = [UIColor yellowColor];
            [BGBtn addTarget:self action:@selector(classDetailsBtnClick:) forControlEvents:UIControlEventTouchUpInside];
            [cell addSubview:BGBtn];
            
            BGBtn.frame = CGRectMake((i % 2) * MyKScreenWidth / 2 , 170 * (i / 2) , MyKScreenWidth / 2, 170);
            
            UIImageView *btnImageView = [[UIImageView alloc]initWithFrame:CGRectMake(13, 14, 165, 97)];
            btnImageView.image = [UIImage imageNamed:btnImgArr[i]];
            btnImageView.layer.cornerRadius = 10;
            [BGBtn addSubview:btnImageView];
            NSLog(@"%lf",btnImageView.frame.size.height + btnImageView.frame.origin.y + 14);
            UILabel *btnTitleLab = [[UILabel alloc]initWithFrame:CGRectMake(13, btnImageView.frame.size.height + btnImageView.frame.origin.y + 8 , 165, 40)];
            btnTitleLab.textColor = [UIColor blackColor];
            btnTitleLab.text = _btnNameArr[i];
            btnTitleLab.font = commenAppFont(12);
            btnTitleLab.numberOfLines = 2;
            [btnTitleLab sizeToFit];
            btnTitleLab.textAlignment = NSTextAlignmentLeft;
            [BGBtn addSubview:btnTitleLab];
            
            UILabel *shipingTypeLab = [[UILabel alloc]initWithFrame:CGRectMake(13, btnTitleLab.frame.size.height + btnTitleLab.frame.origin.y + 5, 27, 13)];
            shipingTypeLab.backgroundColor = CommonAppColor;
            shipingTypeLab.text = @"视频";
            shipingTypeLab.textAlignment = NSTextAlignmentCenter;
            shipingTypeLab.textColor = [UIColor whiteColor];
            shipingTypeLab.font = commenAppFont(9);
            [BGBtn addSubview:shipingTypeLab];
            
            UILabel *moneyLab = [[UILabel alloc]initWithFrame:CGRectMake(13 + 165 - 100, btnTitleLab.frame.size.height + btnTitleLab.frame.origin.y + 5, 100, 13)];
            moneyLab.text = @"¥499.0";
            moneyLab.textAlignment = NSTextAlignmentRight;
            moneyLab.textColor = CommonAppColor;
            moneyLab.font = commenAppFont(12);
            [BGBtn addSubview:moneyLab];
            
            
        }
        
        
        
        return cell;
    }
    
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return 115;
    }else{
        
        return 510;
    }
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"%ld----%ld",indexPath.row,indexPath.section);
    NewsDetailPageViewController *vc = [[NewsDetailPageViewController alloc]init];
    vc.navTitle = @"文章详情";
    [vc setHidesBottomBarWhenPushed:YES];
    [self.navigationController pushViewController:vc animated:YES];
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    NSString *btnName ;
    if (section == 0) {
        btnName = @"最新文章";
    }else if(section == 1){
        btnName = @"精彩课程";
    }
    
    UIView *headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, MyKScreenWidth, 40)];
    //headerView.backgroundColor = CommonAppColor;
    
    UIView *fenggeLine = [[UIView alloc]initWithFrame:CGRectMake(0, 0, MyKScreenWidth, 8)];
    fenggeLine.backgroundColor = WatBackColor;
    [headerView addSubview:fenggeLine];
    
    UILabel *headerTitleLab = [[UILabel alloc]initWithFrame:CGRectMake(18, 5, 100, headerView.frame.size.height)];
    headerTitleLab.text = btnName;
    headerTitleLab.font = commenAppFont(12);
    headerTitleLab.textColor = [UIColor grayColor];
    [headerView addSubview:headerTitleLab];
    
    UIView *shuLineView = [[UIView alloc]initWithFrame:CGRectMake(-5, 14, 1, 12)];
    shuLineView.backgroundColor = CommonAppColor;
    [headerTitleLab addSubview:shuLineView];
    
    
    UIButton *moreBtn = [[UIButton alloc]initWithFrame:CGRectMake(MyKScreenWidth - 50, 5, 41, headerView.frame.size.height)];
    [moreBtn setTitle:@"更多" forState: UIControlStateNormal];
    [moreBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    moreBtn.titleLabel.font = commenAppFont(10);
    moreBtn.titleLabel.textAlignment = NSTextAlignmentRight;
    moreBtn.tag = section;
    [moreBtn addTarget:self action:@selector(addMoreBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [headerView addSubview:moreBtn];
    
    UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(0, headerView.frame.size.height - 1, MyKScreenWidth, 1)];
    lineView.backgroundColor = WatBackColor;
    [headerView addSubview:lineView];
    
    return headerView;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 40 + 10;
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView *footerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, MyKScreenWidth, 40)];
    
    UIButton *refreshBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 100, footerView.frame.size.height)];
    refreshBtn.center = footerView.center;
    [refreshBtn setTitle:@"换一批" forState: UIControlStateNormal];
    [refreshBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    refreshBtn.titleLabel.font = commenAppFont(10);
    refreshBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
    refreshBtn.tag = section;
    [refreshBtn addTarget:self action:@selector(addMoreBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [footerView addSubview:refreshBtn];
    return footerView;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 40;
}

- (void)classDetailsBtnClick:(UIButton *)sender{
    NSLog(@"点击的是第%ld个课程按钮",sender.tag);
    NSString *str = [NSString stringWithFormat:@"点击的是第%ld个按钮",sender.tag];
    ClassDetailViewController *classDetailVC = [ClassDetailViewController new];
    classDetailVC.navTitle = str;
    [classDetailVC setHidesBottomBarWhenPushed:YES];
    [self.navigationController pushViewController:classDetailVC animated:YES];
}
- (void)addMoreBookClick{
    
    NSLog(@"点击了更多书籍");
    BookListViewController *bookListVC = [BookListViewController new];
    [bookListVC setHidesBottomBarWhenPushed:YES];
    bookListVC.navTitle = @"书籍报告";
    [self.navigationController pushViewController:bookListVC animated:YES];
    
}

- (void)addLoginBtn {
    UIButton *loginBtn = [[UIButton alloc]initWithFrame:CGRectMake(100, 100, 100, 50)];
    self.loginBtn = loginBtn;
    [loginBtn setTitle:@"登陆界面" forState:UIControlStateNormal];
    [loginBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    loginBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    //[loginBtn.titleLabel sizeToFit];
    loginBtn.backgroundColor = CommonAppColor;
    [loginBtn addTarget:self action:@selector(pushLoginPageClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:loginBtn];
    
}
- (void) addMoreBtnClick:(UIButton *)sender {
    NSLog(@"%ld",sender.tag);
    if (sender.tag == 0) {
        NewsListViewController *vc = [NewsListViewController new];
        [vc setHidesBottomBarWhenPushed:YES];
        [self.navigationController pushViewController:vc animated:YES];
    }else{
        ClassListViewController *classListVC = [ClassListViewController new];
        [classListVC setHidesBottomBarWhenPushed:YES];
        [self.navigationController pushViewController:classListVC animated:YES];
        
    }
    
}
-(void)pushLoginPageClick{
    WatLoginViewController *loginVC = [[WatLoginViewController alloc]init];
    loginVC.navTitle = @"登陆";
    [loginVC setHidesBottomBarWhenPushed:YES];
    //self.navigationController.navigationBarHidden = NO;
    [self.navigationController pushViewController:loginVC animated:YES];
    //[self.navigationController presentModalViewController:loginVC animated:YES];
    NSLog(@"点击了登陆界面");
}
- (void)addNavigationBar{
    //设置导航栏背景色以及title颜色
    [[UINavigationBar appearance] setBarTintColor:[UIColor whiteColor]];
    [[UINavigationBar appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:CommonAppColor}];
    //self.navigationController.navigationBarHidden = YES;
    self.isBackTitle = YES;
    self.navigationBarView.hidden = NO;
    
}

#pragma moreBook
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}


- (void)didSelectCell:(UIView *)subView withSubViewIndex:(NSInteger)subIndex {
    
    NSLog(@"点击了第%ld张图",(long)subIndex + 1);
    
    
}


#pragma - mark 监听 scrollView 滑动
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{

    //NSLog(@"%lf",scrollView.contentOffset.y);
    headerScrollViewHeight = 0;//如果需要 banner 滑动完,在出现,那就加 banner 的高
//#pragma navigationBar 影藏显示
//    if (scrollView.contentOffset.y > _oldOffset) {//如果当前位移大于缓存位移，说明scrollView向上滑动
//        if (scrollView.contentOffset.y >= headerScrollViewHeight) { //184
//            self.navigationBarView.hidden = NO;
//            self.backNavAlpha = (scrollView.contentOffset.y - headerScrollViewHeight) / 110.0;
//            self.navigationBarView.alpha = self.backNavAlpha;
//            if (self.backNavAlpha == 0) {
//                self.navigationBarView.hidden = YES;
//            }else{
//                self.navigationBarView.hidden = NO;
//            }
//        }
//    }else {
//
//        if (scrollView.contentOffset.y <= headerScrollViewHeight) {
//            self.navigationBarView.hidden = YES;
//            self.navigationBarView.alpha = self.backNavAlpha;
//        }else{
//            self.navigationBarView.hidden = NO;
//            self.backNavAlpha = (scrollView.contentOffset.y - headerScrollViewHeight) / 110.0;
//            self.navigationBarView.alpha = self.backNavAlpha;
//            if (self.backNavAlpha == 0) {
//                self.navigationBarView.hidden = YES;
//            }else{
//                self.navigationBarView.hidden = NO;
//            }
//        }
//    }
//    _oldOffset = scrollView.contentOffset.y;//将当前位移变成缓存位移
//
//#pragma searchView
//    if (scrollView.contentOffset.y < - MyStatusBarHeight) {
//        if (scrollView.contentOffset.y < _historyY) { //下滑
//            self.searchBar.frame = CGRectMake(0, MyStatusBarHeight - scrollView.contentOffset.y - MyStatusBarHeight, MyKScreenWidth, 44);
//        }
//        if (scrollView.contentOffset.y > _historyY) { //上滑
//            self.searchBar.frame = CGRectMake(0, MyStatusBarHeight - scrollView.contentOffset.y - MyStatusBarHeight, MyKScreenWidth, 44);
//        }
//
//    }
//
//
//    _historyY=scrollView.contentOffset.y;
}
- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar {
    // 1.创建热门搜索
    NSArray *hotSeaches = @[@"圆通快递", @"母婴用品", @"货运搬家", @"开锁", @"棋牌室", @"万悦物业", @"快照复印", @"汽车装饰", @"菜焙子", @"婚庆用品", @"房产中介"];
    // 2. 创建控制器
    PYSearchViewController *searchViewController = [PYSearchViewController searchViewControllerWithHotSearches:hotSeaches searchBarPlaceholder:@"搜索便民信息" didSearchBlock:^(PYSearchViewController *searchViewController, UISearchBar *searchBar, NSString *searchText) {
        // 开始搜索执行以下代码
        // 如：跳转到指定控制器
//        ZWHConvenienceDetailViewController *detailVC = [ZWHConvenienceDetailViewController new];
//        detailVC.navTitle = [NSString stringWithFormat:@"搜索:“%@”",searchText];
//        [searchViewController.navigationController pushViewController:detailVC animated:YES];//搜索注销
    }];
    //    // 3. 设置风格
    //    if (indexPath.section == 0) { // 选择热门搜索
    //        searchViewController.hotSearchStyle = (NSInteger)indexPath.row; // 热门搜索风格根据选择
    //        searchViewController.searchHistoryStyle = PYHotSearchStyleDefault; // 搜索历史风格为default
    //    } else { // 选择搜索历史
    //        searchViewController.hotSearchStyle = PYHotSearchStyleDefault; // 热门搜索风格为默认
    //        searchViewController.searchHistoryStyle = (NSInteger)indexPath.row; // 搜索历史风格根据选择
    //    }
    searchViewController.hotSearchStyle = PYHotSearchStyleBorderTag; // 热门搜索风格根据选择
    searchViewController.searchHistoryStyle = PYHotSearchStyleDefault; // 搜索历史风格为default
    // 4. 设置代理
    searchViewController.delegate = self;
    // 5. 跳转到搜索控制器
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:searchViewController];

    [self presentViewController:nav  animated:YES completion:nil];
    
}
#pragma mark - PYSearchViewControllerDelegate
- (void)searchViewController:(PYSearchViewController *)searchViewController searchTextDidChange:(UISearchBar *)seachBar searchText:(NSString *)searchText
{
    if (searchText.length) { // 与搜索条件再搜索
        // 根据条件发送查询（这里模拟搜索）
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.25 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{ // 搜素完毕
            // 显示建议搜索结果
            NSMutableArray *searchSuggestionsM = [NSMutableArray array];
            for (int i = 0; i < arc4random_uniform(5) + 10; i++) {
                NSString *searchSuggestion = [NSString stringWithFormat:@"搜索建议 %d", i];
                [searchSuggestionsM addObject:searchSuggestion];
            }
            // 返回
            searchViewController.searchSuggestions = searchSuggestionsM;
        });
    }
}


#pragma mark --懒加载
- (NSMutableArray *)imageArray {
    if (_imageArray == nil) {
        _imageArray = [NSMutableArray array];
    }
    return _imageArray;
}



@end
