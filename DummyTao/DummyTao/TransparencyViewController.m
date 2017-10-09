//
//  TransparencyViewController.m
//  DummyTao
//
//  Created by 陈宇 on 2017/5/2.
//  Copyright © 2017年 陈宇. All rights reserved.
//

#import "TransparencyViewController.h"
#import "DestinationViewController.h"

@interface TransparencyViewController ()
@end

@implementation TransparencyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UIButton *test = [[UIButton alloc] initWithFrame: CGRectMake(80, 80, 60, 40)];
    
    
    [test addTarget:self action:@selector(pressButton:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:test];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)pressButton:(UIButton *)sender {
    DestinationViewController *dVC = [[DestinationViewController alloc] init];
    
    [self.navigationController pushViewController:dVC animated:YES];
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
