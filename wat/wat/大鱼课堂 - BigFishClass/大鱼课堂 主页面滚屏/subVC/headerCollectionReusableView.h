//
//  headerCollectionReusableView.h
//  wat
//
//  Created by 123 on 2018/5/31.
//  Copyright © 2018年 wat0801. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface headerCollectionReusableView : UICollectionReusableView

/**
 *  声明相应的数据模型属性,进行赋值操作,获取头视图或尾视图需要的数据.或者提供一个方法获取需要的数据.
 */

-(void)getSHCollectionReusableViewHearderTitle:(NSString *)title;
@end
