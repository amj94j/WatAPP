//
//  GeneralizeTableViewCell.m
//  wat
//
//  Created by 123 on 2018/5/30.
//  Copyright © 2018年 wat0801. All rights reserved.
//

#import "GeneralizeTableViewCell.h"

@implementation GeneralizeTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.imgView.frame =CGRectMake(13, 12, 76, 59);
    
    self.titleLab.frame = CGRectMake(self.imgView.frame.origin.x + self.imgView.frame.size.width + 22, self.imgView.frame.origin.y, MyKScreenWidth - self.titleLab.frame.origin.x - 30, 16);
    self.titleLab.font = commenAppFont(13);
    self.titleLab.textColor = [UIColor blackColor];
    
    
    self.moneyLab.frame = CGRectMake(self.titleLab.frame.origin.x, self.titleLab.frame.origin.y + self.titleLab.frame.size.height + 7, 44, 13);
    self.moneyLab.font = commenAppFont(13);
    self.moneyLab.adjustsFontSizeToFitWidth = YES;
    self.moneyLab.textColor = [UIColor blackColor];
    
    self.yongjinLab.frame = CGRectMake(self.moneyLab.frame.size.width + self.moneyLab.frame.origin.x + 10, self.moneyLab.frame.origin.y + 3, 40, 10);
    self.yongjinLab.font = commenAppFont(10);
    self.yongjinLab.textColor = [UIColor orangeColor];
    
    self.shouyiLab.frame = CGRectMake(self.moneyLab.frame.origin.x, self.moneyLab.frame.origin.y + self.moneyLab.frame.size.height + 7, 200, 13);
    self.shouyiLab.font = commenAppFont(13);
    self.shouyiLab.textColor = CommonAppColor;
    
    self.goBtn.frame = CGRectMake(MyKScreenWidth - 60 - 13, 81 - 24, 60, 20);
    self.goBtn.titleLabel.font = commenAppFont(12);
    self.goBtn.layer.cornerRadius = 2.0;
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
