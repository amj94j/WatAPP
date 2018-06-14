//
//  TwoViewController.m
//  DoulScro
//
//  Created by wl on 2018/5/22.
//  Copyright © 2018年 https://github.com/orzzh. All rights reserved.
//

#import "TwoViewController.h"
#import "headerCollectionReusableView.h"
#import "ClassItemCollectionViewCell.h"
#import "ClassDetailViewController.h"


@interface TwoViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,UIGestureRecognizerDelegate>
{
    NSArray *hearderTitleArray;
    NSArray *imageArray1;
    NSArray *imageArray2;
    NSArray *sectionNumArr;
}
@property (nonatomic, strong) UICollectionView *collectionView;

@end

@implementation TwoViewController

 

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
    //[self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
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
        CGSize size = {MyKScreenWidth, 40};
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
    
    
    UICollectionReusableView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"reusableView" forIndexPath:indexPath];
    headerView.backgroundColor =[UIColor whiteColor];
    if (headerView.subviews.count == 0) {
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
    
    
    return headerView;
    
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

    
//    if (indexPath.section == 0) {
//        cell.imgView.image = [UIImage imageNamed:imageArray1[indexPath.row]];
//    }else{
//
//        cell.imgView.image = [UIImage imageNamed:imageArray2[indexPath.row]];
//    }
    
    
    
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






@end
