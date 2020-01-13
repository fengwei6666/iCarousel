//
//  iCarousel+AutoLoop.h
//  OutdoorAssistantApplication
//
//  Created by wei.feng on 2018/9/17.
//  Copyright © 2018年 Lolaage. All rights reserved.
//

#import "iCarousel.h"

//添加自动轮播功能
@interface iCarousel (AutoLoop)

@property (nonatomic) CGFloat loopAnimateTime;//单次轮播的时间
@property (nonatomic) CGFloat loopWaiteTime;//每次轮播之间等待的时间

- (void)startLoop;
- (void)stopLoop;

@end
