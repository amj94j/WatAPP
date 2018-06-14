//
//  UnUsedOrderTableViewCell.m
//  wat
//
//  Created by 123 on 2018/5/29.
//  Copyright © 2018年 wat0801. All rights reserved.
//

#import "UnUsedOrderTableViewCell.h"

@implementation UnUsedOrderTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.imgView.frame =CGRectMake(13, 12, 76, 59);
    
    self.titleLab.frame = CGRectMake(self.imgView.frame.origin.x + self.imgView.frame.size.width + 22, self.imgView.frame.origin.y, MyKScreenWidth - self.titleLab.frame.origin.x - 30, 20);
    self.titleLab.font = commenAppFont(13);
    self.titleLab.textColor = [UIColor blackColor];
    
    self.timeLab.frame = CGRectMake(self.titleLab.frame.origin.x, self.titleLab.frame.size.height + self.titleLab.frame.origin.y + 7, self.titleLab.frame.size.width * 0.5, 9);
    self.timeLab.font = commenAppFont(9);
    self.timeLab.textColor = [UIColor grayColor];
    
    self.moneyLab.frame = CGRectMake(self.timeLab.frame.origin.x, self.timeLab.frame.origin.y + self.timeLab.frame.size.height + 10, 100, 12);
    self.moneyLab.font = commenAppFont(12);
    self.moneyLab.textColor = [UIColor blackColor];
    
    self.goBtn.frame = CGRectMake(MyKScreenWidth - 60 - 13, 81 - 24, 60, 20);
    self.goBtn.titleLabel.font = commenAppFont(12);
    self.goBtn.layer.cornerRadius = 2.0;
    
    self.typeLabel.frame = CGRectMake(MyKScreenWidth - 60 - 13, 81 - 24, 60, 20);
    self.typeLabel.backgroundColor = [UIColor clearColor];
    self.typeLabel.font = commenAppFont(12);
    self.typeLabel.textColor = [UIColor grayColor];
    self.typeLabel.textAlignment = NSTextAlignmentCenter;
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
