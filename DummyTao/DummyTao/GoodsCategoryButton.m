//
//  GoodsCategoryButton.m
//  DummyTao
//
//  Created by 陈宇 on 2017/3/29.
//  Copyright © 2017年 陈宇. All rights reserved.
//

#import "GoodsCategoryButton.h"

@implementation GoodsCategoryButton

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    _lineImage.hidden = YES;
    _numLab.text = @"0";
}

- (IBAction)tapTopButton:(UIButton *)sender {
    if (nil != _delegate && [_delegate respondsToSelector:@selector(tapTopButton:)]) {
        [_delegate tapTopButton:sender];
    }
}
    
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
    
@end
