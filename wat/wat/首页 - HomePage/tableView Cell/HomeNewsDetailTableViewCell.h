//
//  HomeNewsDetailTableViewCell.h
//  wat
//
//  Created by 123 on 2018/5/24.
//  Copyright © 2018年 wat0801. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HomeNewsDetailTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIView *cellBackgroundView;//背景View

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;//标题
@property (weak, nonatomic) IBOutlet UIImageView *timeImgView;//时间图标
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;//时间label
@property (weak, nonatomic) IBOutlet UILabel *writerLabel;//作者名称
@property (weak, nonatomic) IBOutlet UIImageView *imgView;//主图
@property (weak, nonatomic) IBOutlet UILabel *detailLabel;//描述
@property (weak, nonatomic) IBOutlet UIImageView *checkImg;//查看图标
@property (weak, nonatomic) IBOutlet UILabel *checkLabel;//查看label
@property (weak, nonatomic) IBOutlet UIImageView *likeImg;//点赞 img
@property (weak, nonatomic) IBOutlet UILabel *likeLabel;//点赞label




@end
