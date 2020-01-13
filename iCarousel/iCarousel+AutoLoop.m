//
//  iCarousel+AutoLoop.m
//  OutdoorAssistantApplication
//
//  Created by wei.feng on 2018/9/17.
//  Copyright © 2018年 Lolaage. All rights reserved.
//

#import "iCarousel+AutoLoop.h"
#import <objc/runtime.h>

@interface iCarousel()

@property (nonatomic, strong) NSTimer *loopTimer;

@end

@implementation iCarousel (AutoLoop)

- (CGFloat)loopAnimateTime
{
    NSNumber *number = objc_getAssociatedObject(self, _cmd);
    return [number floatValue];
}

- (void)setLoopAnimateTime:(CGFloat)loopAnimateTime
{
    objc_setAssociatedObject(self, @selector(loopAnimateTime), @(loopAnimateTime), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (CGFloat)loopWaiteTime
{
    NSNumber *number = objc_getAssociatedObject(self, _cmd);
    return [number floatValue];
}

- (void)setLoopWaiteTime:(CGFloat)loopWaiteTime
{
    objc_setAssociatedObject(self, @selector(loopWaiteTime), @(loopWaiteTime), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSTimer *)loopTimer
{
    NSTimer *timer = objc_getAssociatedObject(self, _cmd);
    if (timer == nil) {
        timer = [NSTimer timerWithTimeInterval:(self.loopAnimateTime + self.loopWaiteTime)
                                        target:self
                                      selector:@selector(loopToNextStep)
                                      userInfo:nil
                                       repeats:YES];
        objc_setAssociatedObject(self, _cmd, timer, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return timer;
}

- (void)loopToNextStep
{
    [self scrollToItemAtIndex:self.currentItemIndex + 1 duration:self.loopAnimateTime];
}

- (void)startLoop
{
    //2019-10-30 lotus add.
    [self stopLoop];
    //end.
    if (self.numberOfItems > 2 && self.loopAnimateTime > FLT_EPSILON && self.loopWaiteTime > FLT_EPSILON) {
        [[NSRunLoop mainRunLoop] addTimer:self.loopTimer forMode:NSRunLoopCommonModes];
    }
}

- (void)stopLoop
{
    NSTimer *timer = objc_getAssociatedObject(self, @selector(loopTimer));
    [timer invalidate];
    objc_setAssociatedObject(self, @selector(loopTimer), nil, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@end
