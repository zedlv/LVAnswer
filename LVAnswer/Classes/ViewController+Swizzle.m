//
//  ViewController+Swizzle.m
//  Swizzle
//
//  Created by lvAsia on 2020/3/22.
//  Copyright © 2020 yazhou lv. All rights reserved.
//

#import "ViewController+Swizzle.h"
#import "ViewController.h"
#import <objc/runtime.h>

IMP (*old_MM)(id self,SEL _cmd);
@implementation ViewController (Swizzle)

+ (void)load{
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        Method old_M = class_getInstanceMethod(self, @selector(oldTest));
        Method new_M = class_getInstanceMethod(self, @selector(newTest));
//
//        method_exchangeImplementations(new_M, old_M);
        
        
        old_MM = class_getMethodImplementation(self, @selector(oldTest));
        method_setImplementation(old_M, class_getMethodImplementation(self, @selector(newTest)));
        method_setImplementation(new_M, old_MM);
    });
}
@end
