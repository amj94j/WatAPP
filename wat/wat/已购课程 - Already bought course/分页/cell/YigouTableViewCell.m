//
//  YigouTableViewCell.m
//  wat
//
//  Created by 123 on 2018/5/30.
//  Copyright © 2018年 wat0801. All rights reserved.
//

#import "YigouTableViewCell.h"

@implementation YigouTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
   
    self.imgView.frame =CGRectMake(13, 12, 76, 59);
    
    self.titleLab.frame = CGRectMake(self.imgView.frame.origin.x + self.imgView.frame.size.width + 22, self.imgView.frame.origin.y, MyKScreenWidth - self.titleLab.frame.origin.x - 30, 20);
    self.titleLab.font = commenAppFont(13);
    self.titleLab.textColor = [UIColor blackColor];
    
    self.goBtn.frame = CGRectMake(MyKScreenWidth - 60 - 13, 81 - 24, 60, 20);
    self.goBtn.titleLabel.font = commenAppFont(12);
    self.goBtn.layer.cornerRadius = 2.0;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
