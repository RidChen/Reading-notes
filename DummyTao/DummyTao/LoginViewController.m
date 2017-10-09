//
//  LoginViewController.m
//  DummyTao
//
//  Created by 陈宇 on 2017/3/27.
//  Copyright © 2017年 陈宇. All rights reserved.
//

#import "LoginViewController.h"
#import "DataTransferManagement.h"
#import "DES3EncryptUtil.h"
#import "DataModel.h"
#import "MBProgressHUD.h"

@interface LoginViewController ()
@property (weak, nonatomic) IBOutlet UIButton *loginBtn;
@property (weak, nonatomic) IBOutlet UIButton *resetBtn;

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.passWord.delegate = self;
    self.userName.delegate = self;
    
    self.loginBtn.layer.borderColor = self.view.tintColor.CGColor;
    self.resetBtn.layer.borderColor = self.view.tintColor.CGColor;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)tapLoginBtn:(UIButton *)sender {
    NSDictionary* dict = @{@"username":self.userName.text, @"password":[DES3EncryptUtil encrypt:self.passWord.text]};
    DataTransferRequest* request = [[DataTransferRequest alloc] initWithToken:nil andDictionary:dict];
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{
        dispatch_async(dispatch_get_main_queue(), ^{
            [MBProgressHUD hideHUDForView:self.view animated:YES];
        });
    });
    
    [[DataTransferManagement sharedInstance] sendRequest:DataRequestTypeLogin withParameters:request andResponse:^(DataResultType result, DataTransferResponse *response) {
        NSLog(@"Login resonse:%@", response);
        if (DataResultTypeSuccess == result) {
            [[DataModel sharedInstance] saveData:DataTypeUserInfomation andDictionary:response.dict[@"data"]];
            [self performSegueWithIdentifier:@"loginToMsg" sender:self];
        } else if (DataResultTypeInvalidAccount == result) {
            MBProgressHUD* progress = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
            
            progress.mode = MBProgressHUDModeText;
            progress.label.text = @"用户名或密码错误,请重新输入";
            progress.margin = 10.0f;
            progress.removeFromSuperViewOnHide = YES;
            [progress hideAnimated:YES afterDelay:3];
            
            _passWord.text = @"";
            _userName.text = @"";
        } else {
            
        }
    }];
}

- (IBAction)tapResetBtn:(UIButton *)sender {
    _userName.text = @"";
    _passWord.text = @"";
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    return [textField resignFirstResponder];
}

@end
