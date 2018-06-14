//
//  ClassDetailViewController.m
//  wat
//
//  Created by 123 on 2018/6/7.
//  Copyright © 2018年 wat0801. All rights reserved.
//

#import "ClassDetailViewController.h"
#import "ByClassViewController.h"
@interface ClassDetailViewController ()<UIWebViewDelegate>
@property (nonatomic, strong)UIWebView *classWebView;
@end

@implementation ClassDetailViewController
- (UIWebView *)classWebView
{
    if (!_classWebView) {
        _classWebView = [[UIWebView alloc]initWithFrame:CGRectMake(0, 0, MyKScreenWidth, MyKScreenHeight)];
        _classWebView.delegate = self;
    }
    return  _classWebView;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.rightTitles = @[@"购买"];
    
    [self webViewre];
}
- (void)webViewre {
    CGFloat phoneVersion = [[[UIDevice currentDevice] systemVersion] floatValue];
//    if (phoneVersion >= 10.0) {
//        content = [content stringByReplacingOccurrencesOfString:@"<video" withString:@"<video playsinline"];
//    }else {
//        content = [content stringByReplacingOccurrencesOfString:@"<video" withString:@"<video webkit-playsinline"];
//    }
    

    
    // 1.创建webview，并设置大小，"20"为状态栏高度
    CGFloat width = self.view.frame.size.width;
    CGFloat height = self.view.frame.size.height - 20;
    UIWebView *classWebView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 20, width, height)];
    // 2.创建URL
    classWebView.backgroundColor = WatBackColor;
    NSURL *url = [NSURL URLWithString:@"https://h5.watcn.com/education/content?id=58"];
    // 3.创建Request
    NSURLRequest *request =[NSURLRequest requestWithURL:url];
    // 4.加载网页
    [classWebView loadRequest:request];
    // 5.最后将webView添加到界面
    [self.view addSubview:classWebView];
    self.classWebView = classWebView;
    classWebView.allowsInlineMediaPlayback = YES;
}
- (void)rightBtnsAction:(UIButton *)button{
    NSLog(@"点击了购买课程按钮");
    ByClassViewController *byVc = [ByClassViewController new];
    byVc.navTitle = @"确认订单";
    [self.navigationController pushViewController:byVc animated:YES];
}

@end
