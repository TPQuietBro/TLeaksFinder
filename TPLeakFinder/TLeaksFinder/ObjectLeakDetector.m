//
//  ObjectLeakDetector.m
//  TPLeakFinder
//
//  Created by tangpeng on 2018/3/28.
//Copyright © 2018年 ICX. All rights reserved.
//

#import "ObjectLeakDetector.h"
#import "NSObject+Swizzling.h"
@interface ObjectLeakDetector()
@property(assign,nonatomic) NSInteger failedCount;
@end
@implementation ObjectLeakDetector
- (void)sendLeakDetectedNotifacation:(NSObject *)detector{
    self.weakTarget = detector;
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"ping" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(ping:) name:@"ping" object:nil];
}
- (void)ping:(NSNotification *)noti{
    //NSLog(@"在发送pong");
    if (_failedCount > 3) {
        return;
    }
    if (!self.weakTarget) {
        return;
    }
    
    //如果当前控制器还在屏幕显示就停止
    if (![self.weakTarget isOnScreen]) {
        _failedCount ++;
    }
    if (_failedCount > 3) {
        [[NSNotificationCenter defaultCenter] postNotificationName:@"pong" object:self.weakTarget];
        
    }

}
- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"ping" object:nil];
}
@end
