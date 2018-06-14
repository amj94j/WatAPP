//
//  WatBigFishClassViewController.m
//  wat
//
//  Created by 123 on 2018/5/22.
//  Copyright © 2018年 wat0801. All rights reserved.
//

#import "WatBigFishClassViewController.h"
#import "OneViewController.h"
#import "TwoViewController.h"
#import "MainTableView.h"
#import "WMPageController.h"
#import "WHScrollView.h"




#define scr_wid [UIScreen mainScreen].bounds.size.width
#define scr_hei [UIScreen mainScreen].bounds.size.height
@interface WatBigFishClassViewController ()<scrollDelegate,WMPageControllerDelegate,UITableViewDataSource,UITableViewDelegate>
{
    CGFloat star_y;
    
}
@property (nonatomic,strong)MainTableView *mainTableView;
@property(nonatomic,strong) UIScrollView  *parentScrollView;

@property (nonatomic,assign)BOOL mainScroll;
@end

@implementation WatBigFishClassViewController

#pragma mark - scrollDelegate

- (void)scrollViewLeaveAtTheTop:(UIScrollView *)scrollView{
    self.parentScrollView = scrollView;
    
    //main tv滑动到顶 sub tv向下滑动到顶,main tv可以滚动
    _mainScroll = YES;
    
}
- (void)scrollViewChangeTab:(UIScrollView *)scrollView{
    
    //刷新滚动表格
    self.parentScrollView = scrollView;
    NSLog(@"%@",NSStringFromClass([self.parentScrollView class]));
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    
    //记录main tv 起始偏移
    star_y = scrollView.contentOffset.y;
}

#pragma mark - Logic

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    CGFloat height = MyTopHeight;
    
    CGFloat offset = scrollView.contentOffset.y;
    NSLog(@"滚动偏移量+++++++%lf  ++++++%lf",offset,MyTopHeight);
    //导航栏透明度
//    if (offset<=-MyTopHeight) {
//
//        CGFloat alpha =(227 + offset) / 136;
//        self.navBarView.alpha = alpha;
//    }
    
    //滚动逻辑
    
    //main tv目前处于未置顶状态 并且 可以滚动
    if (offset < - MyTopHeight && _mainScroll) {
        
        //main tv滚动起始位置处于置顶和0点之间 并且 sub tv不是置顶状态
        if (star_y < - MyTopHeight && star_y > -227 + 100 &&
            self.parentScrollView.contentOffset.y>0) {
            
            //一起滚动
            
        }else{
            
            //sub tv是置顶状态或者0点位置 限制sub滚动
            self.parentScrollView.contentOffset = CGPointMake(0, 0);
        }
    }else{
        
        //main tv滑动到顶 sub tv正在向下滑动
        scrollView.contentOffset = CGPointMake(0, -MyTopHeight);
    }
    
    //main tv目前处于置顶状态 并且 可以滚动
    if (offset>=-MyTopHeight && _mainScroll) {
        
        //禁止滚动 固定位置
        _mainScroll = NO;
        scrollView.contentOffset = CGPointMake(0, -MyTopHeight);
    }
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    //self.view.backgroundColor = [UIColor whiteColor];
    self.navTitle = @"大鱼餐饮学院";
    
    //默认初始 主tv可滚动
    _mainScroll = YES;
    
    self.mainTableView.bounces = NO;
    
    if (@available(iOS 11.0, *)) {
        self.mainTableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }else {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    
    
    [self.view addSubview:self.mainTableView];
//    UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(0, -245, scr_wid, 245)];
//    btn.backgroundColor = [UIColor yellowColor];
//    [btn setTitle:@"加油" forState: UIControlStateNormal];
//    [btn addTarget:self action:@selector(ceshiClick) forControlEvents:UIControlEventTouchUpInside];
//    [self.mainTableView addSubview:btn];
    
    //轮播图
    CGRect rect = CGRectMake(0, -227 + 45, MyKScreenWidth,227 - 45);
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
    }];
    [self.mainTableView addSubview:scroll];
    
    
//    UIButton *r = [UIButton new];
//    [r addTarget:self action:@selector(pop) forControlEvents:UIControlEventTouchUpInside];
//    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:r];
    
}
- (void)ceshiClick {
    
    NSLog(@"点击了加油测试按钮");
}
//- (void)pop{
//    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
//}




- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return scr_hei-MyTopHeight;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.01;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.01;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return [UIView new];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    /* 添加pageView
     * 这里可以任意替换你喜欢的pageView
     *作者这里使用一款github较多人使用的 WMPageController 地址https://github.com/wangmchn/WMPageController
     */
    [cell.contentView addSubview:self.setPageViewControllers];
    return cell;
    
}



#pragma mark -- setter/getter

-(UIView *)setPageViewControllers
{
    WMPageController *pageController = [self p_defaultController];
    pageController.title = @"Line";
    pageController.menuViewStyle = WMMenuViewStyleLine;
    pageController.titleSizeSelected = 15;
    
    [self addChildViewController:pageController];
    [pageController didMoveToParentViewController:self];
    return pageController.view;
}

- (WMPageController *)p_defaultController {
    OneViewController * oneVc  = [OneViewController new];
    oneVc.delegate = self;
    
//    TwoViewController * twoVc  = [TwoViewController new];
//    twoVc.delegate = self;
    
    
    NSArray *viewControllers = @[oneVc];
    
//    NSArray *titles = @[@"线下课程"];
    NSArray *titles = @[@"课程列表"];
    WMPageController *pageVC = [[WMPageController alloc] initWithViewControllerClasses:viewControllers andTheirTitles:titles];
    [pageVC setViewFrame:CGRectMake(0, 0, scr_wid, scr_hei - MyTopHeight - MyTabBarHeight)];
    pageVC.delegate = self;
    pageVC.menuItemWidth = MyKScreenWidth / titles.count;
    pageVC.menuHeight = 44;
    pageVC.postNotification = YES;
    pageVC.bounces = YES;
    
    return pageVC;
}

- (MainTableView *)mainTableView{
    if (!_mainTableView) {
        _mainTableView = [[MainTableView alloc]initWithFrame:CGRectMake(0, MyTopHeight, scr_wid, scr_hei ) style:UITableViewStylePlain];
        _mainTableView.delegate = self;
        _mainTableView.dataSource = self;
        _mainTableView.estimatedSectionHeaderHeight = 0;
        _mainTableView.estimatedSectionFooterHeight = 0;
        _mainTableView.contentInset = UIEdgeInsetsMake(227 - 45, 0, 0, 0);
        _mainTableView.backgroundColor = [UIColor grayColor];
        
    }
    return _mainTableView;
}


/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
