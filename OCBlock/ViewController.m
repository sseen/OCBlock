//
//  ViewController.m
//  OCBlock
//
//  Created by sseen on 16/6/21.
//  Copyright © 2016年 sseen. All rights reserved.
//

#import "ViewController.h"
#import "Person.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 对于这篇文章的 分析 http://www.jianshu.com/p/d0d7b519fec1
    // 截获 基础类型
    int oc = 20;
    void (^block)() = ^{
        NSLog(@"value = %d",  oc);
    };
    oc = 30;
    block(); // value = 20
    /*
     
     因为block内部拷贝了截获的变量的副本，所以生成block后再修改变量，不会影响被block截获的变量。同时block内部也不能修改这个变量。
     OC的block会截获外部变量，对于int等基本数据类型，block的内部会拷贝一份，简单来说，它的实现大概是这样的：
     
     struct block_impl {
        //其它内容
        int value;
     };
     
    */
    
    /**
     *  截获 指针
     */
    Person *one = [[Person alloc] initWithName:@"str"];
    void (^blockPoint)() = ^{
        one.name = @"new name"; //OK，没有改变p
        //编译错误
        // one = [[Person alloc] initWithName:@"new name"];
        NSLog(@"person name = %@", one.name);
    };
    blockPoint();
    
    __block Person *p = [[Person alloc] initWithName:@"zxy"];
    void(^blockPoint2)() = ^{
        NSLog(@"person name = %@", p.name);
    };
    
    p = nil;
    blockPoint2();
    // 打印结果是："person name = (null)"
 
    
    /**
     *  强引用
     */
    
    if (true) {
        __block Person *p = [[Person alloc] initWithName:@"zxy"];
        block = ^{
            NSLog(@"person name = %@", p.name);
        };
    }
    block();
    
    // 打印结果是："person name = zxy"
    
    if (true) {
        Person *p = [[Person alloc] initWithName:@"yxz"];
        block = ^{
            NSLog(@"person name = %@", p.name);
        };
    }
    block();
    // 如果没有retain被标记为__block的指针p，那么超出作用于后应该会得到nil。
    
    
}


@end
