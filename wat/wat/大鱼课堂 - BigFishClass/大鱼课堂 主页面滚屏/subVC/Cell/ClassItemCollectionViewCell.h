//
//  ClassItemCollectionViewCell.h
//  wat
//
//  Created by 123 on 2018/5/31.
//  Copyright © 2018年 wat0801. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ClassItemCollectionViewCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *imgView;
@property (weak, nonatomic) IBOutlet UILabel *titleLab;
@property (weak, nonatomic) IBOutlet UIView *blackBGView;
@property (weak, nonatomic) IBOutlet UILabel *moneyLab;
@property (weak, nonatomic) IBOutlet UILabel *tagLab;

@end
