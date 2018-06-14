//
//  ClassListTableViewCell.m
//  wat
//
//  Created by 123 on 2018/6/13.
//  Copyright © 2018年 wat0801. All rights reserved.
//

#import "ClassListTableViewCell.h"

@implementation ClassListTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    self.backgroundColor = WatBackColor;
    self.bgView.frame = CGRectMake(10, 10, MyKScreenWidth - 20, 360 - 20);
    self.bgView.backgroundColor = [UIColor whiteColor];
    self.bgView.layer.cornerRadius = 10;
    
    self.imgView.frame = CGRectMake(10, 10, self.bgView.frame.size.width - 20, 160);
    self.imgView.contentMode = 2;
    self.imgView.layer.cornerRadius = 10;
    
    self.titleLab.frame = CGRectMake(10, self.imgView.frame.size.height
                                      + self.imgView.frame.origin.y +10,self.bgView.frame.size.width - 20, 30);
    self.titleLab.font = commenAppFont(20);
    self.titleLab.text = @"北京:决战门店3公里  利润倍增特训营|第三期";
    self.titleLab.textColor = [UIColor blackColor];
    self.titleLab.numberOfLines = 2;
    
    [self.titleLab sizeToFit];
    
    self.subTitleLab.frame = CGRectMake(10, self.titleLab.frame.size.height + self.titleLab.frame.origin.y + 5, self.bgView.frame.size.width - 20, 30);
    self.subTitleLab.font = commenAppFont(14);
    self.subTitleLab.text = @"<中国餐饮报告2018>显示,日料韩料在去年不再高歌猛进,原因之一就是过...";
    self.subTitleLab.textColor = [UIColor grayColor];
    self.subTitleLab.numberOfLines = 2;
    [self.subTitleLab sizeToFit];
    
    self.timeLab.frame = CGRectMake(10, self.subTitleLab.frame.origin.y + self.subTitleLab.frame.size.height + 5, 200, 10);
    self.timeLab.font = commenAppFont(10);
    self.timeLab.text = @"时间:6月8日 - 7月9日";
    self.timeLab.textColor =CommonAppColor;
    self.timeLab.numberOfLines = 1;
    [self.timeLab sizeToFit];
    
    self.addressLab.frame = CGRectMake(10, self.timeLab.frame.origin.y + self.timeLab.frame.size.height + 5, 200, 10);
    self.addressLab.font = commenAppFont(10);
    self.addressLab.text = @"地点:北京";
    self.addressLab.textColor =CommonAppColor;
    self.addressLab.numberOfLines = 1;
    [self.addressLab sizeToFit];
    
    self.goBtn.frame = CGRectMake(self.bgView.frame.size.width - 70, self.timeLab.frame.origin.y, 60, 20);
    self.goBtn.backgroundColor =CommonAppColor;
    [self.goBtn setTitle:@"去报名" forState: UIControlStateNormal];
    [self.goBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
