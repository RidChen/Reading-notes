//
//  LoginViewController.h
//  DummyTao
//
//  Created by 陈宇 on 2017/3/27.
//  Copyright © 2017年 陈宇. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoginViewController : UIViewController<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *userName;
@property (weak, nonatomic) IBOutlet UITextField *passWord;
- (IBAction)tapLoginBtn:(UIButton *)sender;

- (IBAction)tapResetBtn:(UIButton *)sender;

@end
