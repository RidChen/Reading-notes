//
//  CatCollectionViewFooter.m
//  DummyTao
//
//  Created by 陈宇 on 2017/3/24.
//  Copyright © 2017年 陈宇. All rights reserved.
//

#import "CatCollectionViewFooter.h"
#import "CustomNavModel.h"

@implementation CatCollectionViewFooter

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    [NSTimer scheduledTimerWithTimeInterval:UI_TIMER_CLT_FOOTER_DURATION target:self selector:@selector(autoUpdateMainText:) userInfo:nil repeats:YES];
}

- (void) autoUpdateMainText:(NSTimer*)timer {
    CustomNavModel* model = [CustomNavModel sharedModel];
    
    if (model.footer.count > 0) {
        int index = arc4random() % model.footer.count;
        NSMutableString* text = [[NSMutableString alloc] initWithString:model.footer[index]];
        
        [text appendString:@"\n"];
        [text appendString:model.footer[index + 1 == model.footer.count ? 0 : index + 1]];
        _mainTextView.text = text;
    }
}

@end
