//
//  BookListTableViewCell.m
//  wat
//
//  Created by 123 on 2018/6/13.
//  Copyright © 2018年 wat0801. All rights reserved.
//

#import "BookListTableViewCell.h"

@implementation BookListTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    self.imgView.frame = CGRectMake(15, 20, 120, 160);
    self.imgView.layer.cornerRadius = 5;
    self.imgView.layer.shadowColor=[UIColor blackColor].CGColor;
    self.imgView.layer.shadowOffset=CGSizeMake(1, 1);
    self.imgView.layer.shadowOpacity=0.8;
    self.imgView.layer.shadowRadius= 10;
    
    self.titleLab.frame = CGRectMake(self.imgView.frame.size.width + self.imgView.frame.origin.x
                                     + 10, 20, MyKScreenWidth - 15 - 15 - 10 - self.imgView.frame.size.width, 30);
    self.titleLab.font = commenAppFont(20);
    self.titleLab.textColor = [UIColor blackColor];
    self.titleLab.numberOfLines = 2;
    [self.titleLab sizeToFit];
    
    self.typeLab.frame = CGRectMake(self.titleLab.frame.origin.x, self.titleLab.frame.size.height + self.titleLab.frame.origin.y + 5, 35, 16);
    self.typeLab.backgroundColor = CommonAppColor;
    self.typeLab.textColor = [UIColor whiteColor];
    self.typeLab.font = commenAppFont(11);
    self.typeLab.textAlignment = NSTextAlignmentCenter;
    
    
    self.moneyLab.frame = CGRectMake(self.typeLab.frame.size.width + self.typeLab.frame.origin.x + 10, self.titleLab.frame.size.height + self.titleLab.frame.origin.y + 5, 35, 16);
    self.moneyLab.textColor = CommonAppColor;
    self.moneyLab.font = commenAppFont(11);
    self.moneyLab.textAlignment = NSTextAlignmentLeft;
    [self.moneyLab sizeToFit];
    
    self.subTitleLab.frame = CGRectMake(self.titleLab.frame.origin.x, self.typeLab.frame.origin.y + self.typeLab.frame.size.height + 15, MyKScreenWidth - 15 - 15 - 10 - self.imgView.frame.size.width, 100);
    self.subTitleLab.font = commenAppFont(12);
    self.subTitleLab.textColor = [UIColor grayColor];
    self.subTitleLab.numberOfLines = 4;
    self.subTitleLab.textAlignment = NSTextAlignmentLeft;
    [self.subTitleLab sizeToFit];
    
    self.goBtn.frame = CGRectMake(MyKScreenWidth - 80, self.subTitleLab.frame.origin.y + self.subTitleLab.frame.size.height + 5, 60, 20);
    self.goBtn.backgroundColor =CommonAppColor;
    [self.goBtn setTitle:@"去购买" forState: UIControlStateNormal];
    [self.goBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.goBtn.titleLabel.font = commenAppFont(14);
    self.goBtn.layer.cornerRadius = 3;
    
    UIView *fenggeView = [[UIView alloc]initWithFrame:CGRectMake(0, 192, MyKScreenWidth, 8)];
    fenggeView.backgroundColor = WatBackColor;
    [self addSubview:fenggeView];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
