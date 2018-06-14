//
//  ViewController.m
//  wat
//
//  Created by 123 on 2018/5/22.
//  Copyright © 2018年 wat0801. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
{
    UIImage *navigationBarimg;
}
@property (nonatomic, strong)UIButton *backBtn;
@property (nonatomic, strong)UIButton *titleBtn;

@end

@implementation ViewController
-(UIButton *)backBtn
{
    if (!_backBtn) {
        _backBtn = [[UIButton alloc]init];
    }
    return _backBtn;
}

- (void)setNavTitle:(NSString *)navTitle
{
    _navTitle = navTitle;
    [self addNavtitles];
}

- (void)setNavBackTitle:(NSString *)navBackTitle
{
    //_navBackTitle = navBackTitle;
    [self.backBtn setTitle:navBackTitle forState:UIControlStateNormal];
    [self addBackNav];
    
}
- (void)setNavBackImage:(NSString *)navBackImage
{
    if (!self.backBtn) {
        [self addBackNav];
    }
    [self.backBtn setImage:[UIImage imageNamed:navBackImage] forState:UIControlStateNormal];
    
}
- (void)setIsBackTitle:(BOOL)isBackTitle
{
    self.backBtn.hidden = isBackTitle;
}

- (void)setRightTitles:(NSArray *)rightTitles
{
    _rightTitles = rightTitles;
    [self addRightButtonsByArr:rightTitles];
}
- (void)setRightImages:(NSArray *)rightImages
{
    
    _rightImages = rightImages;
    [self addRightButtonsByArr:rightImages];
}
- (void)setBackTitle:(NSString *)backTitle
{
    [self.backBtn setTitle:backTitle forState:UIControlStateNormal];
}
- (void)setBackImage:(NSString *)backImage
{
    [self.backBtn setImage:[UIImage imageNamed:backImage] forState:UIControlStateNormal];
}

- (void)addBackNav
{
    self.backBtn=[UIButton   buttonWithType:UIButtonTypeCustom];
    self.backBtn.titleLabel.textColor=CommonAppColor;
    
    self.backBtn.frame=CGRectMake(30, 0, 100, 20);
    
    [self.backBtn sizeToFit];
    self.backBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    self.backBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 0);
    [self.backBtn addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
    [self.backBtn setImage:[UIImage imageNamed:@"zwy_nav_back_image"] forState:UIControlStateNormal];
    UIBarButtonItem *leftButton = [[UIBarButtonItem alloc] initWithCustomView:self.backBtn];
    
    [self.backBtn setTitleColor:CommonAppColor forState:UIControlStateNormal];
    self.navigationItem.leftBarButtonItem=leftButton;
}
- (void)addNavtitles
{
    self.titleBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 200, 40)];
    [self.titleBtn setTitle:_navTitle forState:UIControlStateNormal];
    [self.titleBtn setTitleColor:CommonAppColor forState:UIControlStateNormal];
    [self.titleBtn addTarget:self action:@selector(titleAction) forControlEvents:UIControlEventTouchUpInside];
    [self.titleBtn sizeToFit];
    self.navigationItem.titleView = self.titleBtn;
}
- (void)addRightButtonsByArr:(NSArray *)arr;
{
    NSMutableArray *rightBtns = [NSMutableArray array];
    
    for (int i = 0; i<arr.count; i++) {
        UIButton *rightBtn=[UIButton   buttonWithType:UIButtonTypeCustom];
        //rightBtn.backgroundColor = [UIColor blackColor];
        [rightBtn.imageView setContentMode:UIViewContentModeScaleAspectFit];
        [rightBtn setTitleColor:CommonAppColor forState:UIControlStateNormal];
        [rightBtn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateHighlighted];
        rightBtn.titleLabel.font = CommenCellFont;
        rightBtn.frame=CGRectMake(0, 0, 60, 20);
        [rightBtn sizeToFit];
        //  rightBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        rightBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 0);
        //          [rightBtn setTintColor:[UIColor whiteColor]];
        //        rightBtn.backgroundColor = [UIColor yellowColor];
        //[rightBtn setImage:[UIImage imageNamed:@"zwy_nav_back_image"] forState:UIControlStateNormal];
        UIBarButtonItem *rightButton = [[UIBarButtonItem alloc] initWithCustomView:rightBtn];
        if (self.rightTitles.count>0) {
            [rightBtn setTitle:self.rightTitles[i] forState:UIControlStateNormal];
        }
        if (self.rightImages.count>0) {
            [rightBtn setImage:[UIImage imageNamed:self.rightImages[i]] forState:UIControlStateNormal];
        }
        rightBtn.tag = 100+i;
        [rightBtn addTarget:self action:@selector(rightBtnsAction:) forControlEvents:UIControlEventTouchUpInside];
        
        [rightBtns addObject:rightButton];
    }
    
    self.navigationItem.rightBarButtonItems=rightBtns;
}


#pragma mark - 返回事件
-(void)backAction
{
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark - title事件
-(void)titleAction
{
    
}
#pragma mark - 右侧按钮点击事件
- (void)rightBtnsAction:(UIButton *)button
{
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = WatBackColor;
    
    if (!KIsiPhoneX) {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    self.view.backgroundColor = [UIColor whiteColor];
    [self addBackNav];
    
}


- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [self.navigationController.view insertSubview:self.navBarView belowSubview:self.navigationController.navigationBar];
    
    //导航栏透明
    navigationBarimg = [self.navigationController.navigationBar backgroundImageForBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setBackgroundImage:[[UIImage alloc] init] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    //    如果不想让其他页面的导航栏变为透明 需要重置
    [self.navigationController.navigationBar setBackgroundImage:navigationBarimg forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:nil];
    [self.navBarView removeFromSuperview];
}
- (UIView *)navBarView{
    if (!_navBarView) {
        _navBarView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, MyKScreenWidth, MyTopHeight)];
        _navBarView.backgroundColor = [UIColor whiteColor];
        _navBarView.alpha = 1;
        UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(0, _navBarView.frame.size.height - 0.5, MyKScreenWidth, 0.5)];
        lineView.backgroundColor = [UIColor grayColor];
        lineView.alpha = 0.2;
        [_navBarView addSubview:lineView];
        [_navBarView addSubview:self.titleLa];
    }
    return _navBarView;
}
- (UILabel *)titleLa{
    if (!_titleLa) {
        _titleLa = [UILabel new];
        _titleLa.text = @"";
        _titleLa.frame = CGRectMake(0, MyStatusBarHeight, MyKScreenWidth, 44);
        _titleLa.textColor = CommonAppColor;
        //_titleLa.font = [UIFont systemFontOfSize:16];
        _titleLa.textAlignment = NSTextAlignmentCenter;
    }
    return _titleLa;
}

@end
