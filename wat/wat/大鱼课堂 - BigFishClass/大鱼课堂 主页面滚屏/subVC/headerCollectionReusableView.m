//
//  headerCollectionReusableView.m
//  wat
//
//  Created by 123 on 2018/5/31.
//  Copyright © 2018年 wat0801. All rights reserved.
//

#import "headerCollectionReusableView.h"


@interface headerCollectionReusableView(){
    
    UILabel *titleLabel;
}
@end
@implementation headerCollectionReusableView
-(id)initWithFrame:(CGRect)frame{
    
    self=[super initWithFrame:frame];
    
    if (self) {
        
        self.backgroundColor=[UIColor greenColor];
        [self createBasicView];
    }
    return self;
    
}

/**
 *  进行基本布局操作,根据需求进行.
 */
-(void)createBasicView{
    
    
//    titleLabel=[LSHControl createLabelWithFrame:CGRectMake(5, 0,self.frame.size.width-50, self.frame.size.height) Font:[UIFont systemFontOfSize:14.0] Text:@"" color:[UIColor grayColor]];
    titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(5, 0, MyKScreenWidth - 50, MyKScreenHeight)];
    titleLabel.font = commenAppFont(14);
    titleLabel.text = @"";
    titleLabel.textColor = [UIColor redColor];
    [self addSubview:titleLabel];
    
    
}


/**
 *  设置相应的数据
 *
 *  @param title
 */
-(void)getSHCollectionReusableViewHearderTitle:(NSString *)title{
    
    titleLabel.text=title;
    
}

@end
