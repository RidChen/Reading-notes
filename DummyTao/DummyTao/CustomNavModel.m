//
//  CustomNavModel.m
//  DummyTao
//
//  Created by 陈宇 on 2017/3/17.
//  Copyright © 2017年 陈宇. All rights reserved.
//

#import "CustomNavModel.h"
#import "GoodsCategory.h"
#import "HotGoods.h"
#import "CheepGoods.h"
#import "CommonHeaderModel.h"
#import "UIKit/UIKit.h"

static id _instance;

@implementation CustomNavModel
- (instancetype)init {
    if (self = [super init]) {
         _goodsCategory = @[
                           [[GoodsCategory alloc] initGoodsCategory:@"地猫" imageNamed:@"地猫"],
                           [[GoodsCategory alloc] initGoodsCategory:@"巨便宜" imageNamed:@"巨便宜"],
                           [[GoodsCategory alloc] initGoodsCategory:@"地猫国际" imageNamed:@"地猫国际"],
                           [[GoodsCategory alloc] initGoodsCategory:@"外卖" imageNamed:@"外卖"],
                           [[GoodsCategory alloc] initGoodsCategory:@"地猫超市" imageNamed:@"地猫超市"],
                           [[GoodsCategory alloc] initGoodsCategory:@"充值大厅" imageNamed:@"充值大厅"],
                           [[GoodsCategory alloc] initGoodsCategory:@"领盒饭" imageNamed:@"领盒饭"],
                           [[GoodsCategory alloc] initGoodsCategory:@"飞翔旅行" imageNamed:@"飞翔旅行"],
                           [[GoodsCategory alloc] initGoodsCategory:@"到家" imageNamed:@"到家"],
                           [[GoodsCategory alloc] initGoodsCategory:@"分类" imageNamed:@"分类"],
                           ];
        
        _hotGoods = @[
                      [[HotGoods alloc] initHotGoods:@"爱抢购" mainInfo:@"进入查看更多" mainImage:@"爱抢购_1" subImage:@"carrot" subSubImage:@"medal" titleColor:[UIColor redColor]],
                      [[HotGoods alloc] initHotGoods:@"爱抢购" mainInfo:@"进入查看更多" mainImage:@"爱抢购_2" subImage:@"chilli" subSubImage:@"medal" titleColor:[UIColor redColor]],
                      [[HotGoods alloc] initHotGoods:@"有好货" mainInfo:@"高颜值美物" mainImage:@"有好货_1" subImage:@"cucumber" subSubImage:@"bag" titleColor:[UIColor blueColor]],
                      [[HotGoods alloc] initHotGoods:@"有好货" mainInfo:@"高颜值美物" mainImage:@"有好货_2" subImage:@"egg-plant" subSubImage:@"bag" titleColor:[UIColor blueColor]],
                      [[HotGoods alloc] initHotGoods:@"爱逛街" mainInfo:@"时髦研究所" mainImage:@"爱逛街_1" subImage:@"peas" subSubImage:@"shop" titleColor:[UIColor orangeColor]],
                      [[HotGoods alloc] initHotGoods:@"爱逛街" mainInfo:@"时髦研究所" mainImage:@"爱逛街_2" subImage:@"potato" subSubImage:@"shop" titleColor:[UIColor orangeColor]],
                      [[HotGoods alloc] initHotGoods:@"必买清单" mainInfo:@"都整理好啦" mainImage:@"必买_1" subImage:@"pumpkin" subSubImage:@"lens" titleColor:[UIColor magentaColor]],
                      [[HotGoods alloc] initHotGoods:@"必买清单" mainInfo:@"都整理好啦" mainImage:@"必买_2" subImage:@"radish" subSubImage:@"lens" titleColor:[UIColor magentaColor]]
                      ];
        _hotOffset = 0;
        _cheepGoods = @[
                        [[CheepGoods alloc] initWithCheepGoodsInfo:@"非常大牌" subTitle:@"当季大牌买不停" imagePath:@"diamond_life_15" type:CheepGoodsTypeBig],
                        [[CheepGoods alloc] initWithCheepGoodsInfo:@"全球精选" subTitle:@"享受品质生活" imagePath:@"computerdesk-8" type:CheepGoodsTypeSmall],
                       [[CheepGoods alloc] initWithCheepGoodsInfo:@"量贩优选" subTitle:@"1分钱疯抢" imagePath:@"APE_T-shirt_04" type:CheepGoodsTypeSmall],
                       [[CheepGoods alloc] initWithCheepGoodsInfo:@"聚名品" subTitle:@"女神的心机" imagePath:@"lv_handbags_02" type:CheepGoodsTypeSmall],
                       [[CheepGoods alloc] initWithCheepGoodsInfo:@"天天特价" subTitle:@"每日精选前款好货" imagePath:@"diamond_life_09" type:CheepGoodsTypeBig],
                       [[CheepGoods alloc] initWithCheepGoodsInfo:@"品牌店庆" subTitle:@"底至9.9元" imagePath:@"dongying-10" type:CheepGoodsTypeSmall],
                       [[CheepGoods alloc] initWithCheepGoodsInfo:@"魅力惠" subTitle:@"爱尚新自我" imagePath:@"lv_handbags_14" type:CheepGoodsTypeSmall],
                       [[CheepGoods alloc] initWithCheepGoodsInfo:@"品牌清仓" subTitle:@"好货超便宜" imagePath:@"tealife-2" type:CheepGoodsTypeSmall]];
        
        _cheepHeader = [[CommonHeaderModel alloc] initWithTitle:@"超实惠" icon:@"medal-gold"];
    }
    return self;
}

+ (instancetype)sharedModel {
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        _instance = [[self alloc] init];
    });
    
    return _instance;
}

+ (instancetype)allocWithZone:(struct _NSZone *)zone {
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        _instance = [super allocWithZone:zone];
    });
    return _instance;
}

- (id)copyWithZone:(NSZone *)zone {
    return _instance;
}

- (void) requestFooterInfomation:(void (^)(CMResultType result, NSArray* info)) response {
    [NSTimer scheduledTimerWithTimeInterval:1 repeats:NO block:^(NSTimer * _Nonnull timer) {
        NSArray* dummyString = [[NSArray alloc] initWithObjects:
                                @"宝宝用过的尿不湿不要扔，它还有二次作用",
                                @"过了40别批头散发，这些气质发型好打理",
                                @"五菱宏光带你秋名山飙车！",
                                @"Iphone这个烦人的功能，竟能这样关",
                                @"牛仔裤上为什么有个小口袋",
                                @"怎样防止雾霾！",
                                @"宝宝晚上睡不着觉，两招叫你解决！",
                                nil];
        response(CMResultTypeSuccess, dummyString);
    }];
    
}

- (void) requestRecommendedInfo:(void (^)(CMResultType result, NSArray* info)) response {
    [NSTimer scheduledTimerWithTimeInterval:1 repeats:NO block:^(NSTimer * _Nonnull timer) {
        NSArray* dummyString = [[NSArray alloc] initWithObjects:
                                @"最新Iphone8",
                                @"安儿宝A+",
                                @"大王纸尿裤",
                                @"喜宝奶粉",
                                @"美赞臣3段",
                                @"花丸纸尿裤",
                                @"露安适纸尿裤",
                                @"露安适润肤油",
                                @"Snoy Xperia X",
                                nil];
        response(CMResultTypeSuccess, dummyString);
    }];
}

- (NSDictionary*) userInformation {
    if (_userInformation == nil) {
        _userInformation = [[NSMutableDictionary alloc] init];
    }
    return _userInformation;
}
@end
