//
//  ObjectLeakDetector.h
//  TPLeakFinder
//
//  Created by tangpeng on 2018/3/28.
//Copyright © 2018年 ICX. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ObjectLeakDetector : NSObject
@property(weak,nonatomic) NSObject *weakTarget;
- (void)sendLeakDetectedNotifacation:(NSObject *)detector;
@end
