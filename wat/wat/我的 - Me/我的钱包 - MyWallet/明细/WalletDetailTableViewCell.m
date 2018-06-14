//
//  WalletDetailTableViewCell.m
//  wat
//
//  Created by 123 on 2018/6/8.
//  Copyright © 2018年 wat0801. All rights reserved.
//

#import "WalletDetailTableViewCell.h"

@implementation WalletDetailTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.typeLab.frame = CGRectMake(10, 8, 100, 27);
    self.typeLab.textColor = [UIColor blackColor];
    self.typeLab.font = commenAppFont(18);
    
    self.yueLab.frame = CGRectMake(10, 35, 100, 15);
    self.yueLab.textColor = [UIColor darkGrayColor];
    self.yueLab.font = commenAppFont(13);
    
    self.zhichuMoneyLab.frame = CGRectMake(MyKScreenWidth - 110, 8, 100, 27);
    self.zhichuMoneyLab.textColor = [UIColor blackColor];
    self.zhichuMoneyLab.font = commenAppFont(18);
    self.zhichuMoneyLab.textAlignment = NSTextAlignmentRight;
    
    self.timeLab.frame = CGRectMake(MyKScreenWidth - 110, 35, 100, 15);
    self.timeLab.textColor = [UIColor darkGrayColor];
    self.timeLab.font = commenAppFont(13);
    self.timeLab.textAlignment = NSTextAlignmentRight;

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
