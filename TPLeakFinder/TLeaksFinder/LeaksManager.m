//
//  LeaksManager.m
//  TPLeakFinder
//
//  Created by tangpeng on 2018/3/28.
//Copyright © 2018年 ICX. All rights reserved.
//

#import "LeaksManager.h"
@interface LeaksManager()
@property(strong,nonatomic) NSTimer *timer;
@end
@implementation LeaksManager

+ (instancetype)shareInstance{
    static LeaksManager *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[self alloc] init];
    });
    return manager;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(pong:) name:@"pong" object:nil];
    }
    return self;
}

- (void)startDetectLeaks{
    if (self.timer) {
        return;
    }
    
    self.timer = [NSTimer scheduledTimerWithTimeInterval:0.5 target:self selector:@selector(sendPing) userInfo:nil repeats:YES];
}

- (void)sendPing
{
    //NSLog(@"在发送ping");
    [[NSNotificationCenter defaultCenter] postNotificationName:@"ping" object:nil];
}

- (void)pong:(NSNotification *)noti{
#if debug
    NSObject *obj = noti.object;
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"TLeaksFinder" message:NSStringFromClass([obj class]) delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    [alert show];
#endif
}
- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"pong" object:nil];
}

@end
