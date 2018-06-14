//
//  NewsDetailPageViewController.m
//  wat
//
//  Created by 123 on 2018/5/25.
//  Copyright © 2018年 wat0801. All rights reserved.
//

#import "NewsDetailPageViewController.h"

@interface NewsDetailPageViewController ()<UIWebViewDelegate>
@property (nonatomic, strong)UIWebView *classWebView;
@end

@implementation NewsDetailPageViewController
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

    
    [self webViewre];
}


- (void)webViewre {
    //CGFloat phoneVersion = [[[UIDevice currentDevice] systemVersion] floatValue];
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
    NSURL *url = [NSURL URLWithString:@"http://h5.watcn.com/index.php/information/detail?id=8&uid="];
    // 3.创建Request
    NSURLRequest *request =[NSURLRequest requestWithURL:url];
    // 4.加载网页
    [classWebView loadRequest:request];
    // 5.最后将webView添加到界面
    [self.view addSubview:classWebView];
    self.classWebView = classWebView;
    classWebView.allowsInlineMediaPlayback = YES;
}




@end
