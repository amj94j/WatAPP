//
//  ZWHCountingLabel.m
//  wat
//
//  Created by 123 on 2018/6/8.
//  Copyright © 2018年 wat0801. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>

#import "ZWHCountingLabel.h"

#if !__has_feature(objc_arc)
#error UICountingLabel is ARC only. Either turn on ARC for the project or use -fobjc-arc flag
#endif

#pragma mark - UILabelCounter

#ifndef kUILabelCounterRate
#define kUILabelCounterRate 3.0
#endif

@protocol ZWHLabelCounter<NSObject>

-(CGFloat)update:(CGFloat)t;

@end

@interface ZWHLabelCounterLinear : NSObject<ZWHLabelCounter>

@end

@interface ZWHLabelCounterEaseIn : NSObject<ZWHLabelCounter>

@end

@interface ZWHLabelCounterEaseOut : NSObject<ZWHLabelCounter>

@end

@interface ZWHLabelCounterEaseInOut : NSObject<ZWHLabelCounter>

@end

@interface ZWHLabelCounterEaseInBounce : NSObject<ZWHLabelCounter>

@end

@interface ZWHLabelCounterEaseOutBounce : NSObject<ZWHLabelCounter>

@end

@implementation ZWHLabelCounterLinear

-(CGFloat)update:(CGFloat)t
{
    return t;
}

@end

@implementation ZWHLabelCounterEaseIn

-(CGFloat)update:(CGFloat)t
{
    return powf(t, kUILabelCounterRate);
}

@end

@implementation ZWHLabelCounterEaseOut

-(CGFloat)update:(CGFloat)t{
    return 1.0-powf((1.0-t), kUILabelCounterRate);
}

@end

@implementation ZWHLabelCounterEaseInOut

-(CGFloat) update: (CGFloat) t
{
    t *= 2;
    if (t < 1)
        return 0.5f * powf (t, kUILabelCounterRate);
    else
        return 0.5f * (2.0f - powf(2.0 - t, kUILabelCounterRate));
}

@end

@implementation ZWHLabelCounterEaseInBounce

-(CGFloat) update: (CGFloat) t {
    
    if (t < 4.0 / 11.0) {
        return 1.0 - (powf(11.0 / 4.0, 2) * powf(t, 2)) - t;
    }
    
    if (t < 8.0 / 11.0) {
        return 1.0 - (3.0 / 4.0 + powf(11.0 / 4.0, 2) * powf(t - 6.0 / 11.0, 2)) - t;
    }
    
    if (t < 10.0 / 11.0) {
        return 1.0 - (15.0 /16.0 + powf(11.0 / 4.0, 2) * powf(t - 9.0 / 11.0, 2)) - t;
    }
    
    return 1.0 - (63.0 / 64.0 + powf(11.0 / 4.0, 2) * powf(t - 21.0 / 22.0, 2)) - t;
    
}

@end

@implementation ZWHLabelCounterEaseOutBounce

-(CGFloat) update: (CGFloat) t {
    
    if (t < 4.0 / 11.0) {
        return powf(11.0 / 4.0, 2) * powf(t, 2);
    }
    
    if (t < 8.0 / 11.0) {
        return 3.0 / 4.0 + powf(11.0 / 4.0, 2) * powf(t - 6.0 / 11.0, 2);
    }
    
    if (t < 10.0 / 11.0) {
        return 15.0 /16.0 + powf(11.0 / 4.0, 2) * powf(t - 9.0 / 11.0, 2);
    }
    
    return 63.0 / 64.0 + powf(11.0 / 4.0, 2) * powf(t - 21.0 / 22.0, 2);
    
}

@end

#pragma mark - ZWHCountingLabel

@interface ZWHCountingLabel ()

@property CGFloat startingValue;
@property CGFloat destinationValue;
@property NSTimeInterval progress;
@property NSTimeInterval lastUpdate;
@property NSTimeInterval totalTime;
@property CGFloat easingRate;

@property (nonatomic, strong) CADisplayLink *timer;
@property (nonatomic, strong) id<ZWHLabelCounter> counter;

@end

@implementation ZWHCountingLabel

-(void)countFrom:(CGFloat)value to:(CGFloat)endValue {
    
    if (self.animationDuration == 0.0f) {
        self.animationDuration = 2.0f;
    }
    
    [self countFrom:value to:endValue withDuration:self.animationDuration];
}

-(void)countFrom:(CGFloat)startValue to:(CGFloat)endValue withDuration:(NSTimeInterval)duration {
    
    self.startingValue = startValue;
    self.destinationValue = endValue;
    
    // remove any (possible) old timers
    [self.timer invalidate];
    self.timer = nil;
    
    if(self.format == nil) {
        self.format = @"%f";
    }
    if (duration == 0.0) {
        // No animation
        [self setTextValue:endValue];
        [self runCompletionBlock];
        return;
    }
    
    self.easingRate = 3.0f;
    self.progress = 0;
    self.totalTime = duration;
    self.lastUpdate = [NSDate timeIntervalSinceReferenceDate];
    
    switch(self.method)
    {
        case ZWHLabelCountingMethodLinear:
            self.counter = [[ZWHLabelCounterLinear alloc] init];
            break;
        case ZWHLabelCountingMethodEaseIn:
            self.counter = [[ZWHLabelCounterEaseIn alloc] init];
            break;
        case ZWHLabelCountingMethodEaseOut:
            self.counter = [[ZWHLabelCounterEaseOut alloc] init];
            break;
        case ZWHLabelCountingMethodEaseInOut:
            self.counter = [[ZWHLabelCounterEaseInOut alloc] init];
            break;
        case ZWHLabelCountingMethodEaseOutBounce:
            self.counter = [[ZWHLabelCounterEaseOutBounce alloc] init];
            break;
        case ZWHLabelCountingMethodEaseInBounce:
            self.counter = [[ZWHLabelCounterEaseInBounce alloc] init];
            break;
    }
    
    CADisplayLink *timer = [CADisplayLink displayLinkWithTarget:self selector:@selector(updateValue:)];
    timer.frameInterval = 2;
    [timer addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSDefaultRunLoopMode];
    [timer addToRunLoop:[NSRunLoop mainRunLoop] forMode:UITrackingRunLoopMode];
    self.timer = timer;
}

- (void)countFromCurrentValueTo:(CGFloat)endValue {
    [self countFrom:[self currentValue] to:endValue];
}

- (void)countFromCurrentValueTo:(CGFloat)endValue withDuration:(NSTimeInterval)duration {
    [self countFrom:[self currentValue] to:endValue withDuration:duration];
}

- (void)countFromZeroTo:(CGFloat)endValue {
    [self countFrom:0.0f to:endValue];
}

- (void)countFromZeroTo:(CGFloat)endValue withDuration:(NSTimeInterval)duration {
    [self countFrom:0.0f to:endValue withDuration:duration];
}

- (void)updateValue:(NSTimer *)timer {
    
    // update progress
    NSTimeInterval now = [NSDate timeIntervalSinceReferenceDate];
    self.progress += now - self.lastUpdate;
    self.lastUpdate = now;
    
    if (self.progress >= self.totalTime) {
        [self.timer invalidate];
        self.timer = nil;
        self.progress = self.totalTime;
    }
    
    [self setTextValue:[self currentValue]];
    
    if (self.progress == self.totalTime) {
        [self runCompletionBlock];
    }
}

- (void)setTextValue:(CGFloat)value
{
    if (self.attributedFormatBlock != nil) {
        self.attributedText = self.attributedFormatBlock(value);
    }
    else if(self.formatBlock != nil)
    {
        self.text = self.formatBlock(value);
    }
    else
    {
        // check if counting with ints - cast to int
        if([self.format rangeOfString:@"%(.*)d" options:NSRegularExpressionSearch].location != NSNotFound || [self.format rangeOfString:@"%(.*)i"].location != NSNotFound )
        {
            self.text = [NSString stringWithFormat:self.format,(int)value];
        }
        else
        {
            if (self.positiveFormat.length > 0) {//带千分位分隔符样式
                NSString *str = [NSString stringWithFormat:self.format, value];
                NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
                formatter.numberStyle = NSNumberFormatterDecimalStyle;
                [formatter setPositiveFormat:self.positiveFormat];
                self.text = [NSString stringWithFormat:@"%@",[formatter stringFromNumber:[NSNumber numberWithFloat:[str floatValue]]]];
                
            } else {
                self.text = [NSString stringWithFormat:self.format,value];
            }  
            
        }
    }
}

- (void)setFormat:(NSString *)format {
    _format = format;
    // update label with new format
    [self setTextValue:self.currentValue];
}

- (void)runCompletionBlock {
    
    if (self.completionBlock) {
        self.completionBlock();
        self.completionBlock = nil;
    }
}

- (CGFloat)currentValue {
    
    if (self.progress >= self.totalTime) {
        return self.destinationValue;
    }
    
    CGFloat percent = self.progress / self.totalTime;
    CGFloat updateVal = [self.counter update:percent];
    return self.startingValue + (updateVal * (self.destinationValue - self.startingValue));
}

@end
