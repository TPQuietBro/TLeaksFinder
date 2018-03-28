//
//  UIViewController+Leaks.m
//  TPLeakFinder
//
//  Created by 唐鹏 on 2018/3/28.
//  Copyright © 2018年 ICX. All rights reserved.
//

#import "UIViewController+Leaks.h"
#import "NSObject+Swizzling.h"
#import <objc/message.h>
@implementation UIViewController (Leaks)
+ (void)load{
    [self swizzleSEL:@selector(viewDidAppear:) withSEL:@selector(t_viewDidAppear:)];
    [self swizzleSEL:@selector(presentViewController:animated:completion:) withSEL:@selector(t_presentViewController:animated:completion:)];
}

- (void)t_viewDidAppear:(BOOL)animated{
    //[self markObject];
}
- (void)t_presentViewController:(UIViewController *)viewControllerToPresent animated:(BOOL)flag completion:(void (^)(void))completion{
    [self t_presentViewController:viewControllerToPresent animated:flag completion:completion];
    [viewControllerToPresent markObject];
}
//如果当前controller还在屏幕上
- (BOOL)isOnScreen{
    BOOL alive = true;
    
    BOOL visibleOnScreen = false;
    
    UIView* v = self.view;
    while (v.superview != nil) {
        v = v.superview;
    }
    if ([v isKindOfClass:[UIWindow class]]) {
        visibleOnScreen = true;
    }
    
    
    BOOL beingHeld = false;
    if (self.navigationController != nil || self.presentingViewController != nil) {
        beingHeld = true;
    }
    
    //not visible, not in view stack
    if (visibleOnScreen == false && beingHeld == false) {
        alive = false;
    }
    
    return alive;
}

@end
