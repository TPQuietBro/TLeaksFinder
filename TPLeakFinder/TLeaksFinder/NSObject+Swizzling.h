//
//  NSObject+Swizzling.h
//  TPLeakFinder
//
//  Created by 唐鹏 on 2018/3/28.
//  Copyright © 2018年 ICX. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ObjectLeakDetector.h"
@protocol ObjectDelegate<NSObject>
@optional
- (BOOL)isOnScreen;
@end
@interface NSObject (Swizzling)<ObjectDelegate>
+ (void)swizzleSEL:(SEL)originalSEL withSEL:(SEL)swizzledSEL;
- (void)markObject;
@property(strong,nonatomic) ObjectLeakDetector *detector;

@end
