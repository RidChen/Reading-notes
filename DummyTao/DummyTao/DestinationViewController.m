//
//  DestinationViewController.m
//  DummyTao
//
//  Created by 陈宇 on 2017/5/2.
//  Copyright © 2017年 陈宇. All rights reserved.
//

#import "DestinationViewController.h"

@interface DestinationViewController ()

@end

@implementation DestinationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor clearColor];
    UIView *alphaView = [[UIView alloc] initWithFrame:self.view.frame];
    UIView *baseView = [[UIView alloc] initWithFrame:self.view.frame];
    alphaView.backgroundColor = [UIColor clearColor];
    baseView.backgroundColor = [UIColor blackColor];
    baseView.alpha = 0.8;
    [self.view addSubview:baseView];
    [self.view addSubview:alphaView];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(20, 178, 100, 60);
    [button setTitle:@"点我返回" forState:UIControlStateNormal];
    button.backgroundColor = [UIColor brownColor];
    
    [alphaView addSubview:button];
    [button addTarget:self action:@selector(dissmiss) forControlEvents:UIControlEventTouchUpInside];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dissmiss{
    [self dismissViewControllerAnimated:YES completion:nil];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
