//
//  GoodsCategoryButton.h
//  DummyTao
//
//  Created by 陈宇 on 2017/3/29.
//  Copyright © 2017年 陈宇. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol GoodsCategoryButtonDelegate <NSObject>

-(void)tapTopButton:(UIButton*) sender;

@end

@interface GoodsCategoryButton : UIView
@property (weak, nonatomic) IBOutlet UIButton *mainBtn;
@property (weak, nonatomic) IBOutlet UILabel *numLab;
@property (weak, nonatomic) IBOutlet UIImageView *lineImage;
@property (weak, nonatomic) id<GoodsCategoryButtonDelegate> delegate;
@end
