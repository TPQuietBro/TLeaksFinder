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
@property(assign,nonatomic) NSInteger pingCount;
@end
@implementation ObjectLeakDetector
- (void)sendLeakDetectedNotifacation:(NSObject *)detector{
    self.weakTarget = detector;
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"ping" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(ping:) name:@"ping" object:nil];
}
- (void)ping:(NSNotification *)noti{
    //NSLog(@"在发送pong");
    //这里目的只是为了只执行一次
    if (_pingCount > 3) {
        return;
    }
    if (!self.weakTarget) {
        return;
    }
    
    //如果当前控制器还在屏幕显示就停止
    if (![self.weakTarget isOnScreen]) {
        _pingCount ++;
    }
    //这里不立马就发送,延迟一会儿弹出
    if (_pingCount > 3) {
        [[NSNotificationCenter defaultCenter] postNotificationName:@"pong" object:self.weakTarget];
        
    }

}
- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"ping" object:nil];
}
@end
