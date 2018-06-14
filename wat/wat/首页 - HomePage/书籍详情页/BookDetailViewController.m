//
//  BookDetailViewController.m
//  wat
//
//  Created by 123 on 2018/6/11.
//  Copyright © 2018年 wat0801. All rights reserved.
//

#import "BookDetailViewController.h"
#import "ByClassViewController.h"
#import "FLCountDownView.h"//限时抢购倒计时

#define headerViewHeight 400
@interface BookDetailViewController ()<UIWebViewDelegate>
@property (nonatomic, strong)UIWebView *classWebView;
@end

@implementation BookDetailViewController
- (UIWebView *)classWebView
{
    if (!_classWebView) {
        _classWebView = [[UIWebView alloc]initWithFrame:CGRectMake(0, MyTopHeight, MyKScreenWidth, MyKScreenHeight - MyTopHeight - 55)];
        _classWebView.delegate = self;
    }
    return  _classWebView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = WatBackColor;
    
    [self webViewre];
    [self addBuyBtn];
}


- (void)webViewre {
    //CGFloat phoneVersion = [[[UIDevice currentDevice] systemVersion] floatValue];
    //    if (phoneVersion >= 10.0) {
    //        content = [content stringByReplacingOccurrencesOfString:@"<video" withString:@"<video playsinline"];
    //    }else {
    //        content = [content stringByReplacingOccurrencesOfString:@"<video" withString:@"<video webkit-playsinline"];
    //    }
    
    
    
    // 1.创建webview，并设置大小，"20"为状态栏高度
    UIWebView *classWebView = [[UIWebView alloc] initWithFrame:CGRectMake(0, MyTopHeight, MyKScreenWidth, MyKScreenHeight - MyTopHeight)];
    // 2.创建URL
    classWebView.backgroundColor = WatBackColor;
    [classWebView setBackgroundColor:[UIColor clearColor]];
    [classWebView setOpaque:NO];
    classWebView.scrollView.backgroundColor = [UIColor whiteColor];
    classWebView.scrollView.contentInset = UIEdgeInsetsMake(headerViewHeight, 0, 0, 0);
    NSURL *url = [NSURL URLWithString:@"https://h5.watcn.com/education/content?id=58"];
    // 3.创建Request
    NSURLRequest *request =[NSURLRequest requestWithURL:url];
    // 4.加载网页
    [classWebView loadRequest:request];
    // 5.最后将webView添加到界面
    [self.view addSubview:classWebView];
    self.classWebView = classWebView;
    classWebView.allowsInlineMediaPlayback = YES;
    
    [self addHeaderView];
    
    if (@available(iOS 11.0, *)) {
        self.classWebView.scrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }
}
//webView.scrollView.header
-(void)addHeaderView {
    UIImageView *headerImgView = [[UIImageView alloc]initWithFrame:CGRectMake(0, -headerViewHeight, MyKScreenWidth, 240)];
    headerImgView.image = [UIImage imageNamed:@"1234567896"];
    headerImgView.backgroundColor = [UIColor whiteColor];
    headerImgView.contentMode = 0;
    [self.classWebView.scrollView addSubview:headerImgView];
    
    UILabel *titleLab = [[UILabel alloc]initWithFrame:CGRectMake(15, headerImgView.frame.size.height + headerImgView.frame.origin.y + 10, MyKScreenWidth - 20, 1)];
    titleLab.font = commenAppFont(22);
    titleLab.textColor = [UIColor blackColor];
    titleLab.text = @"王牌店长特训营王牌店长特训营王牌店长特训营王牌店长特训营王牌店长特训营王牌店长特训营王牌店长特训营王牌店长特训营";
    titleLab.textAlignment = NSTextAlignmentLeft;
    titleLab.numberOfLines = 2;
    [titleLab sizeToFit];
    [self.classWebView.scrollView addSubview:titleLab];
    
    UILabel *subTitleLab = [[UILabel alloc]initWithFrame:CGRectMake(15, titleLab.frame.size.height + titleLab.frame.origin.y + 4, MyKScreenWidth - 30, 1)];
    subTitleLab.font = commenAppFont(16);
    subTitleLab.alpha = 0.8;
    subTitleLab.textColor = [UIColor blackColor];
    subTitleLab.text = @"稳中促业绩,轻松管员工,舒心做店长";
    subTitleLab.textAlignment = NSTextAlignmentLeft;
    subTitleLab.numberOfLines = 3;
    [subTitleLab sizeToFit];
    [self.classWebView.scrollView addSubview:subTitleLab];
    
    UILabel *timeLab = [[UILabel alloc]initWithFrame:CGRectMake(15, subTitleLab.frame.size.height + subTitleLab.frame.origin.y + 3, 200, 1)];
    timeLab.font = commenAppFont(14);
    timeLab.textColor = [UIColor grayColor];
    timeLab.text = @"时间:6月7日-6月8日";
    timeLab.textAlignment = NSTextAlignmentLeft;
    timeLab.numberOfLines = 1;
    [timeLab sizeToFit];
    [self.classWebView.scrollView addSubview:timeLab];
    
    UILabel *addressLab = [[UILabel alloc]initWithFrame:CGRectMake(timeLab.frame.size.width + timeLab.frame.origin.x + 3, timeLab.frame.origin.y, 200, 1)];
    addressLab.font = commenAppFont(14);
    addressLab.textColor = [UIColor grayColor];
    addressLab.text = @"地点:北京";
    addressLab.textAlignment = NSTextAlignmentLeft;
    addressLab.numberOfLines = 1;
    [addressLab sizeToFit];
    [self.classWebView.scrollView addSubview:addressLab];
    
    UILabel *daojishiLab = [[UILabel alloc]initWithFrame:CGRectMake(15, timeLab.frame.size.height + timeLab.frame.origin.y + 5, 200, 1)];
    daojishiLab.font = commenAppFont(14);
    daojishiLab.textColor = CommonAppColor;
    daojishiLab.text = @"距离开课还剩:";
    daojishiLab.textAlignment = NSTextAlignmentLeft;
    daojishiLab.numberOfLines = 1;
    [daojishiLab sizeToFit];
    [self.classWebView.scrollView addSubview:daojishiLab];
    
    //限时抢购 倒计时
    FLCountDownView *countDown      = [FLCountDownView fl_countDown];
    countDown.frame                 = CGRectMake(daojishiLab.frame.size.width + daojishiLab.frame.origin.x + 7, timeLab.frame.size.height + timeLab.frame.origin.y + 4, 100, 20);
    countDown.timestamp             = 864000;
    countDown.backgroundImageName   = @"search_k";
    countDown.timerStopBlock        = ^{
        NSLog(@"时间停止");
    };
    [self.classWebView.scrollView addSubview:countDown];
    
    UILabel *buyNumLab = [[UILabel alloc]initWithFrame:CGRectMake(MyKScreenWidth - 115, daojishiLab.frame.origin.y, 100, 1)];
    buyNumLab.font = commenAppFont(14);
    buyNumLab.textColor = [UIColor grayColor];
    buyNumLab.text = @"已有3000人次购买";
    buyNumLab.textAlignment = NSTextAlignmentRight;
    buyNumLab.numberOfLines = 1;
    [buyNumLab sizeToFit];
    buyNumLab.frame = CGRectMake(MyKScreenWidth - buyNumLab.frame.size.width - 15, daojishiLab.frame.origin.y, buyNumLab.frame.size.width, buyNumLab.frame.size.height);
    [self.classWebView.scrollView addSubview:buyNumLab];
    
}
- (void)addBuyBtn {
    
    UIView *v = [[UIView alloc]initWithFrame:CGRectMake(0, MyKScreenHeight - MyTabBarHeight, MyKScreenWidth, MyTabBarHeight)];
    v.backgroundColor = WatBackColor;
    [self.view addSubview:v];
    
    UIButton *buyBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, MyKScreenHeight - MyTabBarHeight, MyKScreenWidth, 49)];
    [buyBtn setTitle:@"购  买" forState:UIControlStateNormal];
    [buyBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    buyBtn.backgroundColor = CommonAppColor;
    [buyBtn addTarget:self action:@selector(buyBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:buyBtn];
    
}


- (void)buyBtnClick{
    ByClassViewController *byVc = [ByClassViewController new];
    byVc.navTitle = @"确认订单";
    [self.navigationController pushViewController:byVc animated:YES];
    
}

@end
