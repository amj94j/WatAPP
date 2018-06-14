//
//  WatTabBarController.m
//  wat
//
//  Created by 123 on 2018/5/22.
//  Copyright © 2018年 wat0801. All rights reserved.
//

#import "WatTabBarController.h"
#import "WatHomePageViewController.h"
#import "WatNavViewController.h"
#import "WatBigFishClassViewController.h"
#import "WatAlreadyBoughtCourseViewController.h"
#import "WatMeViewController.h"
#import "WatTabBar.h"
@interface WatTabBarController ()

@end

@implementation WatTabBarController
+ (void)initialize
{
    // 通过appearance统一设置所有UITabBarItem的文字属性
    // 后面带有UI_APPEARANCE_SELECTOR的方法, 都可以通过appearance对象来统一设置
    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
    attrs[NSFontAttributeName] = [UIFont systemFontOfSize:12];
    attrs[NSForegroundColorAttributeName] = [UIColor darkGrayColor];
    
    NSMutableDictionary *selectedAttrs = [NSMutableDictionary dictionary];
    selectedAttrs[NSFontAttributeName] = attrs[NSFontAttributeName];
    selectedAttrs[NSForegroundColorAttributeName] = CommonAppColor;
    
    UITabBarItem *item = [UITabBarItem appearance];
    [item setTitleTextAttributes:attrs forState:UIControlStateNormal];
    [item setTitleTextAttributes:selectedAttrs forState:UIControlStateSelected];
}

- (void)viewDidLoad {
    //在页面加载前,让程序多停顿一秒(启动页面多看一会)
    [NSThread sleepForTimeInterval:1.5];
    
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor redColor];
    // 添加子控制器
    [self setupChildVc:[[WatHomePageViewController alloc] init] title:@"首页" image:@"新闻资讯_nomal" selectedImage:@"新闻资讯_seleted"];
//    [self setupChildVc:[[WatBigFishClassViewController alloc] init] title:@"大鱼课堂" image:@"wwtabbaricon_1" selectedImage:@"wwtabbaricon1"];
    [self setupChildVc:[[WatAlreadyBoughtCourseViewController alloc] init] title:@"学习记录" image:@"学习记录_nomal" selectedImage:@"学习记录_seleted"];
    [self setupChildVc:[[WatMeViewController alloc] init] title:@"个人中心" image:@"个人中心_nomal" selectedImage:@"个人中心_seleted"];
    
    WatTabBar *tabBar = [[WatTabBar alloc]init];
    [self setValue:tabBar forKey:@"tabBar"];
 
}

/**
 * 初始化子控制器
 */
- (void)setupChildVc:(UIViewController *)vc title:(NSString *)title image:(NSString *)image selectedImage:(NSString *)selectedImage
{
    // 设置文字和图片
    vc.navigationItem.title = title;
    vc.tabBarItem.title = title;
    UIImage *nomalImg = [[UIImage imageNamed:image]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIImage *selectedImg = [[UIImage imageNamed:selectedImage]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    vc.tabBarItem.image = nomalImg ;
    vc.tabBarItem.selectedImage = selectedImg;
    
    
    // 包装一个导航控制器, 添加导航控制器为tabbarcontroller的子控制器
    WatNavViewController *nav = [[WatNavViewController alloc] initWithRootViewController:vc];
    //设置导航栏背景色以及title颜色
    [[UINavigationBar appearance] setBarTintColor:[UIColor whiteColor]];
    [[UINavigationBar appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:CommonAppColor}];
    
    [self addChildViewController:nav];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
