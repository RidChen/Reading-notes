//
//  MainViewController.m
//  testApp
//
//  Created by 陈宇 on 2017/7/29.
//  Copyright © 2017年 陈宇. All rights reserved.
//

#import "MainViewController.h"
#import "objc/runtime.h"
#import "UIViewController+Tracing.h"

@interface MainViewController ()

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self testObjectAndClassObjectAndMetaClassAndRootMetaClass];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// 测试对象、类对象、元类与根元类
- (void) testObjectAndClassObjectAndMetaClassAndRootMetaClass {
    UIView *anObject = [[UIView alloc] init]; // 指向对象本身
    Class anObjectClass = [anObject class]; // 对象的class函数，即访问对象的isa，指向类的对象
    Class getClassOfTheObejct = object_getClass(anObject); // 与上面等价，访问对象的isa，指向类的对象
    Class aClass = [UIView class];
    Class metaClass = object_getClass(aClass); // 访问类对象的isa，指向元类对象
    Class rootMetaClassOfTheClass = object_getClass(metaClass); // 访问元类对象的isa，访问根元类对象
    Class getClassOfRootMetaClass = object_getClass(rootMetaClassOfTheClass); // 访问根元类对象的isa，指向根元类本身
    
    NSLog(@"anObject == %p", anObject);
    NSLog(@"[anObject class] == %p", anObjectClass);
    NSLog(@"object_getClass(anObject) == %p", getClassOfTheObejct);
    NSLog(@"[UIView class] == %p", aClass);
    NSLog(@"metaClass: object_getClass(aClass) == %p", metaClass);
    NSLog(@"rootMetaClass: rootMetaClass == %p", rootMetaClassOfTheClass);
    NSLog(@"object_getClass(rootMetaClass) == %p", getClassOfRootMetaClass);
    NSLog(@"");
    
    UIViewController *aVC = [[UIViewController alloc] init];
    
    Class metaClassOfVC = object_getClass(object_getClass(aVC));
    Class rootMetaClassOfVC = object_getClass(object_getClass(object_getClass(aVC)));
    NSLog(@"metaClassOfVC == %p", metaClassOfVC); // 元类与UIView不一样
    NSLog(@"rootMetaClassOfVC == %p", rootMetaClassOfVC); // 根元类与UIView一样
}

// 字典转化为模型
-(void)testDictionaryToModel {
    NSDictionary *dummyJSON = @{
                                @"name": @"Jacky Chen",
                                @"age": @50,
                                @"height": @181.5,
                                @"son": @{
                                        @"name": @"Franky Chen",
                                        @"age": @20,
                                        @"height": @170
                                        }
                                };
}
@end
