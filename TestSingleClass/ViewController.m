//
//  ViewController.m
//  TestSingleClass
//
//  Created by FQL on 2017/9/14.
//  Copyright © 2017年 FQL. All rights reserved.
//

#import "ViewController.h"
#import "SingleClass.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    //直接访问原来默认的值
    NSLog(@"old interesting = %@",[SingleClass shareSingleClass].interesting);
    
    //直接修改属性值
    [SingleClass shareSingleClass].interesting = @"Play football";
    NSLog(@"interesting = %@",[SingleClass shareSingleClass].interesting);
    
}

-(void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    //直接修改属性值
    [SingleClass shareSingleClass].interesting = @"Play Two Ball";
    NSLog(@"new interesting = %@",[SingleClass shareSingleClass].interesting);
    
    //三秒之后更新单例某一个属性的值
    [self performSelector:@selector(changeSingleClassPropertyData) withObject:nil afterDelay:3.0];
    
}

- (void)changeSingleClassPropertyData {
    [[SingleClass shareSingleClass] updateData];
    NSLog(@"3s late new interesting = %@",[SingleClass shareSingleClass].interesting);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
