//
//  ClassListTableViewCell.h
//  wat
//
//  Created by 123 on 2018/6/13.
//  Copyright © 2018年 wat0801. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ClassListTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIView *bgView;
@property (weak, nonatomic) IBOutlet UIImageView *imgView;
@property (weak, nonatomic) IBOutlet UILabel *titleLab;
@property (weak, nonatomic) IBOutlet UILabel *subTitleLab;
@property (weak, nonatomic) IBOutlet UILabel *timeLab;
@property (weak, nonatomic) IBOutlet UILabel *addressLab;
@property (weak, nonatomic) IBOutlet UIButton *goBtn;

@end
