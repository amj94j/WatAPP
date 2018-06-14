//
//  WHScrollView.m
//  wat
//
//  Created by 123 on 2018/5/24.
//  Copyright © 2018年 wat0801. All rights reserved.
//





#import "WHScrollView.h"
typedef enum : NSUInteger {
    ScrollViewDirectionRight,           /** 向右滚动*/
    ScrollViewDirectionLeft,            /** 向左滚动*/
}ScrollViewDirection;
@interface WHScrollView() <UIScrollViewDelegate>

@property (nonatomic,strong)UIScrollView *scrollView;
@property (nonatomic,strong)NSArray *dataArry;
@property (nonatomic,assign)NSInteger currentImageIndex;
//@property (nonatomic,assign)NSInteger currentPage;
@property (nonatomic,assign)CGFloat lastContentOffset;
@property (nonatomic,assign)ScrollViewDirection scrollDirection;
@property (nonatomic,strong)NSMutableArray *imageViews;
@property (nonatomic,assign)NSInteger imageCount;
@property (nonatomic,strong)NSTimer *timer;
@property (nonatomic,strong)UIPageControl *pageControl;
@end
@implementation WHScrollView
@synthesize color_currentPageControl = _color_currentPageControl ,
color_pageControl = _color_pageControl ;
- (instancetype)initWithFrame:(CGRect)frame
                   withImages:(NSArray *)images
                withIsRunloop:(BOOL)isRunloop
                    withBlock:(ImageViewClick)block;
{
    self = [super initWithFrame:frame];
    if (self) {
        self.dur = 3;
        self.imageCount = images ? images.count : 0;
        self.isRunloop = isRunloop;
        self.dataArry = images;
        self.click = block;
        [self loadBaseView];
    }
    return self;
}
- (void)loadBaseView
{
    
    self.currentImageIndex = 0;
    //    self.currentPage = 1;
    self.scrollView.contentOffset = CGPointMake(self.scrollView.frame.size.width, 0);
    //    for (int i = 0; i < 100; i ++) {
    //        [self.dataArry addObject:RGBColor(arc4random()%255, arc4random()%255, arc4random()%255)];
    //    }
    
    for (int i = 0; i<3; i ++) {
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(i*self.scrollView.frame.size.width, 0, self.scrollView.frame.size.width, self.scrollView.frame.size.height)];
        imageView.contentMode = UIViewContentModeScaleAspectFit;
        
        if (i == 0 && self.dataArry!=nil && self.dataArry.count > 1) {
            //imageView.backgroundColor = self.dataArry[self.dataArry.count - 1];//左边
            imageView.image = self.dataArry[self.dataArry.count - 1];
        }
        if (i == 1 && self.dataArry!=nil && self.dataArry.count > 0) {
            //imageView.backgroundColor = self.dataArry[0];//中间
            imageView.image = self.dataArry[0];
        }
        if (i == 2 && self.dataArry !=nil && self.dataArry.count > 1) {
            //imageView.backgroundColor = self.dataArry[1];//右边
            imageView.image = imageView.image = self.dataArry[1];
        }
        [self.imageViews addObject:imageView];
        [self.scrollView addSubview:imageView];
        
    }
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction)];
    [self.scrollView addGestureRecognizer:tap];
    [self addSubview:self.scrollView];
    [self addSubview:self.pageControl];
    
    
}

#pragma mark -
#pragma mark - set
- (void)setImageCount:(NSInteger)imageCount
{
    _imageCount = imageCount;
    if (_imageCount < 1) {
        self.scrollView.scrollEnabled = NO;
        return;
    }
    self.scrollView.scrollEnabled = YES;
    self.pageControl.numberOfPages = imageCount ;
    CGSize size = [self.pageControl sizeForNumberOfPages:imageCount];
    self.pageControl.bounds = CGRectMake(0, 0, size.width, size.height);
    self.pageControl.center = CGPointMake(self.frame.size.width - size.width - 0. , self.frame.size.height - 20.) ;
    self.pageControl.currentPage = 0;
}
- (void)setIsRunloop:(BOOL)isRunloop
{
    _isRunloop = isRunloop;
    if (isRunloop) {
        [self createTimer];
    }
}
- (void)setColor_pageControl:(UIColor *)color_pageControl
{
    _color_pageControl = color_pageControl ;
    
    self.pageControl.pageIndicatorTintColor = _color_pageControl ;
}
//default whiteColor
- (UIColor *)color_pageControl
{
    if (!_color_pageControl) {
        _color_pageControl = [UIColor whiteColor] ;
    }
    return _color_pageControl ;
}

- (void)setColor_currentPageControl:(UIColor *)color_currentPageControl
{
    _color_currentPageControl = color_currentPageControl ;
    
    self.pageControl.currentPageIndicatorTintColor = _color_currentPageControl ;
}
//default darkGrayColor
- (UIColor *)color_currentPageControl
{
    if (!_color_currentPageControl) {
        _color_currentPageControl = [UIColor darkGrayColor] ;
    }
    return _color_currentPageControl ;
}
//create timer
- (void)createTimer{
    if (self.timer == nil) {
        self.timer = [NSTimer scheduledTimerWithTimeInterval:self.dur target:self selector:@selector(timerAction) userInfo:nil repeats:YES];
        [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
    }
}
#pragma mark -
#pragma mark - action
- (void)timerAction{
    if (_imageCount <= 1) return ;
    [self.scrollView setContentOffset:CGPointMake(self.scrollView.frame.size.width *2, 0) animated:YES];
    [self performSelector:@selector(reloadImage) withObject:nil afterDelay:.35];
    
}
- (void)tapAction{
    if (self.click) {
        self.click(_currentImageIndex);
    }
}
#pragma mark -
#pragma mark - scrollViewDelegate

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    [self reloadImage];
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    //    NSLog(@"开始拖拽");
    [self.timer invalidate];
    self.timer = nil;
}
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    [self createTimer];
}
- (void)reloadImage
{
    if ( self.imageViews.count == 0 || self.dataArry.count == 0) {
        return;
    }
    NSInteger leftImageIndex,rightImageIndex ;
    CGPoint offset = [_scrollView contentOffset] ;
    
    if (offset.x > self.frame.size.width)
    { //  向右滑动
        _currentImageIndex = (_currentImageIndex + 1) % self.dataArry.count ;
    }
    else if(offset.x < self.frame.size.width)
    { //  向左滑动
        _currentImageIndex = (_currentImageIndex + self.dataArry.count - 1) % self.dataArry.count ;
    }
    
    UIImageView * centerImageView = [self.imageViews objectAtIndex:1];
    UIImageView *leftImageView = [self.imageViews objectAtIndex:0];
    UIImageView *rightImageView = [self.imageViews objectAtIndex:2];
    
    //centerImageView.backgroundColor =self.dataArry[_currentImageIndex];
    centerImageView.image = self.dataArry[_currentImageIndex];
    //  重新设置左右图片
    leftImageIndex  = (_currentImageIndex + self.dataArry.count - 1) % self.dataArry.count ;
    rightImageIndex = (_currentImageIndex + 1) % self.dataArry.count ;
    //    leftImageView.backgroundColor  = self.dataArry[leftImageIndex] ;
    //    rightImageView.backgroundColor = self.dataArry[rightImageIndex] ;
    leftImageView.image  = self.dataArry[leftImageIndex] ;
    rightImageView.image = self.dataArry[rightImageIndex] ;
    
    [self.scrollView setContentOffset:CGPointMake(self.scrollView.frame.size.width, 0) animated:NO];
    self.pageControl.currentPage = self.currentImageIndex;
}

#pragma mark -懒加载
- (NSMutableArray *)imageViews
{
    if (!_imageViews) {
        _imageViews = [[NSMutableArray alloc] init];
    }
    return _imageViews;
}
- (UIScrollView *)scrollView
{
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] init];
        _scrollView.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
        _scrollView.contentSize = CGSizeMake(self.frame.size.width *3, self.frame.size.height);
        _scrollView.delegate = self;
        _scrollView.pagingEnabled = YES;
        _scrollView.showsVerticalScrollIndicator = NO;
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.bounces = NO;
        
    }
    return _scrollView;
}
- (UIPageControl *)pageControl
{
    if (!_pageControl) {
        _pageControl = [[UIPageControl alloc] init] ;
        _pageControl.pageIndicatorTintColor = self.color_pageControl ;
        _pageControl.currentPageIndicatorTintColor = self.color_currentPageControl ;
        
    }
    
    return _pageControl ;
}
- (void)dealloc
{
    if (self.timer) {
        [self.timer invalidate];
        self.timer = nil;
    }
    
}
@end
