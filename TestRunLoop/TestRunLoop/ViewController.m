//
//  ViewController.m
//  TestRunLoop
//
//  Created by FQL on 2017/9/15.
//  Copyright © 2017年 FQL. All rights reserved.
//

#import "ViewController.h"
#import <objc/runtime.h>
#import "ViewController_VC_Extension.h"
#import "ViewController+AddCategory.h"


@interface ViewController ()

@end


/*!
 *  @brief Run Loop 进行时
 *  1、创建一个分类，可以添加属性和方法
 *  2、属性添加重写setter 、getter方法；  带有事件的属性，第二个属性可以用_cmd代替
 *  3、替换方法： 一般在load方法里，用dispatch_once方法，保证先拦截你要替换的方法，在自定义你准备替换的方法，实现这个替换的方法
 *  4、
 */

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    NSLog(@"my method = %s",__func__);
    
    [self VCExtensionMethod];
    
    [self addMethod];
    
    [ViewController someClassMethod];
    
}

/*!
 *  @brief 类方法必须要实现哎，不然就crash了
 */
+(void)someClassMethod {
    NSLog(@"到底执行哪个呢????  还真是执行改写的那个哎");
}

- (void)VCExtensionMethod {
    NSLog(@"===sfdsf");

    
    self.customTitle = @"testTitle";
    self.title = self.customTitle;
    
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
