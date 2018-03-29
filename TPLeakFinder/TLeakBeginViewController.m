//
//  TLeakBeginViewController.m
//  TPLeakFinder
//
//  Created by tangpeng on 2018/3/28.
//Copyright © 2018年 ICX. All rights reserved.
//

#import "TLeakBeginViewController.h"

@interface TLeakBeginViewController ()
@property(strong,nonatomic) NSTimer *timer;
@property(assign,nonatomic) NSInteger index;
@property(strong,nonatomic) void(^block)(void);
@end

@implementation TLeakBeginViewController
#pragma mark - life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor redColor];
    [self initSubviews];
}
#pragma mark - init methods

- (void)initSubviews{
//    self.timer = [NSTimer scheduledTimerWithTimeInterval:0.5 target:self selector:@selector(test) userInfo:nil repeats:true];
    self.block = ^{
        self.index = 5;
    };
}
- (void)test{
    NSLog(@"timer is still alive");
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}

#pragma mark - system delegate

#pragma mark - custom delegate

#pragma mark - api methods

#pragma mark - event response

#pragma mark - private

#pragma mark - getter / setter


@end
