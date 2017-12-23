//
//  UIViewController+CustomVCMethod.m
//  TestRunLoop
//
//  Created by FQL on 2017/9/15.
//  Copyright © 2017年 FQL. All rights reserved.
//

#import "UIViewController+CustomVCMethod.h"
#import <objc/runtime.h>

/*!
 *  @brief 定义key 这三种方式都可以
 //利用静态变量地址唯一不变的特性
 1、static void *strKey = &strKey;
 2、static NSString *strKey = @"strKey";
 3、static char strKey;
 */


//static void *addStringKey = &addStringKey;
//static NSString *addStringKey = @"addStringKey";
static char addStringKey;

static NSString *myKey = @"myKey";

@implementation UIViewController (CustomVCMethod)

+(void)load {
    // 这里不应该调用super，会导致父类被重复Swizzling
//    [super load];
    
    
    /*!
     *  @brief 加这个保证一次执行，有时候可能执行多次出错。
     */
//    static dispatch_once_t onceToken;
//    dispatch_once(&onceToken, ^{
//        Method fromMethod = class_getInstanceMethod(objc_getClass("__NSArrayM"), @selector(objectAtIndex:));
//        Method toMethod = class_getInstanceMethod(objc_getClass("__NSArrayM"), @selector(lxz_objectAtIndexM:));
//        method_exchangeImplementations(fromMethod, toMethod);
//    });

    
    Method fromMethod = class_getInstanceMethod([self class], @selector(viewDidLoad));
    Method toMethod = class_getInstanceMethod([self class], @selector(customViewDidLoad));
    /**
     *  我们在这里使用class_addMethod()函数对Method Swizzling做了一层验证，如果self没有实现被交换的方法，会导致失败。
     *  而且self没有交换的方法实现，但是父类有这个方法，这样就会调用父类的方法，结果就不是我们想要的结果了。
     *  所以我们在这里通过class_addMethod()的验证，如果self实现了这个方法，class_addMethod()函数将会返回NO，我们就可以对其进行交换了。
     */
    if (!class_addMethod([self class], @selector(customViewDidLoad), method_getImplementation(toMethod), method_getTypeEncoding(toMethod))) {
        //核心方法
        method_exchangeImplementations(fromMethod, toMethod);
    }
    
}


- (void)customViewDidLoad {
    NSLog(@"custom ViewDidLoad");
    
    
    [self.view addSubview:self.hideButton];
    
    self.myString = @"这里加一个有什么用呢";
    NSLog(@"mystring = %@", self.myString);
    
    /*!
     *  @brief 系统调用UIViewController的viewDidLoad方法时，实际上执行的是我们实现的customViewDidLoad方法。
     *  而我们在CustomVCMethod ViewDidLoad方法内部调用[self customViewDidLoad];时，执行的是UIViewController的viewDidLoad方法。
     */
    [self customViewDidLoad];
}

/*!
 *  @brief 给分类添加属性的set get方法
 */

- (void)setMyString:(NSString *)myString {
    objc_setAssociatedObject(self, &myKey, myString, OBJC_ASSOCIATION_COPY);
}

- (NSString *)myString {
    return objc_getAssociatedObject(self, &myKey);
}

/**
 感觉这个方法更巧妙一些，注意第二个参数key。。。这样就不用定义那个不变的key了。。。
*/
//getter
- (UIButton *)hideButton {
    UIButton *_hideButton = objc_getAssociatedObject(self, _cmd);
    if (!_hideButton) {
        _hideButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _hideButton.frame = CGRectMake(self.view.bounds.size.width/2-110, 260, 220, 44);
        _hideButton.backgroundColor = [UIColor brownColor];
        [_hideButton setTitle:@"Hide" forState:UIControlStateNormal];
        objc_setAssociatedObject(self, _cmd, _hideButton, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        [_hideButton addTarget:self action:@selector(button) forControlEvents:UIControlEventTouchUpInside];
    }
    return _hideButton;
}

//setter  第二个参数哈 。。。。
- (void)setHideButton:(UIButton *)hideButton {
    objc_setAssociatedObject(self, @selector(hideButton), hideButton, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}


- (void)button {
    NSLog(@"button");
}

- (void)showButton {
    NSLog(@"fsdfsd");
}


- (NSString *)addString {
    return objc_getAssociatedObject(self, &addStringKey);
}

- (void)setAddString:(NSString *)addString {
    objc_setAssociatedObject(self, &addStringKey, addString, OBJC_ASSOCIATION_COPY);
}

// - (void)setImageView:(UIImageView *)imageView {
//     objc_setAssociatedObject(self, &addStringKey, imageView, OBJC_ASSOCIATION_COPY_NONATOMIC);
// }

// - (UIImageView *)imageView {
//     return objc_getAssociatedObject(self, &addStringKey);
// }

/**
 感觉这个方法更巧妙一些，这样就不用定义那个不变的key了。。。
*/
- (UIImageView *)imageView {
 //注意第二个参数哈。。
   return objc_getAssociatedObject(self, _cmd);
}

- (void)setImageView:(UIImageView *)imageView {
 //注意第二个参数哈。。
   objc_setAssociatedObject(self, @selector(imageView), imageView, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

@end
