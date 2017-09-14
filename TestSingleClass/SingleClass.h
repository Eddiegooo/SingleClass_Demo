//
//  SingleClass.h
//  TestSingleClass
//
//  Created by FQL on 2017/9/14.
//  Copyright © 2017年 FQL. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SingleClass : NSObject
//设置一个只读属性，不可以改变。 这种属性全局用一个宏也可以代替吧。
@property (nonatomic, strong, readonly) NSString *name;

//设置属性，供外面全局使用
@property (nonatomic, strong) NSString *interesting;
@property (nonatomic, assign) NSInteger age;

//设置一个特定属性，直接访问这个属性，得到具体你设置的那个值，所以用重写get方法。
//这完全可以用这个方法代替：- (BOOL)isLogin; 方法实现那里加上get方法的内容就是了。。
@property (nonatomic, assign) BOOL isLogin;


+(instancetype)shareSingleClass;

//更新单例属性的值
- (void)updateData;

//单例方法
- (void)singleClassMethod;

@end
