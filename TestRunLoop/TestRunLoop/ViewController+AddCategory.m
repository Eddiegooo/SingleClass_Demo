//
//  ViewController+AddCategory.m
//  TestRunLoop
//
//  Created by FQL on 2017/9/16.
//  Copyright © 2017年 FQL. All rights reserved.
//

#import "ViewController+AddCategory.h"
#import <objc/runtime.h>

static NSString *key = @"key";

@implementation ViewController (AddCategory)

+(void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
//        Class class = [self class];
//        Method origianlMethod = class_getInstanceMethod(class, @selector(viewWillAppear:));
//        Method swizzlingMethod = class_getInstanceMethod(class, @selector(swizzlingViewWillAppear:));
//        BOOL didAddMethod = class_addMethod(class, @selector(viewWillAppear:), method_getImplementation(swizzlingMethod), method_copyReturnType(swizzlingMethod));
//        
//        if (didAddMethod) {
//            class_replaceMethod(class, @selector(swizzlingViewWillAppear:), method_getImplementation(originalMethod), method_copyReturnType(originalMethod));
//        } else {
//            method_exchangeImplementations(originalMethod, swizzlingMethod);
//        }
        
        
        /*!
         *  @brief 类方法这么改写
         */
        Class class = object_getClass(self);
        SEL originalSelector = @selector(someClassMethod);
        SEL swizzlingSelector = @selector(customDescription);
        
        Method originalMethod = class_getClassMethod(class, originalSelector);
        Method swizzlingMethod = class_getClassMethod(class, swizzlingSelector);
        
        
        BOOL changeMethod = class_addMethod(class, originalSelector, method_getImplementation(originalMethod), method_copyReturnType(originalMethod));
        
        if (changeMethod) {
            class_replaceMethod(class, swizzlingSelector, method_getImplementation(swizzlingMethod), method_copyReturnType(swizzlingMethod));
        }else {
            method_exchangeImplementations(originalMethod, swizzlingMethod);
        }
    });
}


- (void)swizzlingViewWillAppear:(BOOL)animate {
    [self swizzlingViewWillAppear:animate];
    NSLog(@"==changeMethod== %@",self);
}


+ (void)customDescription {
    NSLog(@"这里就改写了。。。");
}

- (NSString *)customTitle {
    return objc_getAssociatedObject(self, &key);
}

- (void)setCustomTitle:(NSString *)customTitle {
    objc_setAssociatedObject(self, &key, customTitle, OBJC_ASSOCIATION_COPY);
}


- (void)addMethod {
    NSLog(@"add method");
}

/*!
 *  @brief 随便写在的方法哈（一般在load方法里）   
 */
- (void)viewWillAppear:(BOOL)animated {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        /*!
         *  @brief 实例方法拦截替换方法
         */
        Class class = [self class];
        
        SEL originalSel = @selector(viewWillAppear:);
        SEL customSel   = @selector(customViewWillAppear:);
        /*!
         *  @brief 实例方法拦截替换方法
         */
        Method originalMethod = class_getInstanceMethod(class, originalSel);
        Method customMethod   = class_getInstanceMethod(class, customSel);
        
        BOOL addMethod = class_addMethod(class, originalSel, method_getImplementation(originalMethod), method_copyReturnType(originalMethod));
        if (addMethod) {
            class_replaceMethod(class, customSel, method_getImplementation(customMethod), method_copyReturnType(customMethod));
        }else {
            method_exchangeImplementations(originalMethod, customMethod);
        }
    });
}

- (void)customViewWillAppear:(BOOL)animate {
    NSLog(@"劫持替换方法");
    [self customViewWillAppear:animate];
}

@end
