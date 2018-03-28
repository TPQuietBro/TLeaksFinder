//
//  ViewController.m
//  TPLeakFinder
//
//  Created by 唐鹏 on 2018/3/28.
//  Copyright © 2018年 ICX. All rights reserved.
//

#import "ViewController.h"
#import "TLeakBeginViewController.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self presentViewController:[TLeakBeginViewController new] animated:YES completion:nil];
}

@end
