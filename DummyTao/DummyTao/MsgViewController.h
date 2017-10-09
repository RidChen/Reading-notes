//
//  MsgViewController.h
//  DummyTao
//
//  Created by 陈宇 on 2017/3/20.
//  Copyright © 2017年 陈宇. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GoodsCategoryButton.h"

@interface MsgViewController : UIViewController <GoodsCategoryButtonDelegate>
@property (nonatomic, strong) NSArray* topBtns;
@end
