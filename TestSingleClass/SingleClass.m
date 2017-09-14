//
//  SingleClass.m
//  TestSingleClass
//
//  Created by FQL on 2017/9/14.
//  Copyright © 2017年 FQL. All rights reserved.
//

#import "SingleClass.h"

@implementation SingleClass

//初始化单例
+(instancetype)shareSingleClass {
    static SingleClass *singleClass = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        singleClass = [[SingleClass alloc] init];
    });
    return singleClass;
}

//在这里设置属性的初始值，readonly属性也可以
- (instancetype)init
{
    self = [super init];
    if (self) {
        _age = 18;
        _interesting = @"play";
        _name = @"Eddie";
    }
    return self;
}

//如果你重写了get，这个属性值就再也变化不了了.***这根本就不是设置初始值方法***
/*!
 *  如果你用写了一个属性name,系统会自动生成getter 和setter 方法以及一个实例变量_name, 你可以重写其中的一个方法; 如果两个都重写,就会报"undeclared identifier"的错误..
 */
//- (NSString *)name {
//    return @"Eddie";
//}


/*!
 *  @brief 比如：判断登录状态，不想用方法，直接用属性代替，所以重写get方法.
    这样以后每次访问这个属性，就是这个方法的值，固定的。 这完全可以用一个方法替代
 */
- (BOOL)isLogin {
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    NSInteger userId = [userDefault integerForKey:@"userId"];
    BOOL isLogin = (userId == 0) ? NO : YES;
    return isLogin;
}


- (void)updateData {
    //直接就在这里修改属性的值
    [SingleClass shareSingleClass].interesting = @"Run";
}

- (void)singleClassMethod {
    //具体实现什么，就在这里实现嘛。。
}

@end
