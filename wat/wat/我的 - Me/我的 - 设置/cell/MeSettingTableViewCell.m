//
//  MeSettingTableViewCell.m
//  wat
//
//  Created by 123 on 2018/6/11.
//  Copyright © 2018年 wat0801. All rights reserved.
//

#import "MeSettingTableViewCell.h"



@implementation MeSettingTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.cellNameLab.hidden = YES;
    self.cellNameLab.frame = CGRectMake(15, 0, MyKScreenWidth, self.frame.size.height);
    self.cellNameLab.font = commenAppFont(15);
    self.cellNameLab.textAlignment = NSTextAlignmentLeft;
    
    self.cellrightBtn.hidden = YES;
    self.cellrightBtn.frame = CGRectMake(MyKScreenWidth - 50, (self.frame.size.height - 40) / 2, 40, 40);
    [self.cellrightBtn setImage:[UIImage imageNamed:@"1234567890"] forState:UIControlStateNormal];
    self.cellrightBtn.imageView.contentMode = 2;
    //self.cellrightBtn.layer.cornerRadius = 20;
    self.cellrightBtn.layer.masksToBounds = YES;
    
    self.cellRightTextField.hidden = YES;
    self.cellRightTextField.frame = CGRectMake(100, 0, MyKScreenWidth - 100 -10, 44);
    //self.cellRightTextField.placeholder = @"测试数据是测试发生纠纷";
    self.cellRightTextField.textAlignment = NSTextAlignmentRight;
    self.cellRightTextField.borderStyle = UITextBorderStyleNone;
    self.cellRightTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.cellRightTextField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
