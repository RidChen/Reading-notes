//
//  HotCollectionViewCell.h
//  DummyTao
//
//  Created by 陈宇 on 2017/3/22.
//  Copyright © 2017年 陈宇. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HotCollectionViewCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UIImageView *mainImage;
@property (weak, nonatomic) IBOutlet UIImageView *subImage;
@property (weak, nonatomic) IBOutlet UIImageView *subSubImage;
@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UILabel *info;
@end
