//
//  ZWHCountingLabel.h
//  wat
//
//  Created by 123 on 2018/6/8.
//  Copyright © 2018年 wat0801. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, UILabelCountingMethod) {
    ZWHLabelCountingMethodEaseInOut,
    ZWHLabelCountingMethodEaseIn,
    ZWHLabelCountingMethodEaseOut,
    ZWHLabelCountingMethodLinear,
    ZWHLabelCountingMethodEaseInBounce,
    ZWHLabelCountingMethodEaseOutBounce
};

typedef NSString* (^ZWHCountingLabelFormatBlock)(CGFloat value);
typedef NSAttributedString* (^ZWHCountingLabelAttributedFormatBlock)(CGFloat value);

@interface ZWHCountingLabel : UILabel

@property (nonatomic, strong) NSString *format;
@property (nonatomic, strong) NSString *positiveFormat;//如果浮点数需要千分位分隔符,须使用@"###,##0.00"进行控制样式
@property (nonatomic, assign) UILabelCountingMethod method;
@property (nonatomic, assign) NSTimeInterval animationDuration;

@property (nonatomic, copy) ZWHCountingLabelFormatBlock formatBlock;
@property (nonatomic, copy) ZWHCountingLabelAttributedFormatBlock attributedFormatBlock;
@property (nonatomic, copy) void (^completionBlock)(void);

-(void)countFrom:(CGFloat)startValue to:(CGFloat)endValue;
-(void)countFrom:(CGFloat)startValue to:(CGFloat)endValue withDuration:(NSTimeInterval)duration;

-(void)countFromCurrentValueTo:(CGFloat)endValue;
-(void)countFromCurrentValueTo:(CGFloat)endValue withDuration:(NSTimeInterval)duration;

-(void)countFromZeroTo:(CGFloat)endValue;
-(void)countFromZeroTo:(CGFloat)endValue withDuration:(NSTimeInterval)duration;

- (CGFloat)currentValue;

@end
