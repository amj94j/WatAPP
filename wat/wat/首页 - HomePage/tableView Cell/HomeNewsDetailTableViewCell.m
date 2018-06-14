//
//  HomeNewsDetailTableViewCell.m
//  wat
//
//  Created by 123 on 2018/5/24.
//  Copyright © 2018年 wat0801. All rights reserved.
//

#import "HomeNewsDetailTableViewCell.h"

@implementation HomeNewsDetailTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.backgroundColor = [UIColor whiteColor];

    self.detailLabel.hidden = YES;
    self.timeLabel.hidden = YES;
    self.timeImgView.hidden = YES;
    
    self.cellBackgroundView.frame = CGRectMake(0, 0, MyKScreenWidth, 115);
    
    self.imgView.frame = CGRectMake(15, 20, 115, 89);
    self.imgView.contentMode = 2;
    self.imgView.clipsToBounds = YES;
    
    self.titleLabel.frame = CGRectMake(self.imgView.frame.size.width + self.imgView.frame.origin.x + 15, 21, MyKScreenWidth - self.imgView.frame.size.width - 13 - 30 , 40);
    self.titleLabel.font = commenAppFont(18);
    self.timeLabel.numberOfLines = 2;
    [self.titleLabel sizeToFit];
    self.titleLabel.textAlignment = NSTextAlignmentLeft;
    //self.titleLabel.lineBreakMode = NSLineBreakByTruncatingTail;//label 换行
    

    self.checkImg.frame = CGRectMake(self.imgView.frame.size.width + self.imgView.frame.origin.x + 15, self.imgView.frame.origin.y + self.imgView.frame.size.height - 9, 12, 9);
    self.checkImg.contentMode = 2;
    self.checkLabel.frame = CGRectMake(self.checkImg.frame.origin.x + self.checkImg.frame.size.width + 2, self.checkImg.frame.origin.y, 35, 9);
    self.checkLabel.font = commenAppFont(9);
    
    self.likeImg.frame = CGRectMake(self.checkLabel.frame.origin.x + self.checkLabel.frame.size.width + 5, self.checkLabel.frame.origin.y, 10, 10);
    self.likeLabel.frame = CGRectMake(self.likeImg.frame.origin.x + self.likeImg.frame.size.width + 2, self.likeImg.frame.origin.y, 35, 9);
    self.likeLabel.font = commenAppFont(9);
    
    self.writerLabel.frame = CGRectMake(MyKScreenWidth * 0.5, self.checkImg.frame.origin.y, MyKScreenWidth * 0.5 - 13, 11);
    self.writerLabel.textAlignment = NSTextAlignmentRight;
    self.writerLabel.textColor = CommonAppColor;
    self.writerLabel.font = commenAppFont(11);
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
