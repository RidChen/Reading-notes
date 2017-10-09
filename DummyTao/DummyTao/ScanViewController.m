//
//  ScanViewController.m
//  DummyTao
//
//  Created by 陈宇 on 2017/4/1.
//  Copyright © 2017年 陈宇. All rights reserved.
//

#import "ScanViewController.h"
#import <MBProgressHUD/MBProgressHUD.h>

@interface ScanViewController ()
@end

@implementation ScanViewController

-(void) doSomethingInBackgroundWithProgressCallback:(void(^)(float progress))progressCallback completionCallback:(void(^)(void)) completionCallback{
    __block NSInteger repeatTimes = 5;
    [NSTimer scheduledTimerWithTimeInterval:2 repeats:YES block:^(NSTimer * _Nonnull timer) {
        if (repeatTimes > 0) {
            repeatTimes--;
            if (nil != progressCallback) {
                progressCallback(0.2f * (5 - repeatTimes));
            }
        } else {
            if (nil != completionCallback) {
                completionCallback();
            }
            [timer invalidate];
        }
    }];
}

-(NSProgress*)doSomethingInBackgroundCompletion:(void(^)(void)) completionCallback {
    __block NSProgress *progress = [NSProgress progressWithTotalUnitCount:100];
    
    [NSTimer scheduledTimerWithTimeInterval:0.1 repeats:YES block:^(NSTimer * _Nonnull timer) {
        if (progress.completedUnitCount < progress.totalUnitCount) {
            progress.completedUnitCount += 1;
        } else {
            [timer invalidate];
            if (nil != completionCallback) {
                completionCallback();
            }
        }
    }];
    return progress;
}

-(void)doSomethingInBackground:(UIView*)imageview withcompletionCallback:(void(^)(void))completionCallback {
    __block NSInteger imageIndex = 0;
    __block NSUInteger currentCount = 0;
    NSUInteger repeatCount = 3;
    NSArray* imageNameArr = @[@"dongying-26", @"dongying-27", @"dongying-28"];
    [NSTimer scheduledTimerWithTimeInterval:2 repeats:YES block:^(NSTimer * _Nonnull timer) {
        if (currentCount < repeatCount) {
            currentCount++;
            imageIndex++;
            switch (imageIndex) {
                case 0:
                case 1:
                case 2:
                    [((UIImageView*)imageview) setImage:[UIImage imageNamed:imageNameArr[imageIndex]]];
                    break;
                default:
                    imageIndex = 0;
                    break;
            }
        } else {
            [timer invalidate];
            if (nil != completionCallback) {
                completionCallback();
            }
        }
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    MBProgressHUD *horizontalBar = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    horizontalBar.mode = MBProgressHUDModeDeterminateHorizontalBar;
    horizontalBar.label.text = @"Loading";
    horizontalBar.animationType = MBProgressHUDAnimationFade;
    [horizontalBar setOffset:CGPointMake(0, -160)];
    NSProgress *progress = [self doSomethingInBackgroundCompletion:^{
        [horizontalBar hideAnimated:YES];
    }];
    horizontalBar.progressObject = progress;
    
    MBProgressHUD *annularDeterminate = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    annularDeterminate.mode = MBProgressHUDModeAnnularDeterminate;
    annularDeterminate.label.text = @"Loading";
    annularDeterminate.animationType = MBProgressHUDAnimationZoom;
    [annularDeterminate setOffset:CGPointMake(-120, -50)];
    [self doSomethingInBackgroundWithProgressCallback:^(float progress) {
        annularDeterminate.progress = progress;
    } completionCallback:^{
        [annularDeterminate hideAnimated:YES];
    }];
    
    MBProgressHUD *indeterminate = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    indeterminate.mode = MBProgressHUDModeIndeterminate;
    indeterminate.label.text = @"Loading";
    indeterminate.animationType = MBProgressHUDAnimationZoomOut;
    [indeterminate setOffset:CGPointMake(0, -50)];
    [self doSomethingInBackgroundWithProgressCallback:^(float progress) {
        indeterminate.progress = progress;
    } completionCallback:^{
        [indeterminate hideAnimated:YES];
    }];
    
    MBProgressHUD *determinate = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    determinate.mode = MBProgressHUDModeDeterminate;
    determinate.label.text = @"Loading";
    determinate.animationType = MBProgressHUDAnimationZoomIn;
    [determinate setOffset:CGPointMake(120, -50)];
    [self doSomethingInBackgroundWithProgressCallback:^(float progress) {
        determinate.progress = progress;
    } completionCallback:^{
        [determinate hideAnimated:YES];
    }];
    
    MBProgressHUD *customView = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    customView.mode = MBProgressHUDModeCustomView;
    customView.label.text = @"Loading";
    customView.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"dongying-26"]];
    [customView setOffset:CGPointMake(0, 130)];
    [self doSomethingInBackground:customView.customView withcompletionCallback:^{
        [customView hideAnimated:YES];
    }];
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

@end
