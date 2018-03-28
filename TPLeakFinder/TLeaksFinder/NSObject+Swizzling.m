//
//  NSObject+Swizzling.m
//  TPLeakFinder
//
//  Created by 唐鹏 on 2018/3/28.
//  Copyright © 2018年 ICX. All rights reserved.
//

#import "NSObject+Swizzling.h"
#import <objc/message.h>
@implementation NSObject (Swizzling)
+ (void)swizzleSEL:(SEL)originalSEL withSEL:(SEL)swizzledSEL
{
    Class class = [self class];
    
    Method originalMethod = class_getInstanceMethod(class, originalSEL);
    Method swizzledMethod = class_getInstanceMethod(class, swizzledSEL);
    
    BOOL didAddMethod =
    class_addMethod(class,
                    originalSEL,
                    method_getImplementation(swizzledMethod),
                    method_getTypeEncoding(swizzledMethod));
    
    if (didAddMethod) {
        class_replaceMethod(class,
                            swizzledSEL,
                            method_getImplementation(originalMethod),
                            method_getTypeEncoding(originalMethod));
    }
    else
    {
        method_exchangeImplementations(originalMethod, swizzledMethod);
    }
}

- (void)setDetector:(ObjectLeakDetector *)detector{
    objc_setAssociatedObject(self, @selector(detector), detector, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (ObjectLeakDetector *)detector{
    return objc_getAssociatedObject(self, @selector(detector));
}
//给 当前类 添加 detector,并且开启监测
- (void)markObject{
    
    if (self.detector) {
        return;
    }
    
    //skip system class
    NSString* className = NSStringFromClass([self class]);
    if ([className hasPrefix:@"_"] || [className hasPrefix:@"UI"] || [className hasPrefix:@"NS"]) {
        return;
    }
    
    //view object needs a super view to be alive
    if ([self isKindOfClass:[UIView class]]) {
        UIView* v = (UIView*)self;
        if (v.superview == nil) {
            return;
        }
    }
    
    //controller object needs a parent to be alive
    if ([self isKindOfClass:[UIViewController class]]) {
        UIViewController* c = (UIViewController*)self;
        if (c.navigationController == nil && c.presentingViewController == nil) {
            return;
        }
    }
    
    ObjectLeakDetector *dec = [[ObjectLeakDetector alloc] init];
    self.detector = dec;
    [dec sendLeakDetectedNotifacation:self];
}



@end
