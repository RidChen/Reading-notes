//
//  MsgViewController.m
//  DummyTao
//
//  Created by 陈宇 on 2017/3/20.
//  Copyright © 2017年 陈宇. All rights reserved.
//

#import "MsgViewController.h"
#import "DataTransferManagement.h"
#import "DataModel.h"

@interface MsgViewController ()
    
    @end

@implementation MsgViewController
    
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initTopButtons];
    [self loadGoodsData];
}
    
-(void)initTopButtons {
    CGFloat widthPerBtn = self.view.bounds.size.width / 5;
    
    GoodsCategoryButton* _unPayedBtn = [[[NSBundle mainBundle] loadNibNamed:@"GoodsCategoryButton" owner:nil options:nil] firstObject];
    _unPayedBtn.frame = CGRectMake(UI_MSG_UNPAYED_X, UI_MSG_UNPAYED_Y, widthPerBtn, UI_MSG_UNPAYED_HEIGHT);
    [_unPayedBtn.mainBtn setTitle:@"代付款" forState:UIControlStateNormal];
    _unPayedBtn.lineImage.hidden = NO;
    _unPayedBtn.delegate = self;
    [self.view addSubview:_unPayedBtn];
    
    GoodsCategoryButton* _unSendedBtn = [[[NSBundle mainBundle] loadNibNamed:@"GoodsCategoryButton" owner:nil options:nil] firstObject];
    _unSendedBtn.frame = CGRectMake(widthPerBtn, UI_MSG_UNSENDED_Y, widthPerBtn, UI_MSG_UNSENDED_HEIGHT);
    [_unSendedBtn.mainBtn setTitle:@"未发货" forState:UIControlStateNormal];
    _unSendedBtn.delegate = self;
    [self.view addSubview:_unSendedBtn];
    
    GoodsCategoryButton* _sendedBtn = [[[NSBundle mainBundle] loadNibNamed:@"GoodsCategoryButton" owner:nil options:nil] firstObject];
    _sendedBtn.frame = CGRectMake(widthPerBtn * 2, UI_MSG_SENDED_Y, widthPerBtn, UI_MSG_SENDED_HEIGHT);
    [_sendedBtn.mainBtn setTitle:@"已发货" forState:UIControlStateNormal];
    _sendedBtn.delegate = self;
    [self.view addSubview:_sendedBtn];
    
    GoodsCategoryButton* _unCommentedBtn = [[[NSBundle mainBundle] loadNibNamed:@"GoodsCategoryButton" owner:nil options:nil] firstObject];
    _unCommentedBtn.frame = CGRectMake(widthPerBtn * 3, UI_MSG_UNCOMMENT_Y, widthPerBtn, UI_MSG_UNCOMMENT_HEIGHT);
    [_unCommentedBtn.mainBtn setTitle:@"待评价" forState:UIControlStateNormal];
    _unCommentedBtn.delegate = self;
    [self.view addSubview:_unCommentedBtn];
    
    GoodsCategoryButton* _finishedBtn = [[[NSBundle mainBundle] loadNibNamed:@"GoodsCategoryButton" owner:nil options:nil] firstObject];
    _finishedBtn.frame = CGRectMake(widthPerBtn * 4, UI_MSG_FINISH_Y, widthPerBtn, UI_MSG_FINISH_HEIGHT);
    [_finishedBtn.mainBtn setTitle:@"已完成" forState:UIControlStateNormal];
    _finishedBtn.delegate = self;
    [self.view addSubview:_finishedBtn];
    
    _topBtns = [[NSArray alloc] initWithObjects:_unPayedBtn, _unSendedBtn, _sendedBtn, _unCommentedBtn, _finishedBtn, nil];
}
    
-(void)loadGoodsData {
    UserInformation* userInfo = [DataModel sharedInstance].userInfo;
    DataTransferRequest* requset = [[DataTransferRequest alloc] initWithToken:userInfo.token andDictionary:[[NSDictionary alloc] initWithObjectsAndKeys:userInfo.siteId, @"siteId", userInfo.userId, @"userId", @"0", @"orderStatus", @"1", @"pageNum", @"12", @"pageSize",nil]];
    [[DataTransferManagement sharedInstance] sendRequest:DataRequestTypeGetOrderList withParameters:requset andResponse:^(DataResultType result, DataTransferResponse *response) {
        NSLog(@"getOrder response:%@", response);
    }];
}
    
-(void)tapTopButton:(UIButton*) sender {
    for (GoodsCategoryButton* goodsBtn in _topBtns) {
        if ([goodsBtn.mainBtn.currentTitle isEqualToString:sender.currentTitle]) {
            goodsBtn.lineImage.hidden = NO;
        } else if (!goodsBtn.lineImage.hidden){
            goodsBtn.lineImage.hidden = YES;
        }
    }
}
    
-(void)tapBackBtn:(UIButton*)sender {
    [self.navigationController popToRootViewControllerAnimated:YES];
}
    
- (void)viewWillAppear:(BOOL)animated {
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStyleDone target:self action:@selector(tapBackBtn:)];
    self.navigationItem.hidesBackButton = YES;
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
