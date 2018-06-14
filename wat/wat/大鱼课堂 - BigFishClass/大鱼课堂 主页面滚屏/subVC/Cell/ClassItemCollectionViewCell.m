//
//  ClassItemCollectionViewCell.m
//  wat
//
//  Created by 123 on 2018/5/31.
//  Copyright © 2018年 wat0801. All rights reserved.
//

#import "ClassItemCollectionViewCell.h"



@implementation ClassItemCollectionViewCell



- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code

    
  
}

- (void)layoutSubviews {
    
    [super layoutSubviews];
    self.imgView.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height - 44);
    self.imgView.layer.cornerRadius = 4.0;
    self.imgView.contentMode = 2;
    self.imgView.layer.masksToBounds = YES;
    
    self.titleLab.frame = CGRectMake(0, self.imgView.frame.size.height + 6, self.frame.size.width, 30);
    self.titleLab.font = commenAppFont(12);
    self.titleLab.textColor = [UIColor blackColor];
    //self.titleLab.lineBreakMode = NSLineBreakByTruncatingTail;
    self.titleLab.numberOfLines = 2;
    
    self.blackBGView.frame = CGRectMake(0, self.imgView.frame.size.height - 20, self.frame.size.width, 20);
    
    self.blackBGView.hidden = YES;
    self.moneyLab.hidden  = YES;
    self.tagLab.hidden = YES;
//    self.blackBGView.backgroundColor = [UIColor blackColor];
//    self.blackBGView.alpha = 0.6;
//
//    self.moneyLab.frame = CGRectMake(0, 0, 40, 20);
//    self.moneyLab.textColor = [UIColor whiteColor];
//
//    self.tagLab.frame = CGRectMake(self.frame.size.width - 40, 0, 35, 20);
//    self.tagLab.backgroundColor = [UIColor redColor];
//    self.tagLab.textColor = [UIColor whiteColor];
    
    
    
}

@end
